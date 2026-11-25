import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import 'app.dart';
import 'core/platform/backup_exclusion.dart';
import 'core/platform/web_env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'de_DE';
  await initializeDateFormatting('de_DE');
  // iOS: Daten nicht in iCloud sichern (Android: allowBackup=false).
  await excludeAppDataFromBackup();
  // Web: Browser bitten, die Daten nicht automatisch zu löschen.
  unawaited(requestPersistentStorage());
  _registerFontLicenses();
  runApp(const ProviderScope(child: PferdekalenderApp()));
}

/// Lizenzen der gebündelten Schriften (Einstellungen → Über → Lizenzen).
void _registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final (name, file) in const [
      ('Roboto', 'assets/fonts/Roboto_LICENSE.txt'),
      ('DejaVu Sans (PkSymbols)', 'assets/fonts/PkSymbols_LICENSE.txt'),
    ]) {
      yield LicenseEntryWithLineBreaks([
        name,
      ], await rootBundle.loadString(file));
    }
  });
}
