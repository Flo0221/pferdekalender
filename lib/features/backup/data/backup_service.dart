import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../../einstellungen/domain/setting_keys.dart';
import '../../pferd/data/photo_store.dart';
import '../../pflege/data/care_seed.dart';
import '../domain/backup_format.dart';

/// Tabellen in Einfüge-Reihenfolge (Eltern vor Kindern). Neue Tabellen hier
/// ergänzen – ein Test prüft, dass alle Tabellen der Datenbank erfasst sind.
const backupTables = <String>[
  'settings',
  'horses',
  'horse_photos',
  'horse_weights',
  'contacts',
  'horse_contacts',
  'care_event_types',
  'care_interval_defaults',
  'care_events',
  'care_reminders',
  'shift_templates',
  'shift_patterns',
  'shift_days',
  'training_plans',
  'training_sessions',
  'feed_items',
  'feed_plans',
  'feed_meals',
  'feed_meal_items',
  'feed_supplements_temporary',
  'blood_tests',
  'blood_values',
];

/// Tabellen, die nicht als JSON gesichert werden (Inhalt kommt als Datei).
const backupExcludedTables = <String>{'photo_blobs'};

/// Ergebnis eines Imports.
class ImportResult {
  const ImportResult(this.manifest, this.rows, this.photos);
  final BackupManifest manifest;
  final int rows;
  final int photos;
}

/// Export und Import der gesamten Datenbank samt Fotos als ZIP.
class BackupService {
  BackupService(
    this._db,
    this._photos, {
    required this.appVersion,
    required this.platform,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final PhotoStore _photos;
  final String appVersion;
  final String platform;
  final DateTime Function() _clock;

  /// Erstellt die Sicherung. Mit [markExported] wird der Zeitpunkt für die
  /// Export-Erinnerung gemerkt.
  Future<(Uint8List, BackupManifest)> export({bool markExported = true}) async {
    final archive = Archive();
    final counts = <String, int>{};
    for (final table in backupTables) {
      final rows = await _db.customSelect('SELECT * FROM "$table"').get();
      final data = [for (final r in rows) _jsonSafe(r.data)];
      counts[table] = data.length;
      _addFile(
        archive,
        '${BackupFormat.dataDir}$table.json',
        utf8.encode(jsonEncode(data)),
      );
    }
    var photos = 0;
    final photoRows = await _db
        .customSelect('SELECT relative_path FROM horse_photos')
        .get();
    for (final r in photoRows) {
      final rel = r.read<String>('relative_path');
      final bytes = await _photos.readBytes(rel);
      if (bytes == null) continue;
      _addFile(archive, _photoEntry(rel), bytes);
      photos++;
    }
    final manifest = BackupManifest(
      formatVersion: BackupFormat.formatVersion,
      schemaVersion: _db.schemaVersion,
      appVersion: appVersion,
      createdAt: _clock().toUtc(),
      platform: platform,
      tables: counts,
      photos: photos,
    );
    _addFile(
      archive,
      BackupFormat.manifestFile,
      utf8.encode(
        const JsonEncoder.withIndent('  ').convert(manifest.toJson()),
      ),
    );
    final bytes = Uint8List.fromList(ZipEncoder().encode(archive));
    if (markExported) await _setLastExport(manifest.createdAt);
    return (bytes, manifest);
  }

  int get schemaVersion => _db.schemaVersion;

  /// Liest nur das Manifest (für die Bestätigung vor dem Import).
  BackupManifest readManifest(Uint8List zip) {
    final archive = _decode(zip);
    return _manifest(archive);
  }

  /// Ersetzt **alle** Daten durch die Sicherung. Vorher muss der Aufrufer
  /// eine Sicherung des aktuellen Stands anlegen (siehe UI).
  Future<ImportResult> import(Uint8List zip) async {
    final archive = _decode(zip);
    final manifest = _manifest(archive);
    checkCompatible(manifest, currentSchema: _db.schemaVersion);

    final tableRows = <String, List<Map<String, Object?>>>{};
    for (final table in backupTables) {
      final file = archive.findFile('${BackupFormat.dataDir}$table.json');
      if (file == null) continue; // ältere Sicherung ohne diese Tabelle
      try {
        final decoded = jsonDecode(utf8.decode(file.content as List<int>));
        tableRows[table] = [
          for (final r in decoded as List) (r as Map).cast<String, Object?>(),
        ];
      } on Object catch (e) {
        throw BackupException(BackupError.corrupt, '$table: $e');
      }
    }

    var rows = 0;
    await _db.transaction(() async {
      await _db.customStatement('PRAGMA defer_foreign_keys = ON');
      for (final table in [...backupTables, ...backupExcludedTables].reversed) {
        if (await _tableExists(table)) {
          await _db.customStatement('DELETE FROM "$table"');
        }
      }
      for (final table in backupTables) {
        final list = tableRows[table];
        if (list == null || list.isEmpty) continue;
        final columns = await _columns(table);
        for (final row in list) {
          final keys = [
            for (final k in row.keys)
              if (columns.contains(k)) k,
          ];
          if (keys.isEmpty) continue;
          await _db.customInsert(
            'INSERT INTO "$table" (${keys.map((k) => '"$k"').join(', ')}) '
            'VALUES (${List.filled(keys.length, '?').join(', ')})',
            variables: [for (final k in keys) _variable(row[k])],
          );
          rows++;
        }
      }
    });
    // Startwerte ergänzen, falls die Sicherung älter ist.
    await seedCareDefaults(_db);

    // Fotos ersetzen.
    await _photos.deleteAll();
    var photos = 0;
    for (final f in archive.files) {
      if (!f.isFile || !f.name.startsWith(BackupFormat.photoDir)) continue;
      final rel = 'photos/${f.name.substring(BackupFormat.photoDir.length)}';
      if (rel.contains('..')) continue; // keine Pfade außerhalb
      await _photos.writeBytes(rel, Uint8List.fromList(f.content as List<int>));
      photos++;
    }
    // Die importierte Sicherung gilt als letzter Export.
    await _setLastExport(manifest.createdAt);
    return ImportResult(manifest, rows, photos);
  }

  // ---------------------------------------------------------------- intern

  static String _photoEntry(String relativePath) {
    final name = relativePath.startsWith('photos/')
        ? relativePath.substring('photos/'.length)
        : relativePath;
    return '${BackupFormat.photoDir}$name';
  }

  static void _addFile(Archive a, String name, List<int> bytes) =>
      a.addFile(ArchiveFile(name, bytes.length, bytes));

  static Map<String, Object?> _jsonSafe(Map<String, Object?> row) => {
    for (final MapEntry(:key, :value) in row.entries)
      key: value is Uint8List ? base64Encode(value) : value,
  };

  static Variable<Object> _variable(Object? v) => switch (v) {
    null => const Variable(null),
    final bool b => Variable.withBool(b),
    final int i => Variable.withInt(i),
    final double d => Variable.withReal(d),
    final String s => Variable.withString(s),
    _ => Variable.withString(jsonEncode(v)),
  };

  Archive _decode(Uint8List zip) {
    try {
      return ZipDecoder().decodeBytes(zip);
    } on Object catch (e) {
      throw BackupException(BackupError.notABackup, '$e');
    }
  }

  BackupManifest _manifest(Archive archive) {
    final file = archive.findFile(BackupFormat.manifestFile);
    if (file == null) throw const BackupException(BackupError.notABackup);
    try {
      return BackupManifest.fromJson(
        jsonDecode(utf8.decode(file.content as List<int>)),
      );
    } on BackupException {
      rethrow;
    } on Object catch (e) {
      throw BackupException(BackupError.corrupt, '$e');
    }
  }

  Future<bool> _tableExists(String table) async {
    final r = await _db
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'table' AND name = ?",
          variables: [Variable.withString(table)],
        )
        .get();
    return r.isNotEmpty;
  }

  Future<Set<String>> _columns(String table) async {
    final r = await _db.customSelect('PRAGMA table_info("$table")').get();
    return {for (final c in r) c.read<String>('name')};
  }

  Future<void> _setLastExport(DateTime at) => _db
      .into(_db.settings)
      .insertOnConflictUpdate(
        SettingsCompanion.insert(
          key: SettingKeys.lastExportAt,
          value: at.toUtc().toIso8601String(),
          updatedAt: Value(_clock()),
        ),
      );
}
