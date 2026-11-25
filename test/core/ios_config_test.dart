import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Absicherung der iOS-Konfiguration (Gegenstück zum Manifest-Test).
void main() {
  final plist = File('ios/Runner/Info.plist').readAsStringSync();
  final delegate = File('ios/Runner/AppDelegate.swift').readAsStringSync();
  final pbx = File('ios/Runner.xcodeproj/project.pbxproj').readAsStringSync();

  String? valueOf(String key) =>
      RegExp('<key>$key</key>\\s*<string>([^<]*)</string>')
          .firstMatch(plist)
          ?.group(1);

  test('Berechtigungstexte für Fotos und Kamera auf Deutsch', () {
    expect(
      valueOf('NSPhotoLibraryUsageDescription'),
      contains('nur auf diesem Gerät'),
    );
    expect(valueOf('NSCameraUsageDescription'), contains('Kamera'));
  });

  test('App auf Deutsch, richtiger Name', () {
    expect(valueOf('CFBundleDevelopmentRegion'), 'de');
    expect(valueOf('CFBundleDisplayName'), 'Pferdekalender');
    expect(plist, contains('<key>CFBundleLocalizations</key>'));
  });

  test('keine Netzwerk-Ausnahmen, kein Hintergrund-Netz', () {
    expect(plist, isNot(contains('NSAppTransportSecurity')));
    expect(plist, isNot(contains('NSAllowsArbitraryLoads')));
    expect(plist, isNot(contains('UIBackgroundModes')));
    expect(plist, isNot(contains('UIFileSharingEnabled')));
  });

  test('Bundle-ID und Mindestversion', () {
    expect(pbx, contains('PRODUCT_BUNDLE_IDENTIFIER = de.flo.pferdekalender;'));
    expect(pbx, contains('IPHONEOS_DEPLOYMENT_TARGET = 15.0;'));
  });

  test('iCloud-Backup-Ausschluss und Benachrichtigungs-Delegate', () {
    expect(delegate, contains('isExcludedFromBackup = true'));
    expect(delegate, contains('de.flo.pferdekalender/backup'));
    expect(delegate, contains('UNUserNotificationCenter.current().delegate'));
  });

  test('Datenschutz-Erklärung vorhanden und im Projekt eingebunden', () {
    final privacy = File('ios/Runner/PrivacyInfo.xcprivacy').readAsStringSync();
    expect(privacy, contains('<key>NSPrivacyTracking</key>\n\t<false/>'));
    expect(
      privacy,
      contains('<key>NSPrivacyCollectedDataTypes</key>\n\t<array/>'),
    );
    expect(pbx, contains('PrivacyInfo.xcprivacy in Resources'));
  });
}
