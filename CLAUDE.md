# Pferdekalender – Projektregeln für Claude

Mobile-App (Flutter) zur Verwaltung von Pflege, Training, Futter und Dienstplan
für ein oder mehrere Pferde. Android ist die Hauptversion; iOS ist konfiguriert;
zusätzlich eine **Web-App (PWA)** für den iPhone-Testlauf (`docs/WEB.md`).
Oberfläche komplett **Deutsch**.

Application-ID / Bundle-ID: `de.flo.pferdekalender` (nie ändern).

## Grundprinzipien (nicht verhandelbar)

1. **Alles lokal.** Kein Cloud-Dienst, kein Login, kein Firebase, kein
   Analytics, kein Crash-Reporting, keine Werbe-SDKs, keine Netzwerkaufrufe.
   - `android/app/src/main/AndroidManifest.xml` enthält **keine**
     INTERNET-Permission (nur den `tools:node="remove"`-Marker gegen Plugins).
     Flutter fügt INTERNET nur in `src/debug`/`src/profile` hinzu.
   - Auto-Backup aus: `allowBackup="false"`, `fullBackupContent="false"`,
     `dataExtractionRules=@xml/data_extraction_rules` (Cloud + Transfer ausgeschlossen).
   - Abgesichert durch `test/core/android_manifest_test.dart`.
   - **Vor jedem neuen Paket** prüfen: Netzwerkcode/Telemetrie? Transitive
     Abhängigkeiten (`http`, `dio`, Firebase …)? Wenn ja → nicht verwenden
     bzw. den Nutzer fragen. Paketwahl immer mit dem Nutzer abstimmen.
2. **Datensicherung nur manuell** per Export/Import (ZIP: JSON + Fotos,
   `manifest.json` mit `format_version` und `schemaVersion`).
3. **Mehrere Pferde.** Fast alles hängt an `horse_id`; der Dienstplan gehört
   zur Person, nicht zum Pferd.
4. **Keine tierärztliche Beratung.** Intervalle/Trainingspläne sind Vorlagen.
   Hinweistext (ARB-Key `disclaimer`) in Einstellungen und beim ersten Trainingsplan.

## Befehle

Flutter liegt in dieser Umgebung unter `/opt/sdk/flutter/bin` (ggf. `PATH` setzen).

```bash
flutter pub get
dart run build_runner build            # Drift-Code (*.g.dart) erzeugen
flutter gen-l10n                       # Lokalisierung (läuft auch automatisch)
dart format lib test
flutter analyze                        # muss "No issues found!" melden
TZ=Europe/Berlin flutter test          # alle Tests (DST-Tests brauchen Berlin-Zeit)
flutter run                            # auf Emulator/Gerät
```

Schema-Änderung (siehe unten): `dart run drift_dev make-migrations`.

Release (ab Meilenstein 8): `flutter build apk --release`,
`flutter build appbundle`, danach **immer** prüfen:
`tool/check_release_permissions.sh` (aapt: keine INTERNET-Permission, Backup aus).
Einzige erwartete Permission: `…DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION`
(intern von androidx, signaturgeschützt, kein Netzwerk).

## Qualitätsregeln (vor jedem Commit)

- `dart format`, `flutter analyze` ohne Meldungen, Tests grün.
- Keine Platzhalter, die so tun, als wären sie fertig. Was fehlt → TODO-Liste unten.
- Destruktive Aktionen (Löschen, Import überschreibt) immer mit Bestätigung;
  vor Import automatisch Sicherungs-Export.
- Nach jedem Meilenstein: Commit + kurze Zusammenfassung „was ist fertig, wie testen“.
- Schwer umkehrbare Entscheidungen (Datenmodell, Pakete) vorher mit dem Nutzer klären.
- Alle UI-Texte in `lib/l10n/app_de.arb`, nie hart im Code.
- Barrierefreiheit: Tooltips/Semantics für Icon-Buttons, dekorative Icons mit
  `ExcludeSemantics`, Layouts müssen große Schrift vertragen.

## Architektur

```
lib/
  main.dart / app.dart        Einstieg, MaterialApp.router, Theme, Lokalisierung
  core/
    db/                       AppDatabase (Drift), Tabellen, Converter, Provider
    router/                   go_router, StatefulShellRoute (5 Tabs), Routes
    theme/                    Material-3-Theme hell/dunkel
    time/                     LocalDate (reines Dart)
    files/                    App-Dokumentenverzeichnis-Provider
    format/                   deutsche Datums-/Zahlenformate (Fmt)
    widgets/                  TabScaffold (mit Pferde-Umschalter), EmptyState,
                              DateField, Bestätigungsdialoge
  features/<bereich>/         pflege, training, futter, dienstplan, pferd,
                              einstellungen, backup
    data/                     Drift-Tabellen, Repositories
    domain/                   Modelle + Geschäftslogik – REINES DART
    ui/                       Screens, Widgets, Riverpod-Provider
  l10n/app_de.arb             Texte; generiert nach lib/l10n/generated/
assets/training_templates.json   (ab Meilenstein 5)
drift_schemas/                Schema-Snapshots je Version (nicht von Hand ändern)
test/                         spiegelt lib/
```

- **State:** Riverpod 3 (`flutter_riverpod`), ohne Codegenerierung.
- **Navigation:** go_router, `StatefulShellRoute.indexedStack`; Einstellungen
  als Route `/einstellungen` auf dem Root-Navigator (über der Tab-Leiste).
- **Material:** Ab Flutter 3.47 liegt Material im Paket `material_ui`.
  Immer `import 'package:material_ui/material_ui.dart';` statt
  `package:flutter/material.dart`. Lokalisierung über
  `GlobalMaterialLocalizations.delegates` aus `material_ui`. Für ältere Pakete,
  die noch `flutter/material.dart` nutzen, ggf. `MaterialUiCompatibilityBridge`.
- **`domain/` und `core/time/` dürfen weder Flutter, material_ui, Riverpod noch
  Drift importieren** (geprüft durch `test/core/architecture_test.dart`).
  So braucht iOS später nur Plattform-Konfiguration.
- **Ausgewähltes Pferd:** `selectedHorseProvider` (lib/features/pferd/ui/
  horse_providers.dart), gespeichert unter Setting `selected_horse_id`.
  Pferdebezogene Bereiche filtern immer danach. `TabScaffold` zeigt den
  Umschalter; der Dienstplan setzt `showHorseSwitcher: false`.
- **Widget-Tests mit Drift:** DB-Schreibzugriffe direkt im Test (nicht in
  `tester.runAsync`, das hängt); am Ende `pumpWidget(SizedBox.shrink())`,
  `pump(1s)`, dann `tester.runAsync(db.close)`. Dokumentenordner über
  `documentsDirProvider` überschreiben.
- **Erinnerungen:** `ReminderSync` (pflege/ui/reminder_sync.dart) beobachtet
  offene Termine mit Erinnerung, Geburtstage und Einstellungen und plant bei
  jeder Änderung *alle* Benachrichtigungen neu (cancel all + schedule, IDs
  1…n, max. 400). Läuft bei jedem App-Start (`ref.watch` in `app.dart`).
  Neustart: `ScheduledNotificationBootReceiver` des Plugins. Zeitpunkt =
  Einstellung (Standard 9:00) am Tag „Datum − Offset“; am Termintag mit
  früher Uhrzeit 60 min vorher. Exakte Alarme nur auf Wunsch (Einstellung +
  Systemfreigabe), sonst `inexactAllowWhileIdle`. System-Zugriff nur über
  `NotificationGateway` (in Tests `FakeNotificationGateway`).
- **Folgetermine:** `planFollowUp` (pflege/domain/care_logic.dart). Ein neuer
  Folgetermin entsteht nur für erledigte oder selbst angelegte Einträge, nie
  für offene Folgetermine (Kette läuft max. einen Termin voraus). Verschieben
  eines offenen Folgetermins nur nach Nachfrage („neu berechnen?“).
- **Dienstplan:** reine Logik in `dienstplan/domain/shift_logic.dart`
  (`rolloutPattern`, `availabilityFor` → `DayAvailability` mit Stallzeit,
  Tag-nach-Nacht, Beisteller – Eingabe für den Trainings-Generator).
  Manuell geänderte Tage werden beim Ausrollen nur auf Wunsch überschrieben;
  eigene Stallzeit/Beisteller/Notiz bleiben immer. Jede Dienstplan-Änderung
  setzt Setting `shift_changed_at` (für „Plan neu verteilen?“ in M5).
  Startvorlagen nur per Knopf („Standard-Vorlagen anlegen“), kein Seeding.
- **Training / Generator:** `training/domain/training_generator.dart` (reines
  Dart, deterministisch). Eingaben: `TrainingParams`, `DayAvailability` je
  Tag (aus dem Dienstplan), fixierte Einheiten, `from` (Neu-Verteilen).
  Alle Zahlen (Stufen-Belastung, Fitness-Skala, Ziel-Parameter wie
  Progression/Entlastung/Stufenkappen) stehen in
  `assets/training_templates.json` → `TrainingCatalog.fromJson`. Neue
  Übungen dort ergänzen; Test „Vorlagen-Datei ist vollständig“ prüft sie.
  Regeln je Regel getestet in `test/features/training/training_generator_test.dart`.
  Begründungen sind strukturiert (`SessionReason`), Text entsteht in der UI
  (`training_labels.dart`). Manuell angelegte/verschobene Einheiten sind
  `pinned`. „Dienstplan geändert“ = Setting `shift_changed_at` >
  `plan.distributedAt`. Hinweis beim ersten Plan: Setting
  `training_disclaimer_seen`.
- **Futter:** reine Logik `futter/domain/feed_logic.dart` (`planOn` = Version
  mit spätestem `validFrom` ≤ Datum, `rationFor`, `averageDailyUse`,
  `copyPlanAsNewVersion`). Trainingstag = Einheit ab Stufe 2, nicht
  ausgefallen (`trainingDaysProvider`). Planversionen werden beim Speichern
  komplett ersetzt (Mahlzeiten neu). Keine Rationsberechnung/Empfehlungen.
- **Gesundheit / Blutbild:** `features/gesundheit`. Referenzwerte und Regeln
  in `assets/blood_reference.json`, **erzeugt** von
  `tool/gen_blood_reference.py` (dort ändern, dann `python3
  tool/gen_blood_reference.py`). Referenzwerte = Laboklin Leistungsverzeichnis
  Pferd 2025/26, Kap. 14.1 (einmalig ausgewertet). ACTH saisonal. Auswertung
  `gesundheit/domain/blood_evaluation.dart` (`evaluate`): nicht eingetragene
  Werte gelten als normal; Einzelregeln + Muster (`combos`), „zuerst Tierarzt“
  bei Regel-Flag oder deutlicher Abweichung; Vorschläge ohne Marken.
  Übernahme (`blood_apply.dart`): Zusätze ohne Menge („laut Packungsangabe“),
  Termine in den Pflege-Kalender, Fütterungshinweise als Notiz der aktuellen
  Futterplan-Version. Fachtexte stehen bewusst in der JSON-Datei, nicht in
  der ARB (wie die Trainingsvorlagen). Immer als Hinweis zur Rücksprache
  formulieren, nie als Diagnose. Karte „Gesundheit“ im Pferde-Profil unter
  „Fotos“ mit Kurzinfo (`healthSummaryText`).
- **iOS:** `ios/Runner/AppDelegate.swift` registriert den Kanal
  `de.flo.pferdekalender/backup` (setzt `isExcludedFromBackup` für das
  Dokumentenverzeichnis; aus `main.dart` über
  `core/platform/backup_exclusion.dart`) und den Benachrichtigungs-Delegate.
  `PrivacyInfo.xcprivacy` ist von Hand in `project.pbxproj` eingetragen.
  iOS hält max. 64 geplante Benachrichtigungen → `NotificationGateway.maxPending`
  (iOS 60). „Pünktliche Erinnerungen“ nur auf Android sichtbar
  (`exactAlarmsSupported`). Konfiguration geprüft in `test/core/ios_config_test.dart`.
- **Datensicherung:** `features/backup`. Format in `backup/domain/backup_format.dart`
  (ZIP: `manifest.json` mit `kind`, `format_version`, `schema_version`;
  `data/<tabelle>.json` mit SQL-Rohwerten; `photos/<datei>`). Android und Web
  identisch. `BackupService` exportiert alle Tabellen aus `backupTables`
  (neue Tabellen dort eintragen – Test prüft Vollständigkeit) und importiert
  mit „alles ersetzen“: nur Spalten, die es im aktuellen Schema gibt; ältere
  Sicherungen erlaubt, neuere abgelehnt. Vor jedem Import automatische
  Sicherung (Android: `<Dokumente>/backups`, letzte 3; Web: wird geteilt).
  Export-Erinnerung (`ExportReminderBanner` in `TabScaffold`) nach 7 Tagen,
  „Später“ = 1 Tag. Datei-Zugriff über `BackupFiles` (Tests: `FakeBackupFiles`).
- **Tab-FABs** stehen in `HeroMode(enabled: false)` (IndexedStack, sonst
  Hero-Tag-Kollision).
- **Kalender-Widget** `core/widgets/month_calendar.dart`: Punkte (`dotsFor`)
  oder Kürzel-Abzeichen (`badgeFor`) je Tag; wiederverwendbar für Training.
- **Android-Ressourcen per Name** (z. B. Benachrichtigungs-Icon) in
  `res/raw/keep.xml` eintragen, sonst entfernt der Release-Build sie.
- **Test-Hilfe:** `test/helpers/test_app.dart` (`TestApp.create()`, `pump`,
  `openTab`, `read`, `settle`, `dispose`) für App-Widget-Tests.
  DB-Lesezugriffe *nach* UI-Aktionen über `app.read(tester, …)`; Bildschirme,
  die beim Öffnen selbst DB/Assets laden, mit `app.settle(tester)` statt
  `pumpAndSettle` (sonst Timeout). Trainingsvorlagen werden in Tests aus der
  Datei gelesen (`testCatalog`), nicht über `rootBundle`. In der App für
  einmalige Abfragen Repository-`get…`-Methoden statt `provider.future` von
  Stream-Providern nutzen. Echte Datei-I/O im Test nur in `tester.runAsync`;
  `TestApp` hat einen eigenen Temp-Dokumentenordner je Test.
  Bottom-Sheets: Aktionsknöpfe außerhalb des Scrollbereichs anordnen.
- **Web-App (PWA):** Plattform-Weiche `core/platform/web_env.dart`
  (Conditional Import `web_env_web.dart`/`web_env_stub.dart`; Tests:
  `FakeWebEnv`, `TestApp.create(webEnv: …)`). Standalone-Erkennung,
  `persist()`/`estimate()` (Einstellungen → „Speicher im Browser“),
  Installations-Hinweis + Anleitung und Update-Banner (`WebBanners` in
  `TabScaffold`), Download, Badging. Fotos im Web als Blobs (`DbPhotoStore`,
  Tabelle `photo_blobs`, nicht im JSON-Export – Fotos kommen über `photos/`).
  Benachrichtigungen im Web aus (`UnsupportedNotificationGateway`); statt
  dessen Heute-Karte (`CareTodayCard`) und ICS-Export
  (`pflege/domain/ics_export.dart`, UID `care-<id>@pferdekalender`, VALARM
  nach denselben Regeln wie die Erinnerungen) – **nur im Web**. Datenbank:
  `web/sqlite3.wasm` + `web/drift_worker.js` (eingecheckt, neu mit
  `tool/build_web_assets.sh`). Build: `tool/build_web.sh` (ohne CDN, setzt
  per `tool/finalize_web_build.py` Version + Precache-Liste in `web/sw.js`).
  Prüfung: `node tool/check_web_requests.mjs` (nur eigene Herkunft, offline).
  **Keine externen Ressourcen**: Schriften Roboto + `PkSymbols` (Teilmenge
  DejaVu Sans), `test/core/web_glyphs_test.dart` verlangt, dass jedes
  UI-Zeichen darin vorkommt – neue Sonderzeichen ggf. in PkSymbols ergänzen
  (`pyftsubset`). Fonts nur im Web als `fontFamily` aktiv.
  CI: `.github/workflows/web.yml` (Secrets-Check `tool/check_secrets.sh`,
  Analyse, Tests, Build, Browser-Check, Pages-Deploy).
- **App-Version** steht doppelt: `pubspec.yaml` und `lib/core/app_info.dart`
  (Test prüft Gleichheit). Bewusst kein `package_info_plus`.

## Datenmodell-Konventionen

- **IDs:** UUID v4 als `TEXT` (Paket `uuid`), keine Auto-Increment-IDs.
  Benachrichtigungs-IDs werden nicht gespeichert (siehe Erinnerungen).
- **Kalendertage:** `LocalDate`, in SQLite als `TEXT 'YYYY-MM-DD'`
  (`LocalDateConverter`). Nie `DateTime` für Kalendertage speichern.
- **Uhrzeiten:** Minuten seit Mitternacht (`int`).
- **Zeitstempel:** `created_at`/`updated_at` per Mixin `Timestamps`
  (Drift-DateTime, Unix-Sekunden). `updated_at` bei Updates selbst setzen.
- **Fotos:** Dateien ins App-Verzeichnis kopieren, nur relativen Pfad speichern.
- Typspezifische Felder (z. B. Wurmkur-Präparat) als JSON-Spalte `fields`.
- Fremdschlüssel aktiv (`PRAGMA foreign_keys = ON` in `beforeOpen`).

### Abgestimmtes Zielmodell (wird je Meilenstein ergänzt)

`settings` · `horses`, `horse_photos`, `horse_weights`, `contacts`,
`horse_contacts` · `care_event_types`, `care_interval_defaults`,
`care_events` (+ `variant_key`, `series_id`, `parent_event_id`) ·
`care_reminders` (event_id, offset_days; Geburtstage über `horses.birthday_reminder`) ·
`shift_templates` (+ `stable_minutes`, `preferred_time`, `is_night`),
`shift_days` (PK = Datum, `source` manual/pattern, `pattern_id`,
`override_minutes`, `other_person_covers`, `note`), `shift_patterns`
(`steps` JSON-Liste von Vorlagen-IDs/null, `start_date`, `weeks`) ·
`training_plans` (`params` JSON = `TrainingParams`, `status` active/archived,
`distributed_at`), `training_sessions` (`plan_id` nullable, `template_key`,
`form`, `level`, `duration_minutes`, `content` JSON, `status`, `rating`,
`pinned`, `reason` JSON). Stallzeit-Anteil pro Pferd steht in
`TrainingParams.sharePercent` (keine eigene Tabelle `horse_time_share`) · `feed_items` (für alle Pferde; + `stock`,
`low_stock_threshold`, `archived`), `feed_plans` (Version je Pferd,
`valid_from`), `feed_meals`, `feed_meal_items` (+ `variant`:
always/training/rest), `feed_supplements_temporary` (`amount` nullable =
laut Packungsangabe, `meal_name` statt FK, `source` manual/blood,
`blood_test_id`) · `blood_tests` (Befund je Pferd: Datum, Labor, Notiz),
`blood_values` (PK test_id+param_key, `value`, optional `ref_low`/`ref_high`
vom eigenen Befund). Nur abweichende Werte werden gespeichert.

### Migrationen

1. Tabellen ändern, `schemaVersion` in `lib/core/db/app_database.dart` erhöhen.
2. `dart run drift_dev make-migrations` → legt `drift_schemas/…/drift_schema_vN.json`,
   Schritt-Helfer und Migrationstests unter `test/drift/` an.
3. Schritt in `MigrationStrategy.onUpgrade` (via `stepByStep`) ergänzen.
4. Migrationstest ausführen. Alte Schema-Snapshots nie löschen.

Aktueller Stand: **Schema v8** (`settings`; `photo_blobs` (Web); `horses`, `horse_photos`,
`horse_weights`, `contacts`, `horse_contacts`; `care_event_types`,
`care_interval_defaults`, `care_events`, `care_reminders`;
`shift_templates`, `shift_patterns`, `shift_days`; `training_plans`,
`training_sessions`; `feed_items`, `feed_plans`, `feed_meals`,
`feed_meal_items`, `feed_supplements_temporary`; `blood_tests`,
`blood_values`). Migrationstest:
`test/drift/app_database/migration_test.dart` (je Version ein Datenerhalt-Test).

**Startwerte** (eingebaute Eintragsarten, Standard-Intervalle) werden in
`beforeOpen` per `insertOrIgnore` ergänzt (`care_seed.dart`), nie in einem
Migrationsschritt – sonst brechen spätere Migrationen. Ein entfernter
Intervall-Vorschlag wird als `value = 0` gespeichert, damit er nicht
zurückkommt. Eingebaute Arten haben feste IDs (`builtin_huf` …), werden nie
gelöscht, nur ausgeblendet.

## Build-Hinweise

- `sqlite3` 3.x lädt beim **Bauen** (nicht zur Laufzeit) eine vorkompilierte
  SQLite-Bibliothek über einen Build-Hook herunter. Die App selbst hat
  weiterhin keinen Netzwerkzugriff.
- Cloud-Umgebung „pferdekalender“ erlaubt zusätzlich dl.google.com und
  downloads.gradle.org. Android-SDK liegt unter `/opt/sdk/android`
  (`ANDROID_HOME`), Flutter unter `/opt/sdk/flutter`. Beides ist nicht
  persistent – bei neuem Container neu installieren.
- Die Umgebung erlaubt zusätzlich `laboklin.de` – nur für die einmalige
  Recherche der Referenzwerte, die App selbst lädt nie etwas.
- Maven Central antwortet gelegentlich mit 429 → Build einfach wiederholen.
- `compileSdk = 37` fest in `android/app/build.gradle.kts` (Plugin-Vorgabe);
  Plattform `platforms;android-37.0` muss installiert sein.

## Test-APK für das Handy (Branch `apk`)

GitHub-Releases sind aus der Cloud-Sitzung nicht erlaubt (403). Testversionen
liegen deshalb auf dem verwaisten Branch `apk` (nur `pferdekalender.apk` +
`README.md`, keine Verbindung zur `main`-Historie). **Nie APKs auf `main`
committen.** Neue Testversion:
`flutter build apk --release --split-per-abi --target-platform android-arm64`,
`tool/check_release_permissions.sh build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`,
dann den Branch `apk` mit einem neuen orphan-Commit ersetzen (Force-Push), damit
sich alte APKs nicht ansammeln; Version im README des Branches anpassen.
Vorher immer prüfen, ob per Name genutzte Ressourcen im APK sind:
`aapt2 dump resources <apk> | grep ic_stat`.

## Geprüfte Pakete (Netzwerk/Telemetrie)

| Paket | Zweck | Befund |
|---|---|---|
| drift, drift_flutter, sqlite3 | Datenbank | kein Netzwerk zur Laufzeit; sqlite3-Hook lädt beim Bauen |
| flutter_riverpod, go_router, intl, uuid, path, path_provider | Basis | kein Netzwerk |
| image_picker | Fotos | zieht `http` transitiv nur für die Web-Variante (`picked_file/html.dart`); auf Android nicht einkompiliert. Keine Manifest-Permissions. |
| url_launcher | `tel:`-Links | keine Permissions; `<queries>` für `tel` im Manifest |
| flutter_local_notifications | Erinnerungen | kein Netzwerk; Permissions POST_NOTIFICATIONS, VIBRATE; braucht Desugaring + compileSdk 37 |
| timezone | Zeitzonen | **nur `data/latest.dart`** (eingebettet). `standalone.dart`/`browser.dart` laden per `http` – verboten, per Test geprüft |
| flutter_timezone | Gerätezeitzone | kein Netzwerk, keine Permissions |
| archive | ZIP für Export/Import | reines Dart, kein Netzwerk |
| share_plus | Sicherung teilen/„In Dateien sichern“ | keine Permissions (nur eigener FileProvider); Web: `navigator.share`, Fallback Download; `mailto`-Fallback abgeschaltet |
| file_picker | ZIP für Import wählen | keine Permissions; Web liest nur lokale Blob-URLs (`fetch` auf `blob:`) |
| web | Browser-APIs (nur Web-Code) | reine JS-Bindings des Dart-Teams, kein Netzwerk; war schon transitiv da |

Verworfen: `table_calendar` (nutzt noch `flutter/material`, bricht mit
`material_ui`) → eigener Kalender `core/widgets/month_calendar.dart`
+ reine Logik `core/time/calendar_grid.dart`.

Bewusst **nicht** verwendet: `package_info_plus`, `table_calendar`, Diagramm-Bibliotheken
(Gewichtsverlauf ist ein eigener `CustomPainter`).

## Meilensteine

- [x] 1. Gerüst: Projekt, Ordner, Theme, Lokalisierung, 5 Tabs, Drift v1,
      Manifest-Härtung, CLAUDE.md
- [x] 2. Pferd: Liste, Profil, Fotos, Gewicht, Kontakte, Pferde-Umschalter
- [x] 3. Pflege-Kalender inkl. Wiederholungen, Folgetermine, Erinnerungen
- [x] 4. Dienstplan: Vorlagen, Schnell-Eintragen, Rhythmen
- [x] 5. Training: Kalender, manuelle Einheiten, Generator + Tests, Neu-Verteilen
- [x] 6. Futterplan mit Versionen und temporären Zusätzen
- [x] 6b. Gesundheit: Blutbild mit Laboklin-Referenzwerten, Regel-Auswertung, Futter-Bausteine
- [ ] 7. Export/Import, Einstellungen, Übersichtskarte, Feinschliff
      (Export/Import fertig: `features/backup`)
- [x] Web-App (PWA) für iPhone-Test: Speicher, Offline, ICS, Heute-Karte,
      CI + Pages (`docs/WEB.md`); auf echtem iPhone noch abzunehmen
- [ ] 8. Release-Build Android (Icon, Splash, Signing, Permission-Prüfung)
- [x] 9. iOS: Konfiguration fertig (Info.plist, Backup-Ausschluss, Privacy-Manifest, Benachrichtigungen); **Build auf Mac/Xcode noch nicht verifiziert** – Anleitung `docs/IOS.md`

## TODO / offen

- Web: Abnahme auf echtem iPhone (Checkliste in `docs/WEB.md`). Pages muss
  der Nutzer einschalten (Settings → Pages → GitHub Actions); bei privatem
  Repo nur mit bezahltem Plan.
- Leerzustand „Erstes Pferd anlegen“ ist nur im Web scrollbar (Querformat);
  für Android nach Rückfrage übernehmen (`_scrollableOnWeb` in pferd_screen).

- Antippen einer Benachrichtigung öffnet nur die App, nicht den Eintrag
  (payload `care:<id>` / `birthday:<id>` ist vorhanden) – Meilenstein 7.
- Erinnerungen auf echtem Gerät testen: auch nach Neustart und mit
  ausgeschalteter App (kein Emulator im Cloud-Container, kein KVM).
- Optionale „Übersicht“ aller Kalender zusammen (Meilenstein 7).
- Übersichtskarte im Pferd-Profil (nächster Termin, letzte Wurmkur …): Meilenstein 7.
- Kontakte global verwalten (ohne Pferd, endgültig löschen): Meilenstein 7.
- „Vorrat wird knapp“ nur als Hinweis im Futter-Tab, keine Benachrichtigung.
- Training: Einheiten per Ziehen verschieben (derzeit über Datum im Formular),
  Einheit aus Vorlage wählen beim manuellen Anlegen – optional.
- Stallzeit bei mehreren Pferden wird je Plan als Prozent-Anteil gewählt; eine
  gemeinsame Planung über alle Pferde gleichzeitig gibt es nicht.
- Blutbild: Referenzwerte gelten für adulte Pferde (keine Fohlen/Esel-Werte);
  Rassenunterschiede nur als Hinweistext. Verlaufsdiagramm einzelner Werte
  über mehrere Blutbilder fehlt noch.
- Release-Signierung: APK ist derzeit mit dem Debug-Key signiert (Meilenstein 8).
- iOS: noch nie auf Mac/Xcode gebaut (kein Mac in der Cloud-Umgebung). Erster
  Build durch den Nutzer nach `docs/IOS.md`; Fehler dann hier beheben.
