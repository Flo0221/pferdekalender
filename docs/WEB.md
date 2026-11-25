# Pferdekalender als Web-App (PWA) – iPhone-Testlauf

Die Android-App bleibt die Hauptversion. Die Web-App ist derselbe Code
(Flutter Web) und dient zum Ausprobieren auf dem iPhone, solange es keinen
iOS-Build gibt.

## Was ist anders als in der Android-App?

| Thema | Android | Web-App |
|---|---|---|
| Speicher | SQLite-Datei + Fotos im App-Ordner | SQLite (WebAssembly) im Browser-Speicher (IndexedDB, wo möglich OPFS); Fotos als Blobs in der Datenbank (max. 1600 px, JPEG 80 %) |
| Erinnerungen | Benachrichtigungen | **keine** Benachrichtigungen. Stattdessen: Karte „Auf einen Blick“ im Pflege-Tab, Termine als `.ics` in den iPhone-Kalender (mit Erinnerung), App-Abzeichen, wo der Browser es kann |
| Datensicherung | ZIP teilen/speichern | gleiches ZIP-Format, über „Teilen“ bzw. Download. Sicherungen sind zwischen Android und Web austauschbar |
| Netzwerk | keine INTERNET-Permission | lädt nur Dateien von der eigenen Adresse (beim ersten Öffnen), danach komplett offline. Kein CDN, keine Google-Schriften – im CI geprüft |

## Auf dem iPhone installieren

1. Die Adresse in **Safari** öffnen: `https://<github-name>.github.io/pferdekalender/`
2. Unten auf **Teilen** (Quadrat mit Pfeil) → **Zum Home-Bildschirm** → **Hinzufügen**.
3. Die App **nur über das neue Symbol** öffnen und erst dort Daten eintragen.
   Browser-Tab und installierte App haben bei Safari **getrennte Speicher**;
   im Tab zeigt die App deshalb einen roten Hinweis.
4. In der App: Einstellungen → „Speicher im Browser“ zeigt, ob der Speicher
   dauerhaft ist und wie viel belegt ist.

**Wichtig:** Werden in Safari die Website-Daten gelöscht oder wird die App
vom Home-Bildschirm entfernt, sind **alle Daten weg**. Safari kann die Daten
einer Website außerdem löschen, wenn sie mehrere Wochen nicht geöffnet
wurde – installierte Home-Bildschirm-Apps sind davon in der Regel
ausgenommen. Deshalb regelmäßig exportieren (Einstellungen → Datensicherung;
die App erinnert nach 7 Tagen).

## Updates

Nach einem neuen Deploy lädt der Service Worker die neue Version im
Hintergrund. Die App zeigt dann **„Neue Version verfügbar – jetzt neu laden“**
und lädt erst nach Antippen neu (nie mitten in einer Eingabe). Die Version
steht in Einstellungen → Über.

## Hosting

### GitHub Pages (eingerichtet)

Der Workflow `.github/workflows/web.yml` läuft bei jedem Push auf `main`:
Secrets-Check → Format/Analyse → Tests → `tool/build_web.sh` → Browser-Check
(`tool/check_web_requests.mjs`) → Deploy auf Pages.

Einmalig von dir einzuschalten (aus der Cloud-Sitzung nicht möglich):
**GitHub → Repository → Settings → Pages → Build and deployment →
Source: „GitHub Actions“.** Danach den Workflow unter *Actions → Web-App →
Run workflow* starten.

Bitte beachten:

- **Pages bei privaten Repositories** gibt es nur mit einem bezahlten Plan
  (GitHub Pro, Team oder Enterprise). Mit GitHub Free ist die Option für
  private Repos ausgegraut.
- **Die Pages-Adresse ist öffentlich erreichbar**, auch wenn das Repository
  privat ist (Zugriffsschutz nur bei Enterprise Cloud). Öffentlich ist dabei
  nur der App-Code – **deine Daten liegen ausschließlich auf deinem Gerät**.
  Die Adresse ist nicht verlinkt, aber erratbar.

### Falls Pages im privaten Repo nicht geht – Optionen

Ich stelle nichts davon ohne deine Entscheidung um:

1. **GitHub Pro** (kostenpflichtig) – alles bleibt wie eingerichtet.
2. **Repository öffentlich machen** – Pages ist dann kostenlos. Vorher
   `tool/check_secrets.sh` (läuft auch im CI); Stand jetzt: keine Secrets,
   Keystores oder persönlichen Testdaten im Repo und in der Historie.
   Der Branch `apk` enthält eine Debug-signierte Test-APK.
3. **Zweites, öffentliches Repo nur mit dem Build** (`build/web`), z. B.
   `pferdekalender-web` – der Quellcode bleibt privat.
4. **Cloudflare Pages oder Netlify** (kostenlos, privates Repo möglich) –
   statisches Hosting; Build lokal oder per CI, Basis-Pfad dann `/`
   (`tool/build_web.sh /`).

### Lokal testen

```bash
tool/build_web.sh
```

```bash
npm install --no-save playwright@1.63.0 && node tool/check_web_requests.mjs
```

Zum Ausprobieren im Browser: `build/web` unter `/pferdekalender/` ausliefern,
z. B. `mkdir -p /tmp/srv && ln -s "$PWD/build/web" /tmp/srv/pferdekalender && python3 -m http.server -d /tmp/srv 8080`
→ `http://localhost:8080/pferdekalender/`.

## Technik

- **Datenbank:** `drift` mit `web/sqlite3.wasm` und `web/drift_worker.js`
  (beide eingecheckt; neu erzeugen mit `tool/build_web_assets.sh`, z. B.
  nach einem sqlite3-/drift-Update). Drift wählt automatisch: OPFS braucht
  `SharedArrayBuffer` und damit COOP/COEP-Header, die GitHub Pages nicht
  setzen kann → in der Praxis **IndexedDB**. Das ist dauerhaft und für die
  Datenmengen der App ausreichend.
- **Plattform-Weiche:** `lib/core/platform/web_env.dart` (Conditional Import
  `web_env_web.dart` / `web_env_stub.dart`), `kIsWeb` für Fotos
  (`DbPhotoStore`) und Benachrichtigungen (`UnsupportedNotificationGateway`).
- **Kein CDN:** `--no-web-resources-cdn` (CanvasKit lokal),
  `web/flutter_bootstrap.js` setzt `canvasKitBaseUrl` und
  `fontFallbackBaseUrl` auf lokale Pfade. Schriften: Roboto + `PkSymbols`
  (Teilmenge von DejaVu Sans für →, ★ …). Test `web_glyphs_test.dart` prüft,
  dass jedes Zeichen der Oberfläche darin vorkommt – sonst würde Flutter
  Ersatzschriften nachladen.
- **Service Worker:** `web/sw.js` (Flutters eigener ist abgekündigt). Nach dem
  Build setzt `tool/finalize_web_build.py` Version (Hash) und Liste aller
  Dateien ein; Strategie cache-first, ca. 21 MB beim ersten Öffnen.
- **iPhone-Details:** `viewport-fit=cover` + Safe-Area-Abstände in
  `index.html`, Eingabefelder 16 px (kein Auto-Zoom), Zurück-Wischen: Flutter erkennt iOS und
  nutzt dort Cupertino-Seitenübergänge mit Wischgeste, Status-Leiste `black-translucent`.

## Abnahme-Checkliste iPhone

- [ ] Seite in Safari öffnen → roter Hinweis „Bitte zuerst über Teilen → Zum
      Home-Bildschirm …“, „So geht’s“ zeigt die Anleitung.
- [ ] Zum Home-Bildschirm hinzufügen; Symbol (Hufeisen) und Name stimmen.
- [ ] Vom Home-Bildschirm starten: kein Safari-Rahmen, kein roter Hinweis,
      Tab-Leiste nicht vom Home-Indikator verdeckt, Titel nicht unter der Notch.
- [ ] Einstellungen → „Speicher dauerhaft: ja“ (sonst „anfordern“ tippen).
- [ ] Pferd mit Foto anlegen, App schließen (aus dem App-Umschalter
      wegwischen), neu öffnen → Daten und Foto sind da.
- [ ] Flugmodus an → App startet und funktioniert vollständig.
- [ ] In Textfelder tippen: Ansicht zoomt nicht.
- [ ] Zurück-Wischen vom linken Rand schließt Unterseiten.
- [ ] Querformat und (falls vorhanden) iPad: Layout passt.
- [ ] Pflegetermin mit Erinnerung „1 Tag vorher“ → im Formular das
      Kalender-Symbol → Termin erscheint im iPhone-Kalender mit Erinnerung.
      Erneut exportieren → kein doppelter Termin.
- [ ] Pflege-Tab → „Nächste 3 Monate in Kalender“.
- [ ] Datensicherung exportieren (Teilen → „In Dateien sichern“), in der
      Android-App importieren – und umgekehrt.
- [ ] Nach einem neuen Deploy: Hinweis „Neue Version verfügbar“ erscheint,
      lädt erst nach Antippen neu.
