import 'dart:async';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/router/app_router.dart';
import 'package:pferdekalender/core/router/routes.dart';
import 'package:pferdekalender/features/backup/data/backup_service.dart';
import 'package:pferdekalender/features/pferd/data/horse_repository.dart';
import 'package:pferdekalender/features/pferd/data/photo_storage.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('Banner erinnert, Export teilt ZIP, Banner verschwindet', (
    tester,
  ) async {
    final app = TestApp.create();
    await app.container
        .read(horseRepositoryProvider)
        .createHorse(const Horse(id: '', name: 'Amigo'));
    await app.pump(tester);

    expect(
      find.text('Noch keine Datensicherung – jetzt sichern?'),
      findsOneWidget,
    );
    await tester.tap(find.text('Sichern'));
    await app.settle(tester);
    expect(app.backupFiles.shared, hasLength(1));
    expect(app.backupFiles.shared.single.$1, startsWith('pferdekalender-'));
    expect(app.backupFiles.shared.single.$1, endsWith('.zip'));
    expect(
      find.text('Noch keine Datensicherung – jetzt sichern?'),
      findsNothing,
    );

    await app.dispose(tester);
  });

  testWidgets('Import mit Bestätigung, vorher automatische Sicherung', (
    tester,
  ) async {
    // Sicherung von einem „anderen Gerät“ mit Pferd „Bella“ (echte I/O
    // außerhalb der Testzeit).
    final (zip, dir) = (await tester.runAsync(() async {
      final other = AppDatabase(NativeDatabase.memory());
      final dir = await Directory.systemTemp.createTemp('other');
      await HorseRepository(
        other,
        PhotoStorage(() async => dir),
      ).createHorse(const Horse(id: '', name: 'Bella'));
      final (zip, _) = await BackupService(
        other,
        PhotoStorage(() async => dir),
        appVersion: '0.6.0',
        platform: 'web',
      ).export();
      await other.close();
      return (zip, dir);
    }))!;

    final app = TestApp.create();
    await app.container
        .read(horseRepositoryProvider)
        .createHorse(const Horse(id: '', name: 'Amigo'));
    app.backupFiles.toPick = zip;
    await app.pump(tester);
    unawaited(app.container.read(routerProvider).push(Routes.settings));
    await app.settle(tester);

    await tester.scrollUntilVisible(find.text('Daten importieren'), 200);
    await tester.tap(find.text('Daten importieren'));
    await app.settle(tester);
    expect(find.text('Alle Daten ersetzen?'), findsOneWidget);
    expect(find.textContaining('1 Pferd'), findsOneWidget);
    await tester.tap(find.text('Ersetzen'));
    await app.settle(tester);

    expect(app.backupFiles.autoBackups, hasLength(1));
    expect(
      app.backupFiles.autoBackups.single.$1,
      startsWith('pferdekalender-vor-import'),
    );
    final horses = await app.read(
      tester,
      () => app.db.select(app.db.horses).get(),
    );
    expect(horses.map((h) => h.name), ['Bella']);
    expect(find.textContaining('Import abgeschlossen'), findsOneWidget);

    await app.dispose(tester);
    await tester.runAsync(() => dir.delete(recursive: true));
  });
}
