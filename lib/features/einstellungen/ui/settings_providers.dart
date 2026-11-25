import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database_provider.dart';
import '../data/settings_repository.dart';
import '../domain/app_theme_mode.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);

final themeModeProvider = StreamProvider<AppThemeMode>(
  (ref) => ref.watch(settingsRepositoryProvider).watchThemeMode(),
);
