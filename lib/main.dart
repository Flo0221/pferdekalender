import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import 'app.dart';
import 'core/platform/backup_exclusion.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'de_DE';
  await initializeDateFormatting('de_DE');
  // iOS: Daten nicht in iCloud sichern (Android: allowBackup=false).
  await excludeAppDataFromBackup();
  runApp(const ProviderScope(child: PferdekalenderApp()));
}
