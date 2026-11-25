# Pferdekalender – Projektregeln für Claude

Mobile-App (Flutter) zur Verwaltung von Pflege, Training, Futter und Dienstplan
für ein oder mehrere Pferde. Android zuerst, iOS später (Meilenstein 9, erst
nach Freigabe). Oberfläche komplett **Deutsch**.

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
`flutter build appbundle`, danach Permissions prüfen mit
`aapt dump permissions build/app/outputs/flutter-apk/app-release.apk`.

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
    widgets/                  gemeinsame Widgets (TabScaffold, EmptyState)
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
- **App-Version** steht doppelt: `pubspec.yaml` und `lib/core/app_info.dart`
  (Test prüft Gleichheit). Bewusst kein `package_info_plus`.

## Datenmodell-Konventionen

- **IDs:** UUID v4 als `TEXT` (Paket `uuid`), keine Auto-Increment-IDs
  (Ausnahme: `notification_id` für Benachrichtigungen ist ein stabiler int).
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
`reminders` (target_kind, target_id, offset_days, time_of_day, notification_id) ·
`shift_templates`, `shift_days` (1 Eintrag pro Datum, `source`, `pattern_id`,
`override_minutes`, `other_person_covers`), `shift_patterns` ·
`training_plans` (+ `distributed_at`), `training_sessions` (+ `form`, `reason`,
`pinned`, `template_key`), `horse_time_share` · `feed_items` (+ `stock`,
`low_stock_threshold`), `feed_plans` (valid_from), `feed_meals`,
`feed_meal_items` (+ `variant`: immer/Trainingstag/Ruhetag),
`feed_supplements_temporary`.

### Migrationen

1. Tabellen ändern, `schemaVersion` in `lib/core/db/app_database.dart` erhöhen.
2. `dart run drift_dev make-migrations` → legt `drift_schemas/…/drift_schema_vN.json`,
   Schritt-Helfer und Migrationstests unter `test/drift/` an.
3. Schritt in `MigrationStrategy.onUpgrade` (via `stepByStep`) ergänzen.
4. Migrationstest ausführen. Alte Schema-Snapshots nie löschen.

Aktueller Stand: **Schema v1** (nur `settings`).

## Build-Hinweise

- `sqlite3` 3.x lädt beim **Bauen** (nicht zur Laufzeit) eine vorkompilierte
  SQLite-Bibliothek über einen Build-Hook herunter. Die App selbst hat
  weiterhin keinen Netzwerkzugriff.
- Im Cloud-Container ist dl.google.com gesperrt → kein Android-SDK, also
  kein APK-Build hier. Gebaut/getestet wird lokal beim Nutzer.

## Meilensteine

- [x] 1. Gerüst: Projekt, Ordner, Theme, Lokalisierung, 5 Tabs, Drift v1,
      Manifest-Härtung, CLAUDE.md
- [ ] 2. Pferd: Liste, Profil, Fotos, Pferde-Umschalter in der AppBar
- [ ] 3. Pflege-Kalender inkl. Wiederholungen, Folgetermine, Erinnerungen
- [ ] 4. Dienstplan: Vorlagen, Schnell-Eintragen, Rhythmen
- [ ] 5. Training: Kalender, manuelle Einheiten, Generator + Tests, Neu-Verteilen
- [ ] 6. Futterplan mit Versionen und temporären Zusätzen
- [ ] 7. Export/Import, Einstellungen, Übersichtskarte, Feinschliff
- [ ] 8. Release-Build Android (Icon, Splash, Signing, Permission-Prüfung)
- [ ] 9. iOS (nur nach Freigabe)

## TODO / offen

- Einstellungen: Erinnerungs-Defaults, Export/Import, Intervall-Defaults,
  Pflege-Eintragsarten (Meilensteine 3 und 7).
- Pferde-Umschalter in `TabScaffold` (Meilenstein 2).
- Release-Manifest-Prüfung (`aapt dump permissions`) noch nicht ausgeführt –
  braucht Android-SDK (Meilenstein 8, lokal).
- iOS-Projekt ist nur generiert, nicht angepasst (Meilenstein 9).
