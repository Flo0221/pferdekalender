import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/futter/data/feed_repository.dart';
import 'package:pferdekalender/features/futter/domain/feed.dart';
import 'package:pferdekalender/features/gesundheit/data/blood_repository.dart';
import 'package:pferdekalender/features/gesundheit/domain/blood.dart';
import 'package:pferdekalender/features/gesundheit/domain/blood_evaluation.dart';
import 'package:pferdekalender/features/gesundheit/ui/blood_apply.dart';
import 'package:pferdekalender/features/pferd/data/horse_repository.dart';
import 'package:pferdekalender/features/pferd/data/photo_storage.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pflege/data/care_repository.dart';
import 'package:pferdekalender/features/pflege/domain/care_type.dart';
import 'package:pferdekalender/l10n/generated/app_localizations.dart';

import 'blood_evaluation_test.dart' show catalog;

void main() {
  late AppDatabase db;
  late BloodRepository blood;
  late FeedRepository feed;
  late CareRepository care;
  late HorseRepository horses;
  late String horseId;
  final l10n = lookupAppLocalizations(const Locale('de'));
  final today = LocalDate(2026, 11, 25);

  setUpAll(() => initializeDateFormatting('de_DE'));

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    blood = BloodRepository(db);
    feed = FeedRepository(db);
    care = CareRepository(db);
    horses = HorseRepository(
      db,
      PhotoStorage(() async => Directory.systemTemp),
    );
    horseId = await horses.createHorse(const Horse(id: '', name: 'Amigo'));
  });
  tearDown(() => db.close());

  Future<BloodTest> save(List<BloodValue> values, {String id = ''}) async {
    final newId = await blood.saveTest(
      BloodTest(
        id: id,
        horseId: horseId,
        date: LocalDate(2026, 11, 20),
        lab: 'Laboklin',
        values: values,
      ),
    );
    return (await blood.getTest(newId))!;
  }

  test('speichern, Werte ersetzen, neueste zuerst', () async {
    final t = await save(const [
      BloodValue(paramKey: 'ggt', value: 60),
      BloodValue(paramKey: 'selen', value: 80, refLow: 90),
    ]);
    expect(t.values, hasLength(2));
    expect(t.values.firstWhere((v) => v.paramKey == 'selen').refLow, 90);
    await save(const [BloodValue(paramKey: 'ggt', value: 50)], id: t.id);
    final again = (await blood.getTest(t.id))!;
    expect(again.values.single.value, 50);

    await blood.saveTest(
      BloodTest(id: '', horseId: horseId, date: LocalDate(2026, 12, 1)),
    );
    final all = await blood.getTests(horseId);
    expect(all.first.date, LocalDate(2026, 12, 1));
  });

  test(
    'Übernahme: Zusätze laut Packung, Termine, Hinweis im Futterplan',
    () async {
      final heu = await feed.saveItem(
        const FeedItem(
          id: '',
          name: 'Heu',
          category: FeedCategory.raufutter,
          unit: FeedUnit.kg,
        ),
      );
      await feed.savePlan(
        FeedPlan(
          id: '',
          horseId: horseId,
          name: 'Winter',
          validFrom: LocalDate(2026, 11, 1),
          notes: 'Bestehende Notiz',
          meals: [
            Meal(
              id: '',
              name: 'Morgens',
              entries: [MealEntry(id: '', itemId: heu, amount: 4)],
            ),
          ],
        ),
      );
      final t = await save(const [
        BloodValue(paramKey: 'ggt', value: 60),
        BloodValue(paramKey: 'insulin', value: 20),
      ]);
      final e = evaluate(t, catalog);
      final r = await applyBloodSuggestions(
        l10n: l10n,
        test: t,
        selected: e.suggestions,
        controlWeeks: e.controlWeeks,
        feed: feed,
        care: care,
        today: today,
      );
      expect(r.supplements, 1); // Leber-Ergänzung
      expect(r.events, 1); // Kontroll-Blutbild
      expect(
        r.notes,
        greaterThanOrEqualTo(2),
      ); // Heu prüfen, zuckerarm, Bewegung

      final supp = (await feed.watchSupplements(horseId).first).single;
      expect(supp.amount, isNull);
      expect(supp.source, SupplementSource.bloodTest);
      expect(supp.bloodTestId, t.id);
      expect(supp.start, today);
      expect(supp.end, today.addWeeks(6).addDays(-1));
      final item = (await feed.getItems()).firstWhere(
        (i) => i.id == supp.itemId,
      );
      expect(item.name, contains('Mariendistel'));

      final events = await care.watchEvents(horseId).first;
      final control = events.single;
      expect(control.typeId, BuiltinCareTypes.tierarzt);
      expect(control.title, 'Kontroll-Blutbild');
      expect(
        control.date,
        today.addDays(3 * 7),
      ); // γ-GT: Kontrolle nach 3 Wochen
      expect(control.reminderOffsets, [1]);

      final plan = (await feed.getPlans(horseId)).single;
      expect(plan.notes, startsWith('Bestehende Notiz'));
      expect(
        plan.notes,
        contains(
          'Hinweis aus Blutbild vom 20.11.2026: Stärke- und zuckerarm füttern',
        ),
      );
      expect(
        plan.meals.single.entries.single.amount,
        4,
        reason: 'Ration unverändert',
      );

      // Erneut übernehmen legt das Futtermittel nicht doppelt an.
      await applyBloodSuggestions(
        l10n: l10n,
        test: t,
        selected: e.suggestions,
        controlWeeks: e.controlWeeks,
        feed: feed,
        care: care,
        today: today,
      );
      expect(
        (await feed.getItems()).where((i) => i.name.contains('Mariendistel')),
        hasLength(1),
      );
    },
  );

  test('Pferd löschen entfernt Blutbilder', () async {
    await save(const [BloodValue(paramKey: 'ggt', value: 60)]);
    await horses.deleteHorsePermanently(horseId);
    expect(await db.select(db.bloodTests).get(), isEmpty);
    expect(await db.select(db.bloodValues).get(), isEmpty);
  });
}
