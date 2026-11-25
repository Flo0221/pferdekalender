import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Schutz der Grundprinzipien: keine INTERNET-Permission im main-Manifest,
/// Android Auto-Backup und Geräte-Übertragung abgeschaltet.
void main() {
  final manifest = File('android/app/src/main/AndroidManifest.xml')
      .readAsStringSync();

  test('main-Manifest fordert keine INTERNET-Permission an', () {
    final permissions = RegExp(
      r'<uses-permission[^>]*android:name="android\.permission\.INTERNET"[^>]*/>',
    ).allMatches(manifest).map((m) => m.group(0)!);
    // Erlaubt ist nur der Entfernen-Marker gegen Plugin-Manifeste.
    for (final p in permissions) {
      expect(p, contains('tools:node="remove"'));
    }
    expect(permissions, isNotEmpty, reason: 'Entfernen-Marker fehlt');
    expect(manifest, isNot(contains('ACCESS_NETWORK_STATE')));
  });

  test('Auto-Backup ist abgeschaltet', () {
    expect(manifest, contains('android:allowBackup="false"'));
    expect(manifest, contains('android:fullBackupContent="false"'));
    expect(
      manifest,
      contains('android:dataExtractionRules="@xml/data_extraction_rules"'),
    );
  });

  test('Data-Extraction-Rules schließen Cloud-Backup und Transfer aus', () {
    final rules = File('android/app/src/main/res/xml/data_extraction_rules.xml')
        .readAsStringSync();
    expect(rules, contains('<cloud-backup>'));
    expect(rules, contains('<device-transfer>'));
    for (final domain in ['root', 'file', 'database', 'sharedpref']) {
      expect(
        RegExp('<exclude domain="$domain" path="\\." />')
            .allMatches(rules)
            .length,
        2,
        reason: 'Domain $domain muss in beiden Abschnitten ausgeschlossen sein',
      );
    }
  });

  test('Erinnerungen: Receiver für Neustart und Berechtigungen vorhanden', () {
    expect(manifest, contains('ScheduledNotificationReceiver'));
    expect(manifest, contains('ScheduledNotificationBootReceiver'));
    expect(manifest, contains('android.intent.action.BOOT_COMPLETED'));
    expect(manifest, contains('android.permission.POST_NOTIFICATIONS'));
    expect(manifest, contains('android.permission.RECEIVE_BOOT_COMPLETED'));
    // USE_EXACT_ALARM wäre ohne Nachfrage – bewusst nicht verwendet.
    expect(manifest, isNot(contains('USE_EXACT_ALARM')));
  });
}
