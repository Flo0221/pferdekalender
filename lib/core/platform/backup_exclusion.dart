import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Kanal zur nativen iOS-Seite (ios/Runner/AppDelegate.swift).
const backupChannel = MethodChannel('de.flo.pferdekalender/backup');

/// Schließt auf iOS das App-Dokumentenverzeichnis (Datenbank + Fotos) vom
/// iCloud-/iTunes-Backup aus – Gegenstück zu `allowBackup="false"` auf
/// Android. Auf anderen Plattformen passiert nichts.
///
/// Gibt `true` zurück, wenn der Ausschluss gesetzt wurde.
Future<bool> excludeAppDataFromBackup({
  bool? isIOS,
  Future<Directory> Function()? documentsDir,
  MethodChannel channel = backupChannel,
}) async {
  if (!(isIOS ?? (!kIsWeb && Platform.isIOS))) return false;
  try {
    final dir = await (documentsDir ?? getApplicationDocumentsDirectory)();
    final ok = await channel.invokeMethod<bool>('excludeFromBackup', {
      'path': dir.path,
    });
    return ok ?? false;
  } on Object catch (e) {
    // Darf den Start nie verhindern; Fehler nur protokollieren.
    debugPrint('Backup-Ausschluss fehlgeschlagen: $e');
    return false;
  }
}
