import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/db/database_provider.dart';
import 'package:pferdekalender/core/files/documents_dir_provider.dart';
import 'package:pferdekalender/core/notifications/notification_gateway.dart';
import 'package:pferdekalender/core/notifications/notification_providers.dart';
import 'package:pferdekalender/core/platform/web_env_stub.dart';
import 'package:pferdekalender/core/platform/web_providers.dart';
import 'package:pferdekalender/core/router/app_router.dart';
import 'package:pferdekalender/core/router/routes.dart';
import 'package:pferdekalender/features/backup/data/backup_service.dart';
import 'package:pferdekalender/features/pferd/data/horse_repository.dart';
import 'package:pferdekalender/features/pferd/data/photo_storage.dart';
import 'package:pferdekalender/features/pferd/data/photo_store.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';

import '../../helpers/fake_web_env.dart';
import '../../helpers/test_app.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('Plattform-Weiche (native Testlauf)', () {
    test('ohne Browser: WebEnv ist No-op', () async {
      final env = createWebEnv();
      expect(env, isA<NativeWebEnv>());
      expect(env.isWeb, isFalse);
      expect(env.isStandalone, isTrue);
      expect(await env.estimate(), isNull);
      expect(await env.requestPersist(), isTrue);
    });

    test('Fotos: native als Datei, Benachrichtigungen echt', () async {
      final db = AppDatabase(NativeDatabase.memory());
      final docs = Directory.systemTemp.createTempSync('pk_switch');
      final c = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          documentsDirProvider.overrideWith((ref) async => docs),
        ],
      );
      expect(c.read(photoStorageProvider), isA<PhotoStorage>());
      expect(
        c.read(notificationGatewayProvider),
        isNot(isA<UnsupportedNotificationGateway>()),
      );
      c.dispose();
      await db.close();
      docs.deleteSync(recursive: true);
    });

    test('Web-Benachrichtigungen: nicht unterstützt, plant nichts', () async {
      final g = UnsupportedNotificationGateway();
      expect(g.maxPending, 0);
      expect((await g.permissionState()).supported, isFalse);
    });
  });

  group('DbPhotoStore (Web)', () {
    late AppDatabase db;
    setUp(() => db = AppDatabase(NativeDatabase.memory()));
    tearDown(() => db.close());

    test('speichert, liest, löscht Blobs', () async {
      final store = DbPhotoStore(db);
      final rel = await store.importPhoto(
        'abc',
        bytes: Uint8List.fromList([1, 2, 3]),
        extension: '.JPG',
      );
      expect(rel, 'photos/abc.jpg');
      expect(await store.readBytes(rel), [1, 2, 3]);
      await store.writeBytes(rel, Uint8List.fromList([9]));
      expect(await store.readBytes(rel), [9]);
      await store.deleteFile(rel);
      expect(await store.readBytes(rel), isNull);
    });

    test('Pferd löschen entfernt auch die Blobs', () async {
      final repo = HorseRepository(db, DbPhotoStore(db));
      final id = await repo.createHorse(const Horse(id: '', name: 'Amigo'));
      await repo.addPhoto(id, null, bytes: Uint8List.fromList([1, 2]));
      expect(await db.select(db.photoBlobs).get(), hasLength(1));
      await repo.deleteHorsePermanently(id);
      expect(await db.select(db.photoBlobs).get(), isEmpty);
    });

    test('Sicherung Web → Android: Foto landet als Datei', () async {
      final web = AppDatabase(NativeDatabase.memory());
      final android = AppDatabase(NativeDatabase.memory());
      final dir = Directory.systemTemp.createTempSync('pk_android');
      final webRepo = HorseRepository(web, DbPhotoStore(web));
      final id = await webRepo.createHorse(const Horse(id: '', name: 'Amigo'));
      await webRepo.addPhoto(id, null, bytes: Uint8List.fromList([7, 7, 7]));

      final (zip, manifest) = await BackupService(
        web,
        DbPhotoStore(web),
        appVersion: '1',
        platform: 'web',
      ).export();
      expect(manifest.photos, 1);
      final files = PhotoStorage(() async => dir);
      await BackupService(
        android,
        files,
        appVersion: '1',
        platform: 'android',
      ).import(zip);
      final photo = await android.select(android.horsePhotos).getSingle();
      expect(await files.readBytes(photo.relativePath), [7, 7, 7]);
      // Blob-Tabelle wird nicht als JSON exportiert.
      expect(await android.select(android.photoBlobs).get(), isEmpty);

      // … und zurück ins Web: wieder als Blob.
      final (zip2, _) = await BackupService(
        android,
        files,
        appVersion: '1',
        platform: 'android',
      ).export();
      final web2 = AppDatabase(NativeDatabase.memory());
      await BackupService(
        web2,
        DbPhotoStore(web2),
        appVersion: '1',
        platform: 'web',
      ).import(zip2);
      expect(await DbPhotoStore(web2).readBytes(photo.relativePath), [7, 7, 7]);
      await web.close();
      await android.close();
      await web2.close();
      dir.deleteSync(recursive: true);
    });
  });

  test('Größenangaben deutsch', () {
    expect(formatBytes(512), '512 B');
    expect(formatBytes(3400000), '3,4 MB');
    expect(formatBytes(1000000000), '1,0 GB');
    expect(formatBytes(250000), '250 KB');
  });

  group('Web-Hinweise', () {
    testWidgets('Browser-Tab: Installations-Hinweis mit Anleitung', (
      tester,
    ) async {
      final app = TestApp.create(webEnv: FakeWebEnv());
      await app.pump(tester);
      expect(
        find.textContaining('Zum Home-Bildschirm installieren'),
        findsOneWidget,
      );
      await tester.tap(find.text('So geht’s'));
      await tester.pumpAndSettle();
      expect(find.text('Als App installieren'), findsOneWidget);
      expect(find.textContaining('„Teilen“'), findsOneWidget);
      await app.dispose(tester);
    });

    testWidgets('installiert: kein Hinweis; Update nur auf Knopfdruck', (
      tester,
    ) async {
      final env = FakeWebEnv(isStandalone: true);
      final app = TestApp.create(webEnv: env);
      await app.pump(tester);
      expect(find.textContaining('Zum Home-Bildschirm'), findsNothing);
      expect(
        find.text('Neue Version verfügbar – jetzt neu laden'),
        findsNothing,
      );
      env.announceUpdate();
      await tester.pump();
      await tester.pump();
      expect(
        find.text('Neue Version verfügbar – jetzt neu laden'),
        findsOneWidget,
      );
      expect(env.applyUpdateCalls, 0);
      await tester.tap(find.text('Neu laden'));
      expect(env.applyUpdateCalls, 1);
      await app.dispose(tester);
    });

    testWidgets('Einstellungen: Speicher dauerhaft, Belegung, Warnung', (
      tester,
    ) async {
      final env = FakeWebEnv(isStandalone: true);
      final app = TestApp.create(webEnv: env);
      await app.pump(tester);
      unawaited(app.container.read(routerProvider).push(Routes.settings));
      await tester.pumpAndSettle();
      final persisted = find.text('Speicher dauerhaft: nein');
      await tester.scrollUntilVisible(persisted, 200);
      expect(find.textContaining('Belegt: 3,4 MB'), findsOneWidget);
      final request = find.text('Dauerhaften Speicher anfordern');
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(request, 100);
      await tester.pumpAndSettle();
      await tester.tap(request);
      await tester.pumpAndSettle();
      expect(env.persistRequests, 1);
      expect(find.text('Speicher dauerhaft: ja'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.textContaining('Website-Daten im Browser'),
        200,
      );
      await app.dispose(tester);
    });

    testWidgets('native: keine Web-Hinweise, kein Browser-Speicher', (
      tester,
    ) async {
      final app = TestApp.create();
      await app.pump(tester);
      expect(find.textContaining('Zum Home-Bildschirm'), findsNothing);
      unawaited(app.container.read(routerProvider).push(Routes.settings));
      await tester.pumpAndSettle();
      expect(find.text('Speicher im Browser'), findsNothing);
      await app.dispose(tester);
    });
  });

  group('Web-Dateien', () {
    test('manifest.json: deutsch, standalone, relativer Scope, Icons', () {
      final m = jsonDecode(
        File('web/manifest.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      expect(m['lang'], 'de');
      expect(m['display'], 'standalone');
      expect(m['start_url'], './');
      expect(m['scope'], './');
      final icons = (m['icons'] as List).cast<Map<String, dynamic>>();
      expect(icons.any((i) => i['purpose'] == 'maskable'), isTrue);
      for (final i in icons) {
        expect(File('web/${i['src']}').existsSync(), isTrue, reason: '$i');
      }
    });

    test('index.html: iOS-Tags, Safe Area, keine fremden Server', () {
      final html = File('web/index.html').readAsStringSync();
      expect(html, contains('apple-touch-icon'));
      expect(html, contains('apple-mobile-web-app-capable'));
      expect(html, contains('viewport-fit=cover'));
      expect(html, contains('safe-area-inset-bottom'));
      expect(html, contains("register('sw.js'"));
      for (final f in ['web/index.html', 'web/flutter_bootstrap.js']) {
        expect(
          RegExp(r'https?://').hasMatch(File(f).readAsStringSync()),
          isFalse,
          reason: '$f enthält eine externe URL',
        );
      }
      final boot = File('web/flutter_bootstrap.js').readAsStringSync();
      expect(boot, contains("canvasKitBaseUrl: 'canvaskit/'"));
      expect(boot, contains('fontFallbackBaseUrl'));
    });

    test(
      'Service Worker: kein automatisches Aktivieren, nur gleiche Herkunft',
      () {
        final sw = File('web/sw.js').readAsStringSync();
        expect(sw, contains("'SKIP_WAITING'"));
        // skipWaiting nur auf Nachricht der App.
        expect(RegExp(r'self\.skipWaiting\(\)').allMatches(sw).length, 1);
        expect(sw, contains('self.location.origin'));
      },
    );

    test('Datenbank-Dateien liegen lokal in web/', () {
      expect(File('web/sqlite3.wasm').existsSync(), isTrue);
      expect(File('web/drift_worker.js').existsSync(), isTrue);
    });
  });
}
