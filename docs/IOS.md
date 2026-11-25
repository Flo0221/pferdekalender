# Pferdekalender auf dem iPhone

iOS-Apps können nur auf einem **Mac mit Xcode** gebaut und signiert werden
(nicht unter Windows/Linux). Das Projekt ist dafür vorbereitet; hier die
Schritte.

## Was im Projekt schon eingerichtet ist

| Thema | Wo |
|---|---|
| Bundle-ID `de.flo.pferdekalender`, ab iOS 15 | `ios/Runner.xcodeproj` |
| App-Name „Pferdekalender“, Sprache Deutsch | `ios/Runner/Info.plist` |
| Berechtigungstexte Fotos/Kamera | `ios/Runner/Info.plist` |
| Kein Netzwerk, keine ATS-Ausnahmen, kein Datei-Teilen | `ios/Runner/Info.plist` (Test: `test/core/ios_config_test.dart`) |
| **iCloud-Backup aus** für Datenbank + Fotos (`NSURLIsExcludedFromBackupKey`) | `ios/Runner/AppDelegate.swift` + `lib/core/platform/backup_exclusion.dart` |
| Erinnerungen auch bei geöffneter App | `ios/Runner/AppDelegate.swift` |
| Datenschutz-Erklärung (kein Tracking, keine Datenerhebung) | `ios/Runner/PrivacyInfo.xcprivacy` |
| Höchstens 60 geplante Erinnerungen (iOS-Limit 64) | `NotificationGateway.maxPending` |

## Was du brauchst

- Einen Mac mit aktuellem **Xcode** (App Store) und **Flutter** (stable,
  ≥ 3.50).
- Eine **Apple-ID**. Zwei Möglichkeiten:
  - **Kostenlos** („Personal Team“): App läuft auf deinem iPhone, muss aber
    **alle 7 Tage** neu vom Mac installiert werden. Für einen Langzeittest
    ungünstig.
  - **Apple Developer Program** (99 €/Jahr): 1 Jahr gültig, Verteilung über
    **TestFlight** (90 Tage je Build, Updates per App) – empfohlen für den
    Langzeittest.

## Schritte (einmalig)

```bash
git clone https://github.com/Flo0221/pferdekalender.git
cd pferdekalender
flutter pub get
flutter doctor
```

1. `open ios/Runner.xcworkspace`
2. In Xcode links **Runner** → Reiter **Signing & Capabilities**:
   - „Automatically manage signing“ an.
   - **Team**: deine Apple-ID bzw. dein Developer-Team wählen.
   - Bundle Identifier bleibt `de.flo.pferdekalender` (falls Xcode meldet,
     dass sie vergeben ist: einmalig z. B. `de.flo.pferdekalender.app`
     verwenden – dann aber dauerhaft bei dieser bleiben).
3. iPhone per Kabel anschließen, entsperren, „Diesem Computer vertrauen“.
   Auf dem iPhone unter **Einstellungen → Datenschutz & Sicherheit →
   Entwicklermodus** einschalten (iOS 16+).

## App aufs iPhone

```bash
flutter run --release
```

Beim ersten Start mit kostenlosem Account: auf dem iPhone unter
**Einstellungen → Allgemein → VPN & Geräteverwaltung** dem Entwickler
vertrauen.

## TestFlight (mit Developer-Account)

```bash
flutter build ipa --release
```

Dann die Datei aus `build/ios/ipa/` mit der App **Transporter** (Mac App
Store) hochladen, in **App Store Connect** → TestFlight dich als Tester
eintragen und die App über die TestFlight-App installieren.

## Bitte auf dem iPhone prüfen

1. Einstellungen → Erinnerungen → „Test-Benachrichtigung senden“ → iOS fragt
   nach der Erlaubnis, danach erscheint die Meldung.
2. Pferd-Profil → Foto hinzufügen (Galerie und Kamera) → iOS zeigt die
   deutschen Berechtigungstexte.
3. iPhone-Einstellungen → [Dein Name] → iCloud → Speicher verwalten →
   Backups → dieses iPhone: der Pferdekalender sollte dort nur mit wenigen KB
   (ohne Datenbank/Fotos) auftauchen.
4. Erinnerung für morgen anlegen, App schließen, iPhone neu starten – die
   Erinnerung kommt trotzdem.

Probleme beim Bauen? Die vollständige Xcode-Fehlermeldung kopieren und
schicken.
