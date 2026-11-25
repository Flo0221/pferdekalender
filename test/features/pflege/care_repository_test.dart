import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/pferd/data/horse_repository.dart';
import 'package:pferdekalender/features/pferd/data/photo_storage.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pflege/data/care_repository.dart';
import 'package:pferdekalender/features/pflege/domain/care_event.dart';
import 'package:pferdekalender/features/pflege/domain/care_type.dart';
import 'package:pferdekalender/features/pflege/domain/repeat_interval.dart';

void main() {
  late AppDatabase db;
  late CareRepository care;
  late HorseRepository horses;
  late String horseId;

  const sevenWeeks = RepeatInterval(7, IntervalUnit.weeks);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    care = CareRepository(db);
    horses = HorseRepository(
      db,
      PhotoStorage(() async => Directory.systemTemp),
    );
    horseId = await horses.createHorse(const Horse(id: '', name: 'Amigo'));
  });
  tearDown(() => db.close());

  CareEvent huf(LocalDate date, {bool done = false, RepeatInterval? repeat}) =>
      CareEvent(
        id: '',
        horseId: horseId,
        typeId: BuiltinCareTypes.huf,
        date: date,
        done: done,
        variantKey: 'beschlag',
        person: 'Schmied Meier',
        costCents: 13500,
        repeat: repeat,
        reminderOffsets: const [7, 1],
      );

  test('eingebaute Arten und Intervalle sind angelegt', () async {
    final types = await care.watchTypes().first;
    expect(types.map((t) => t.id), contains(BuiltinCareTypes.wurmkur));
    expect(types, hasLength(BuiltinCareTypes.all.length));
    final defaults = await care.watchIntervalDefaults().first;
    expect(defaults.any((d) => d.variantKey == 'influenza'), isTrue);
  });

  test('Speichern mit Wiederholung legt genau einen Folgetermin an', () async {
    final id = await care.saveEvent(
      huf(LocalDate(2026, 5, 4), repeat: sevenWeeks),
    );
    final all = await care.watchEvents(horseId).first;
    expect(all, hasLength(2));
    final f = (await care.getFollowUp(id))!;
    expect(f.date, LocalDate(2026, 6, 22));
    expect(f.done, isFalse);
    expect(f.reminderOffsets, [1, 7]);
    expect(f.costCents, isNull);
    expect(f.seriesId, id);

    // Erneutes Speichern ohne Änderung → kein weiterer Termin.
    await care.saveEvent((await care.getEvent(id))!);
    await care.saveEvent(f); // offener Folgetermin plant nicht weiter voraus
    expect(await care.watchEvents(horseId).first, hasLength(2));
  });

  test('Erledigen mit anderem Datum: Folgetermin nur auf Wunsch neu', () async {
    final id = await care.saveEvent(
      huf(LocalDate(2026, 5, 4), repeat: sevenWeeks),
    );
    await care.markDone(id, LocalDate(2026, 5, 11), recalculateFollowUp: false);
    expect((await care.getFollowUp(id))!.date, LocalDate(2026, 6, 22));
    expect((await care.getEvent(id))!.done, isTrue);
    expect((await care.getEvent(id))!.date, LocalDate(2026, 5, 11));

    await care.markOpen(id);
    await care.markDone(id, LocalDate(2026, 5, 11), recalculateFollowUp: true);
    expect((await care.getFollowUp(id))!.date, LocalDate(2026, 6, 29));
  });

  test('Kette: erledigter Folgetermin erzeugt den nächsten', () async {
    final a = await care.saveEvent(
      huf(LocalDate(2026, 5, 4), repeat: sevenWeeks),
    );
    await care.markDone(a, LocalDate(2026, 5, 4), recalculateFollowUp: false);
    final f = (await care.getFollowUp(a))!;
    await care.markDone(
      f.id,
      LocalDate(2026, 6, 22),
      recalculateFollowUp: false,
    );
    final g = (await care.getFollowUp(f.id))!;
    expect(g.date, LocalDate(2026, 8, 10));
    expect(g.seriesId, a);
    expect(await care.watchEvents(horseId).first, hasLength(3));
  });

  test('Wiederholung entfernen löscht den offenen Folgetermin', () async {
    final id = await care.saveEvent(
      huf(LocalDate(2026, 5, 4), repeat: sevenWeeks),
    );
    final e = (await care.getEvent(id))!;
    await care.saveEvent(
      CareEvent(
        id: e.id,
        horseId: e.horseId,
        typeId: e.typeId,
        date: e.date,
        seriesId: e.seriesId,
      ),
    );
    expect(await care.getFollowUp(id), isNull);
    expect(await care.watchEvents(horseId).first, hasLength(1));
  });

  test('Löschen: optional mit offenem Folgetermin', () async {
    final a = await care.saveEvent(
      huf(LocalDate(2026, 5, 4), repeat: sevenWeeks),
    );
    await care.deleteEvent(a);
    expect(
      await care.watchEvents(horseId).first,
      hasLength(1),
      reason: 'Folgetermin bleibt',
    );

    final b = await care.saveEvent(
      huf(LocalDate(2026, 9, 1), repeat: sevenWeeks),
    );
    await care.deleteEvent(b, deleteOpenFollowUp: true);
    expect(await care.watchEvents(horseId).first, hasLength(1));
  });

  test('Typspezifische Felder und Vorschläge', () async {
    Future<void> wurm(LocalDate d, String p, String w) => care.saveEvent(
      CareEvent(
        id: '',
        horseId: horseId,
        typeId: BuiltinCareTypes.wurmkur,
        date: d,
        done: true,
        fields: {CareFields.praeparat: p, CareFields.wirkstoff: w},
      ),
    );
    await wurm(LocalDate(2026, 3, 1), 'Equest Pramox', 'Moxidectin');
    await wurm(LocalDate(2026, 9, 1), 'Banminth', 'Pyrantel');
    await wurm(LocalDate(2025, 9, 1), 'Equest Pramox', 'Moxidectin');

    final events = await care.watchEvents(horseId).first;
    expect(events.first.fields[CareFields.praeparat], 'Equest Pramox');
    expect(
      await care.suggestions(
        CareFields.praeparat,
        typeId: BuiltinCareTypes.wurmkur,
      ),
      ['Banminth', 'Equest Pramox'],
    );

    await care.saveEvent(huf(LocalDate(2026, 1, 1)));
    expect(await care.suggestions('person'), ['Schmied Meier']);
  });

  test('Kotprobe speichert EpG als Zahl', () async {
    final id = await care.saveEvent(
      CareEvent(
        id: '',
        horseId: horseId,
        typeId: BuiltinCareTypes.kotprobe,
        date: LocalDate(2026, 6, 1),
        fields: const {
          CareFields.labor: 'Labor Nord',
          CareFields.epg: 150,
          CareFields.ergebnis: '',
        },
      ),
    );
    final e = (await care.getEvent(id))!;
    expect(e.fields[CareFields.epg], 150);
    expect(
      e.fields.containsKey(CareFields.ergebnis),
      isFalse,
      reason: 'leere Texte entfallen',
    );
  });

  test(
    'Intervall-Vorschläge ändern und entfernen bleiben nach Neustart',
    () async {
      await care.setIntervalDefault(
        BuiltinCareTypes.huf,
        'beschlag',
        const RepeatInterval(8, IntervalUnit.weeks),
      );
      await care.setIntervalDefault(BuiltinCareTypes.zahnarzt, null, null);
      // beforeOpen ergänzt Startwerte erneut – Änderungen müssen bleiben.
      await db.customStatement('SELECT 1');
      final defaults = await care.watchIntervalDefaults().first;
      expect(
        defaults.firstWhere((d) => d.variantKey == 'beschlag').interval,
        const RepeatInterval(8, IntervalUnit.weeks),
      );
      expect(
        defaults.any((d) => d.typeId == BuiltinCareTypes.zahnarzt),
        isFalse,
      );
    },
  );

  test('eigene Art anlegen und ausblenden', () async {
    final id = await care.saveType(
      const CareType(
        id: '',
        name: 'Turnier',
        kind: CareKind.allgemein,
        colorValue: 0xFF3949AB,
        iconKey: 'turnier',
      ),
    );
    expect((await care.watchTypes().first).last.id, id);
    await care.setTypeArchived(id, archived: true);
    expect((await care.watchTypes().first).any((t) => t.id == id), isFalse);
    expect(
      (await care.watchTypes(includeArchived: true).first).any(
        (t) => t.id == id,
      ),
      isTrue,
    );
  });

  test('Erinnerungs-Kandidaten: nur offene Termine aktiver Pferde', () async {
    final open = await care.saveEvent(huf(LocalDate(2026, 12, 1)));
    await care.saveEvent(huf(LocalDate(2026, 11, 1), done: true));
    await care.saveEvent(
      CareEvent(
        id: '',
        horseId: horseId,
        typeId: BuiltinCareTypes.tierarzt,
        date: LocalDate(2026, 12, 5),
      ),
    ); // ohne Erinnerung
    var c = await care.watchReminderCandidates().first;
    expect(c.single.event.id, open);
    expect(c.single.horseName, 'Amigo');
    expect(c.single.typeName, 'Hufbearbeitung');

    await horses.setArchived(horseId, archived: true);
    c = await care.watchReminderCandidates().first;
    expect(c, isEmpty);
  });

  test('Geburtstags-Kandidaten', () async {
    await horses.updateHorse(
      Horse(
        id: horseId,
        name: 'Amigo',
        callName: 'Mig',
        birthDate: LocalDate(2015, 4, 2),
      ),
    );
    expect(await care.watchBirthdayCandidates().first, isEmpty);
    await care.setBirthdayReminder(horseId, enabled: true);
    final b = (await care.watchBirthdayCandidates().first).single;
    expect(b.horseName, 'Mig');
    expect(b.birthDate, LocalDate(2015, 4, 2));
  });

  test('Pferd endgültig löschen entfernt seine Pflegeeinträge', () async {
    await care.saveEvent(huf(LocalDate(2026, 5, 4), repeat: sevenWeeks));
    await horses.deleteHorsePermanently(horseId);
    expect(await db.select(db.careEvents).get(), isEmpty);
    expect(await db.select(db.careReminders).get(), isEmpty);
  });
}
