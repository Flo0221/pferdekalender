import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/einstellungen/domain/reminder_settings.dart';
import 'package:pferdekalender/features/pflege/data/care_repository.dart';
import 'package:pferdekalender/features/pflege/domain/care_event.dart';
import 'package:pferdekalender/features/pflege/domain/care_type.dart';
import 'package:pferdekalender/features/pflege/ui/reminder_sync.dart';
import 'package:pferdekalender/l10n/generated/app_localizations.dart';

import '../../helpers/fake_notifications.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('de'));
  final now = DateTime(2026, 11, 25, 12);

  ReminderCandidate candidate(LocalDate date, List<int> offsets, {int? time}) =>
      ReminderCandidate(
        event: CareEvent(
          id: 'e1',
          horseId: 'h',
          typeId: BuiltinCareTypes.huf,
          date: date,
          timeMinutes: time,
          variantKey: 'beschlag',
          reminderOffsets: offsets,
        ),
        horseName: 'Didi',
        typeName: 'Hufbearbeitung',
      );

  test('Texte für Pflegetermine', () {
    final plan = buildReminderPlan(
      l10n: l10n,
      care: [
        candidate(LocalDate(2026, 12, 1), [0, 1], time: 14 * 60),
      ],
      birthdays: const [],
      settings: const ReminderSettings(),
      now: now,
    );
    expect(plan, hasLength(2));
    expect(plan.first.title, 'Didi: Hufbearbeitung · Beschlag');
    expect(plan.first.body, 'Hufbearbeitung für Didi – morgen, 14:00');
    expect(plan.last.body, 'Hufbearbeitung für Didi – heute, 14:00');
    expect(plan.first.payload, 'care:e1');
  });

  test('Geburtstag: dieses und nächstes Jahr, mit Alter', () {
    final plan = buildReminderPlan(
      l10n: l10n,
      care: const [],
      birthdays: [
        BirthdayCandidate(
          horseId: 'h',
          horseName: 'Didi',
          birthDate: LocalDate(2015, 4, 2),
        ),
      ],
      settings: const ReminderSettings(minutes: 8 * 60),
      now: now,
    );
    expect(plan.map((p) => p.date), [
      LocalDate(2027, 4, 2),
      LocalDate(2028, 4, 2),
    ]);
    expect(plan.first.body, 'Didi wird heute 12 Jahre alt.');
    expect(plan.first.minutes, 480);
  });

  test('ReminderSync plant nach Änderungen neu (entprellt)', () async {
    final gateway = FakeNotificationGateway();
    final care = StreamController<List<ReminderCandidate>>();
    final birthdays = StreamController<List<BirthdayCandidate>>();
    final sync = ReminderSync(
      gateway: gateway,
      l10n: l10n,
      care: care.stream,
      birthdays: birthdays.stream,
      debounce: const Duration(milliseconds: 10),
      clock: () => now,
    )..start();

    care.add([
      candidate(LocalDate(2026, 12, 1), [1]),
    ]);
    birthdays.add(const []);
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(gateway.replaceCalls, 0, reason: 'Einstellungen fehlen noch');

    sync.updateSettings(const ReminderSettings(exact: true));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(gateway.replaceCalls, 1);
    expect(gateway.planned, hasLength(1));
    expect(gateway.lastExact, isTrue);

    care.add(const []);
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(gateway.replaceCalls, 2);
    expect(gateway.planned, isEmpty);

    await sync.dispose();
    await care.close();
    await birthdays.close();
  });
}
