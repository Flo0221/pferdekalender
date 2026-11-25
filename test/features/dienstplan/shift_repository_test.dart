import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/dienstplan/data/shift_repository.dart';
import 'package:pferdekalender/features/dienstplan/domain/shift.dart';
import 'package:pferdekalender/features/einstellungen/data/settings_repository.dart';
import 'package:pferdekalender/features/einstellungen/domain/setting_keys.dart';

void main() {
  late AppDatabase db;
  late ShiftRepository repo;
  var now = DateTime.utc(2026, 11, 25, 10);

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ShiftRepository(db, clock: () => now);
  });
  tearDown(() => db.close());

  final monday = LocalDate(2026, 11, 30);

  Future<Map<String, String>> templateIds() async => {
    for (final t in await repo.watchTemplates().first) t.name: t.id,
  };

  test('Standard-Vorlagen anlegen', () async {
    await repo.createDefaultTemplates();
    final t = await repo.watchTemplates().first;
    expect(t.map((x) => x.name), ['Früh', 'Spät', 'Nacht', 'Frei', 'Urlaub']);
    expect(t.firstWhere((x) => x.name == 'Nacht').isNight, isTrue);
    expect(t.firstWhere((x) => x.name == 'Frei').stableMinutes, 150);
  });

  test(
    'Schnell eintragen, Zusatzangaben bleiben, leerer Tag wird gelöscht',
    () async {
      await repo.createDefaultTemplates();
      final ids = await templateIds();
      await repo.saveDay(
        ShiftDay(date: monday, templateId: ids['Früh'], overrideMinutes: 20),
      );
      await repo.setShift(monday, ids['Spät']);
      final day = (await repo.getDays(monday, monday))[monday]!;
      expect(day.templateId, ids['Spät']);
      expect(day.overrideMinutes, 20);

      await repo.saveDay(ShiftDay(date: monday));
      expect(await repo.getDays(monday, monday), isEmpty);
    },
  );

  test('Jede Änderung merkt sich den Zeitpunkt für das Training', () async {
    final settings = SettingsRepository(db);
    await repo.createDefaultTemplates();
    now = DateTime.utc(2026, 11, 26, 8);
    await repo.setShift(monday, (await templateIds())['Früh']);
    expect(
      await settings.getValue(SettingKeys.shiftChangedAt),
      '2026-11-26T08:00:00.000Z',
    );
  });

  test(
    'Rhythmus ausrollen, manuelle Tage bleiben, erneut kürzer ausrollen',
    () async {
      await repo.createDefaultTemplates();
      final ids = await templateIds();
      await repo.setShift(monday.addDays(1), ids['Urlaub']);

      final r = await repo.applyPattern(
        ShiftPattern(
          id: '',
          name: 'Wechsel',
          steps: [
            ids['Früh'],
            ids['Früh'],
            ids['Nacht'],
            ids['Nacht'],
            null,
            null,
          ],
          startDate: monday,
          weeks: 4,
        ),
      );
      expect(r.skippedManual, [monday.addDays(1)]);
      var days = await repo.getDays(monday, monday.addDays(27));
      expect(days[monday]!.templateId, ids['Früh']);
      expect(days[monday.addDays(1)]!.templateId, ids['Urlaub']);
      expect(days[monday.addDays(2)]!.templateId, ids['Nacht']);
      expect(
        days.containsKey(monday.addDays(4)),
        isFalse,
        reason: 'leerer Zyklustag',
      );
      expect(days[monday.addDays(6)]!.templateId, ids['Früh']);

      final pattern = (await repo.watchPatterns().first).single;
      await repo.applyPattern(
        ShiftPattern(
          id: pattern.id,
          name: pattern.name,
          steps: pattern.steps,
          startDate: monday,
          weeks: 1,
        ),
      );
      days = await repo.getDays(monday, monday.addDays(27));
      expect(days.keys.every((d) => d.isBefore(monday.addDays(7))), isTrue);
      expect(days[monday.addDays(1)]!.templateId, ids['Urlaub']);
    },
  );

  test('Rhythmus löschen mit Tagen ab Datum, manuelle bleiben', () async {
    await repo.createDefaultTemplates();
    final ids = await templateIds();
    await repo.applyPattern(
      ShiftPattern(
        id: '',
        name: 'Nur Früh',
        steps: [ids['Früh']],
        startDate: monday,
        weeks: 2,
      ),
    );
    await repo.setShift(monday.addDays(10), ids['Frei']); // jetzt manuell
    final p = (await repo.watchPatterns().first).single;
    await repo.deletePattern(p.id, removeDays: true, from: monday.addDays(7));

    final days = await repo.getDays(monday, monday.addDays(13));
    expect(days.length, 8); // 7 Tage vorher + 1 manueller
    expect(days[monday.addDays(10)]!.templateId, ids['Frei']);
    expect(await repo.watchPatterns().first, isEmpty);
  });

  test('Vorlage löschen: verwendet → ausblenden, sonst löschen', () async {
    await repo.createDefaultTemplates();
    final ids = await templateIds();
    await repo.setShift(monday, ids['Früh']);
    expect(await repo.removeTemplate(ids['Früh']!), isFalse);
    expect(await repo.removeTemplate(ids['Urlaub']!), isTrue);

    final active = await repo.watchTemplates().first;
    expect(active.map((t) => t.name), isNot(contains('Früh')));
    final all = await repo.watchTemplates(includeArchived: true).first;
    expect(all.map((t) => t.name), contains('Früh'));
    expect(all.map((t) => t.name), isNot(contains('Urlaub')));
    expect(
      (await repo.getDays(monday, monday))[monday]!.templateId,
      ids['Früh'],
    );
  });
}
