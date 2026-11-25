import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/platform/backup_exclusion.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() => messenger.setMockMethodCallHandler(backupChannel, null));

  test('iOS: schließt das Dokumentenverzeichnis vom Backup aus', () async {
    MethodCall? received;
    messenger.setMockMethodCallHandler(backupChannel, (call) async {
      received = call;
      return true;
    });
    final ok = await excludeAppDataFromBackup(
      isIOS: true,
      documentsDir: () async => Directory('/var/mobile/Documents'),
    );
    expect(ok, isTrue);
    expect(received!.method, 'excludeFromBackup');
    expect(received!.arguments, {'path': '/var/mobile/Documents'});
  });

  test('Android/sonstige: kein Aufruf', () async {
    var called = false;
    messenger.setMockMethodCallHandler(backupChannel, (call) async {
      called = true;
      return true;
    });
    expect(await excludeAppDataFromBackup(isIOS: false), isFalse);
    expect(called, isFalse);
  });

  test('Fehler auf der nativen Seite verhindern den Start nicht', () async {
    messenger.setMockMethodCallHandler(backupChannel, (call) async {
      throw PlatformException(code: 'backup_exclusion_failed');
    });
    final ok = await excludeAppDataFromBackup(
      isIOS: true,
      documentsDir: () async => Directory('/x'),
    );
    expect(ok, isFalse);
  });
}
