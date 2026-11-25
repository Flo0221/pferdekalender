import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/app.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/db/database_provider.dart';
import 'package:pferdekalender/core/files/documents_dir_provider.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/pferd/domain/contact.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';
import 'package:pferdekalender/features/pferd/ui/pferd_screen.dart';
import 'package:pferdekalender/features/pferd/ui/widgets/weight_chart.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  testWidgets('Profil zeigt Felder, Gewichtsverlauf und anrufbare Kontakte', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        documentsDirProvider.overrideWith((ref) async => Directory.systemTemp),
      ],
    );
    final repo = container.read(horseRepositoryProvider);
    final id = await repo.createHorse(
      Horse(
        id: '',
        name: 'Bella',
        birthDate: LocalDate(2018, 4, 1),
        sex: HorseSex.stute,
        chipNumber: '276098102345678',
        intolerances: 'Kein Luzerne',
      ),
    );
    await repo.addWeight(id, LocalDate(2026, 1, 10), 520);
    await repo.addWeight(id, LocalDate(2026, 4, 10), 534.5);
    await repo.saveContact(
      const Contact(
        id: '',
        name: 'Dr. Huf',
        role: ContactRole.tierarzt,
        phone: '0171 1234567',
      ),
      horseId: id,
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const PferdekalenderApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Pferd'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('276098102345678'), findsOneWidget);
    expect(find.text('Kein Luzerne'), findsOneWidget);
    expect(find.textContaining('Stute'), findsOneWidget);

    final profileList = find
        .descendant(
          of: find.byType(PferdScreen),
          matching: find.byType(Scrollable),
        )
        .first;
    await tester.scrollUntilVisible(
      find.byType(WeightChart),
      300,
      scrollable: profileList,
    );
    expect(find.text('534,5 kg'), findsOneWidget);
    expect(
      find.bySemanticsLabel(
        RegExp('Gewichtsverlauf von 10.01.2026 bis 10.04.2026'),
      ),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.byTooltip('Dr. Huf anrufen'),
      -200,
      scrollable: profileList,
    );
    expect(find.byTooltip('Dr. Huf anrufen'), findsOneWidget);
    expect(find.textContaining('Tierarzt · 0171 1234567'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  });
}
