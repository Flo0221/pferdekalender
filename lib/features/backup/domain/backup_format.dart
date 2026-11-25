/// Format der Datensicherung (ZIP). Reines Dart.
///
/// Aufbau:
/// - `manifest.json` – siehe [BackupManifest]
/// - `data/<tabelle>.json` – Liste der Zeilen (SQL-Werte: Text, Zahl, null)
/// - `photos/<datei>` – Fotos (Pfad wie `horse_photos.relative_path`)
///
/// Android- und Web-App schreiben und lesen dasselbe Format.
abstract final class BackupFormat {
  static const kind = 'pferdekalender-backup';

  /// Erhöhen, wenn sich der ZIP-Aufbau (nicht das DB-Schema) ändert.
  static const formatVersion = 1;
  static const manifestFile = 'manifest.json';
  static const dataDir = 'data/';
  static const photoDir = 'photos/';
}

class BackupManifest {
  const BackupManifest({
    required this.formatVersion,
    required this.schemaVersion,
    required this.appVersion,
    required this.createdAt,
    required this.platform,
    required this.tables,
    required this.photos,
  });

  final int formatVersion;
  final int schemaVersion;
  final String appVersion;

  /// UTC.
  final DateTime createdAt;

  /// `android`, `ios`, `web` …
  final String platform;

  /// Zeilen je Tabelle.
  final Map<String, int> tables;
  final int photos;

  Map<String, Object?> toJson() => {
    'kind': BackupFormat.kind,
    'format_version': formatVersion,
    'schema_version': schemaVersion,
    'app_version': appVersion,
    'created_at': createdAt.toUtc().toIso8601String(),
    'platform': platform,
    'tables': tables,
    'photos': photos,
  };

  /// Wirft [BackupException], wenn die Datei keine Sicherung ist.
  static BackupManifest fromJson(Object? json) {
    if (json is! Map || json['kind'] != BackupFormat.kind) {
      throw const BackupException(BackupError.notABackup);
    }
    int i(String k) => json[k] is num ? (json[k] as num).toInt() : -1;
    final created = DateTime.tryParse(json['created_at'] as String? ?? '');
    if (i('format_version') < 1 || i('schema_version') < 1 || created == null) {
      throw const BackupException(BackupError.notABackup);
    }
    return BackupManifest(
      formatVersion: i('format_version'),
      schemaVersion: i('schema_version'),
      appVersion: json['app_version'] as String? ?? '',
      createdAt: created.toUtc(),
      platform: json['platform'] as String? ?? '',
      tables: {
        if (json['tables'] is Map)
          for (final MapEntry(:key, :value) in (json['tables'] as Map).entries)
            if (key is String && value is num) key: value.toInt(),
      },
      photos: i('photos') < 0 ? 0 : i('photos'),
    );
  }
}

enum BackupError {
  /// Keine (gültige) Pferdekalender-Sicherung.
  notABackup,

  /// Sicherung stammt aus einer neueren App-Version.
  tooNew,

  /// Datei beschädigt (ZIP/JSON nicht lesbar).
  corrupt,
}

class BackupException implements Exception {
  const BackupException(this.error, [this.detail]);
  final BackupError error;
  final String? detail;

  @override
  String toString() =>
      'BackupException($error${detail == null ? '' : ': $detail'})';
}

/// Prüft, ob eine Sicherung importiert werden kann.
/// Ältere Schema-Versionen sind erlaubt (fehlende Spalten bekommen
/// Standardwerte), neuere nicht.
void checkCompatible(
  BackupManifest m, {
  required int currentSchema,
  int currentFormat = BackupFormat.formatVersion,
}) {
  if (m.formatVersion > currentFormat || m.schemaVersion > currentSchema) {
    throw const BackupException(BackupError.tooNew);
  }
}

/// Tage seit der letzten Sicherung; `null`, wenn es noch keine gab.
int? daysSinceExport(DateTime? lastExport, DateTime now) =>
    lastExport == null ? null : now.difference(lastExport).inDays;

/// Erinnerung zeigen? Nach [intervalDays] Tagen bzw. wenn noch nie gesichert
/// wurde und es Daten gibt – außer der Nutzer hat bis [snoozedUntil]
/// „Später“ gewählt.
bool shouldRemindExport({
  required DateTime? lastExport,
  required DateTime? snoozedUntil,
  required bool hasData,
  required DateTime now,
  int intervalDays = 7,
}) {
  if (!hasData) return false;
  if (snoozedUntil != null && now.isBefore(snoozedUntil)) return false;
  final days = daysSinceExport(lastExport, now);
  return days == null || days >= intervalDays;
}

/// Dateiname, z. B. `pferdekalender-2026-11-25-1830.zip`.
String backupFileName(DateTime localNow, {String prefix = 'pferdekalender'}) {
  String two(int v) => v.toString().padLeft(2, '0');
  return '$prefix-${localNow.year}-${two(localNow.month)}-${two(localNow.day)}'
      '-${two(localNow.hour)}${two(localNow.minute)}.zip';
}
