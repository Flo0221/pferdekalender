import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/core/router/app_router.dart';
import 'package:pferdekalender/core/router/routes.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';
import 'package:pferdekalender/features/pflege/data/care_repository.dart';
import 'package:pferdekalender/features/pflege/domain/care_event.dart';
import 'package:pferdekalender/features/pflege/domain/care_type.dart';
import 'package:pferdekalender/features/pflege/ui/care_calendar_export.dart';
import 'package:pferdekalender/features/pflege/ui/care_providers.dart';
import 'package:pferdekalender/features/pflege/ui/widgets/care_today_card.dart';

import '../../helpers/fake_web_env.dart';
import '../../helpers/test_app.dart';

CareEvent _ev(String horse, LocalDate d, {bool done = false, String id = ''}) =>
    CareEvent(
      id: id,
      horseId: horse,
      typeId: BuiltinCareTypes.huf,
      date: d,
      done: done,
      reminderOffsets: const [1],
    );

void main() {
  final today = LocalDate.today();

  test('Heute-Karte: Einteilung überfällig / heute / 7 Tage', () {
    final g = groupForToday([
      _ev('h', today.addDays(-3)),
      _ev('h', today.addDays(-1), done: true),
      _ev('h', today),
      _ev('h', today.addDays(1)),
      _ev('h', today.addDays(7)),
      _ev('h', today.addDays(8)),
    ], today);
    expect(g.overdue, hasLength(1));
    expect(g.today, hasLength(1));
    expect(g.next7, hasLength(2));
  });

  test('Export: heute bis +3 Monate, sortiert, ohne Überfällige', () {
    ReminderCandidate c(LocalDate d) =>
        ReminderCandidate(event: _ev('h', d), horseName: 'A', typeName: 'H');
    final r = upcomingForExport([
      c(today.addMonths(2)),
      c(today.addDays(-1)),
      c(today),
      c(today.addMonths(3)),
      c(today.addMonths(3).addDays(1)),
    ], today);
    expect(r.map((x) => x.event.date), [
      today,
      today.addMonths(2),
      today.addMonths(3),
    ]);
  });

  testWidgets('Web: Karte im Pflege-Tab, Export aller Pferde, Abzeichen', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final env = FakeWebEnv(isStandalone: true);
    final app = TestApp.create(webEnv: env);
    final horses = app.container.read(horseRepositoryProvider);
    final care = app.container.read(careRepositoryProvider);
    final a = await horses.createHorse(const Horse(id: '', name: 'Amigo'));
    final b = await horses.createHorse(const Horse(id: '', name: 'Bella'));
    await care.saveEvent(_ev(a, today.addDays(-2)));
    await care.saveEvent(_ev(a, today));
    await care.saveEvent(_ev(a, today.addDays(3)));
    await care.saveEvent(_ev(b, today.addDays(10)));
    await care.saveEvent(_ev(b, today));
    await app.pump(tester);

    expect(find.text('Auf einen Blick'), findsOneWidget);
    String countOf(String label) {
      final col = find
          .ancestor(of: find.text(label), matching: find.byType(Column))
          .first;
      return tester
          .widget<Text>(
            find.descendant(of: col, matching: find.byType(Text)).first,
          )
          .data!;
    }

    expect(countOf('Überfällig'), '1');
    expect(countOf('Heute'), '1');
    expect(countOf('Nächste 7 Tage'), '1');
    // Screenreader liest „Überfällig: 1“
    expect(find.bySemanticsLabel(RegExp('Überfällig: 1')), findsOneWidget);
    // Abzeichen: überfällig + heute über alle Pferde
    expect(env.badge, 3);

    final exportButton = find.text('Nächste 3 Monate in Kalender');
    await tester.ensureVisible(exportButton);
    await tester.pumpAndSettle();
    await tester.tap(exportButton);
    await app.settle(tester);
    expect(env.downloads, hasLength(1));
    final (name, mime, bytes) = env.downloads.single;
    expect(name, endsWith('.ics'));
    expect(mime, 'text/calendar');
    final ics = utf8.decode(bytes).replaceAll('\r\n ', '');
    // 4 Termine ab heute (beide Pferde), der überfällige nicht
    expect('BEGIN:VEVENT'.allMatches(ics), hasLength(4));
    expect(ics, contains('SUMMARY:Amigo: '));
    expect(ics, contains('SUMMARY:Bella: '));
    expect(ics, contains('TRIGGER:-PT15H'));
    expect(find.textContaining('4 Termine exportiert'), findsOneWidget);
    await app.dispose(tester);
    semantics.dispose();
  });

  testWidgets('Web: einzelnen Termin aus dem Formular exportieren', (
    tester,
  ) async {
    final env = FakeWebEnv(isStandalone: true);
    final app = TestApp.create(webEnv: env);
    final h = await app.container
        .read(horseRepositoryProvider)
        .createHorse(const Horse(id: '', name: 'Amigo'));
    final id = await app.container
        .read(careRepositoryProvider)
        .saveEvent(_ev(h, today.addDays(5)));
    await app.pump(tester);
    unawaited(app.container.read(routerProvider).push(Routes.careEdit(id)));
    await app.settle(tester);
    await tester.tap(find.byTooltip('In Kalender übernehmen'));
    await app.settle(tester);
    final ics = utf8.decode(env.downloads.single.$3);
    expect(ics, contains('UID:care-$id@pferdekalender'));
    expect('BEGIN:VEVENT'.allMatches(ics), hasLength(1));
    await app.dispose(tester);
  });

  testWidgets('Android/iOS: keine Karte, kein Kalender-Knopf', (tester) async {
    final app = TestApp.create();
    final h = await app.container
        .read(horseRepositoryProvider)
        .createHorse(const Horse(id: '', name: 'Amigo'));
    final id = await app.container
        .read(careRepositoryProvider)
        .saveEvent(_ev(h, today));
    await app.pump(tester);
    expect(find.text('Auf einen Blick'), findsNothing);
    unawaited(app.container.read(routerProvider).push(Routes.careEdit(id)));
    await app.settle(tester);
    expect(find.byTooltip('In Kalender übernehmen'), findsNothing);
    await app.dispose(tester);
  });
}
