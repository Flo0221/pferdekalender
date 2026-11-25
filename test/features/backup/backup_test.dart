import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/backup/data/backup_service.dart';
import 'package:pferdekalender/features/backup/domain/backup_format.dart';
import 'package:pferdekalender/features/dienstplan/data/shift_repository.dart';
import 'package:pferdekalender/features/einstellungen/data/settings_repository.dart';
import 'package:pferdekalender/features/einstellungen/domain/setting_keys.dart';
import 'package:pferdekalender/features/futter/data/feed_repository.dart';
import 'package:pferdekalender/features/futter/domain/feed.dart';
import 'package:pferdekalender/features/gesundheit/data/blood_repository.dart';
import 'package:pferdekalender/features/gesundheit/domain/blood.dart';
import 'package:pferdekalender/features/pferd/data/horse_repository.dart';
import 'package:pferdekalender/features/pferd/data/photo_storage.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pflege/data/care_repository.dart';
import 'package:pferdekalender/features/pflege/domain/care_event.dart';
import 'package:pferdekalender/features/pflege/domain/care_type.dart';
import 'package:pferdekalender/features/pflege/domain/repeat_interval.dart';

void main() {
  late Directory dirA, dirB;
  late AppDatabase dbA, dbB;
  late BackupService a, b;

  setUp(() async {
    dirA = await Directory.systemTemp.createTemp('backup_a');
    dirB = await Directory.systemTemp.createTemp('backup_b');
    dbA = AppDatabase(NativeDatabase.memory());
    dbB = AppDatabase(NativeDatabase.memory());
    a = BackupService(
      dbA,
      PhotoStorage(() async => dirA),
      appVersion: '1.0.0',
      platform: 'android',
      clock: () => DateTime.utc(2026, 11, 25, 18),
    );
    b = BackupService(
      dbB,
      PhotoStorage(() async => dirB),
      appVersion: '1.0.0',
      platform: 'web',
    );
  });
  tearDown(() async {
    await dbA.close();
    await dbB.close();
    await dirA.delete(recursive: true);
    await dirB.delete(recursive: true);
  });

  test('alle Tabellen der Datenbank sind in der Sicherung erfasst', () {
    final dbTables = {for (final t in dbA.allTables) t.actualTableName};
    expect(
      {...backupTables, ...backupExcludedTables}.containsAll(dbTables),
      isTrue,
      reason:
          'fehlend: ${dbTables.difference({...backupTables, ...backupExcludedTables})}',
    );
    expect(backupTables.toSet().length, backupTables.length);
  });

  test('Roundtrip: alles kommt vollständig wieder an, inkl. Fotos', () async {
    final horses = HorseRepository(dbA, PhotoStorage(() async => dirA));
    final horseId = await horses.createHorse(
      Horse(
        id: '',
        name: 'Amigo',
        birthDate: LocalDate(2015, 4, 2),
        sex: HorseSex.wallach,
        heightCm: 165,
      ),
    );
    final src = File('${dirA.path}/src.jpg')..writeAsBytesSync([1, 2, 3, 4]);
    await horses.addPhoto(horseId, src.path);
    await horses.addWeight(horseId, LocalDate(2026, 3, 29), 540.5);
    final care = CareRepository(dbA);
    await care.saveEvent(
      CareEvent(
        id: '',
        horseId: horseId,
        typeId: BuiltinCareTypes.wurmkur,
        date: LocalDate(2026, 10, 25), // Tag der Zeitumstellung
        fields: const {CareFields.praeparat: 'Equest', CareFields.epg: 150},
        repeat: const RepeatInterval(3, IntervalUnit.months),
        reminderOffsets: const [1, 7],
      ),
    );
    final shifts = ShiftRepository(dbA);
    await shifts.createDefaultTemplates();
    final feed = FeedRepository(dbA);
    final heu = await feed.saveItem(
      const FeedItem(
        id: '',
        name: 'Heu',
        category: FeedCategory.raufutter,
        unit: FeedUnit.kg,
        stock: 2.5,
      ),
    );
    await feed.savePlan(
      FeedPlan(
        id: '',
        horseId: horseId,
        name: 'Winter',
        validFrom: LocalDate(2026, 11, 1),
        meals: [
          Meal(
            id: '',
            name: 'Morgens',
            timeMinutes: 420,
            entries: [MealEntry(id: '', itemId: heu, amount: 4)],
          ),
        ],
      ),
    );
    await BloodRepository(dbA).saveTest(
      BloodTest(
        id: '',
        horseId: horseId,
        date: LocalDate(2026, 11, 20),
        values: const [BloodValue(paramKey: 'ggt', value: 60.5, refHigh: 50)],
      ),
    );

    final (zip, manifest) = await a.export();
    expect(manifest.photos, 1);
    expect(manifest.tables['horses'], 1);
    expect(manifest.schemaVersion, dbA.schemaVersion);

    // Im „anderen Gerät“ (Web) einspielen.
    final result = await b.import(zip);
    expect(result.photos, 1);

    Future<List<Map<String, Object?>>> all(AppDatabase db, String t) async => [
      for (final r
          in await db.customSelect('SELECT * FROM "$t" ORDER BY 1').get())
        r.data,
    ];
    for (final t in backupTables) {
      if (t == 'settings') continue;
      expect(await all(dbB, t), await all(dbA, t), reason: t);
    }
    final h = (await HorseRepository(
      dbB,
      PhotoStorage(() async => dirB),
    ).getHorse(horseId))!;
    expect(h.birthDate, LocalDate(2015, 4, 2));
    final e = (await CareRepository(dbB).watchEvents(horseId).first);
    expect(
      e.any(
        (x) =>
            x.date == LocalDate(2026, 10, 25) &&
            x.fields[CareFields.epg] == 150,
      ),
      isTrue,
    );
    final photoRow = (await dbB.select(dbB.horsePhotos).get()).single;
    expect(File('${dirB.path}/${photoRow.relativePath}').readAsBytesSync(), [
      1,
      2,
      3,
      4,
    ]);

    // Letzter Export = Zeitpunkt der Sicherung.
    expect(
      await SettingsRepository(dbB).getValue(SettingKeys.lastExportAt),
      '2026-11-25T18:00:00.000Z',
    );
  });

  test('Import ersetzt vorhandene Daten vollständig', () async {
    await HorseRepository(
      dbB,
      PhotoStorage(() async => dirB),
    ).createHorse(const Horse(id: '', name: 'Alt'));
    File('${dirB.path}/photos/alt.jpg')
      ..createSync(recursive: true)
      ..writeAsBytesSync([9]);
    await HorseRepository(
      dbA,
      PhotoStorage(() async => dirA),
    ).createHorse(const Horse(id: '', name: 'Neu'));
    final (zip, _) = await a.export();
    await b.import(zip);
    final names = (await dbB.select(dbB.horses).get()).map((h) => h.name);
    expect(names, ['Neu']);
    expect(File('${dirB.path}/photos/alt.jpg').existsSync(), isFalse);
    // Eingebaute Eintragsarten sind weiterhin da.
    expect(
      await dbB.select(dbB.careEventTypes).get(),
      hasLength(BuiltinCareTypes.all.length),
    );
  });

  test(
    'ungültige oder zu neue Dateien werden abgelehnt, nichts geht verloren',
    () async {
      await HorseRepository(
        dbB,
        PhotoStorage(() async => dirB),
      ).createHorse(const Horse(id: '', name: 'Bleibt'));
      await expectLater(
        b.import(Uint8List.fromList([1, 2, 3])),
        throwsA(
          isA<BackupException>().having(
            (e) => e.error,
            'error',
            BackupError.notABackup,
          ),
        ),
      );

      final (zip, _) = await a.export();
      final archive = ZipDecoder().decodeBytes(zip);
      final newer = Archive();
      for (final f in archive.files) {
        if (f.name == BackupFormat.manifestFile) {
          final m = jsonDecode(
            utf8.decode(f.content as List<int>),
          ) as Map<String, Object?>;
          m['schema_version'] = 999;
          final bytes = utf8.encode(jsonEncode(m));
          newer.addFile(ArchiveFile(f.name, bytes.length, bytes));
        } else {
          newer.addFile(f);
        }
      }
      await expectLater(
        b.import(Uint8List.fromList(ZipEncoder().encode(newer))),
        throwsA(
          isA<BackupException>().having(
            (e) => e.error,
            'error',
            BackupError.tooNew,
          ),
        ),
      );
      expect((await dbB.select(dbB.horses).get()).single.name, 'Bleibt');
    },
  );

  test(
    'ältere Sicherung ohne neue Tabellen/Spalten lässt sich einspielen',
    () async {
      await HorseRepository(
        dbA,
        PhotoStorage(() async => dirA),
      ).createHorse(const Horse(id: '', name: 'Alt'));
      final (zip, _) = await a.export();
      final archive = ZipDecoder().decodeBytes(zip);
      final old = Archive();
      for (final f in archive.files) {
        if (f.name.contains('blood_') || f.name.contains('feed_')) {
          continue; // gab es früher nicht
        }
        if (f.name == 'data/horses.json') {
          final rows = jsonDecode(utf8.decode(f.content as List<int>)) as List;
          for (final r in rows) {
            (r as Map).remove('birthday_reminder');
          }
          final bytes = utf8.encode(jsonEncode(rows));
          old.addFile(ArchiveFile(f.name, bytes.length, bytes));
        } else {
          old.addFile(f);
        }
      }
      await b.import(Uint8List.fromList(ZipEncoder().encode(old)));
      final h = (await dbB.select(dbB.horses).get()).single;
      expect(h.name, 'Alt');
      expect(h.birthdayReminder, isFalse);
    },
  );

  group('Format-Logik', () {
    test('Erinnerung nach 7 Tagen bzw. wenn nie gesichert', () {
      final now = DateTime.utc(2026, 11, 25);
      expect(
        shouldRemindExport(
          lastExport: null,
          snoozedUntil: null,
          hasData: true,
          now: now,
        ),
        isTrue,
      );
      expect(
        shouldRemindExport(
          lastExport: null,
          snoozedUntil: null,
          hasData: false,
          now: now,
        ),
        isFalse,
      );
      expect(
        shouldRemindExport(
          lastExport: now.subtract(const Duration(days: 6)),
          snoozedUntil: null,
          hasData: true,
          now: now,
        ),
        isFalse,
      );
      expect(
        shouldRemindExport(
          lastExport: now.subtract(const Duration(days: 7)),
          snoozedUntil: null,
          hasData: true,
          now: now,
        ),
        isTrue,
      );
      expect(
        shouldRemindExport(
          lastExport: null,
          snoozedUntil: now.add(const Duration(hours: 1)),
          hasData: true,
          now: now,
        ),
        isFalse,
      );
      expect(daysSinceExport(now.subtract(const Duration(days: 10)), now), 10);
    });

    test('Dateiname', () {
      expect(
        backupFileName(DateTime(2026, 3, 5, 8, 7)),
        'pferdekalender-2026-03-05-0807.zip',
      );
    });
  });
}
