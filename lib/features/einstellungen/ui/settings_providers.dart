import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database_provider.dart';
import '../data/settings_repository.dart';
import '../domain/app_theme_mode.dart';
import '../domain/reminder_settings.dart';
import '../domain/setting_keys.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);

final themeModeProvider = StreamProvider<AppThemeMode>(
  (ref) => ref.watch(settingsRepositoryProvider).watchThemeMode(),
);

/// Einzelner Einstellungswert als Stream (z. B. für Hinweis-Flags).
final settingValueProvider = StreamProvider.family<String?, String>(
  (ref, key) => ref.watch(settingsRepositoryProvider).watchValue(key),
);

/// Erinnerungs-Einstellungen, sobald alle Einzelwerte geladen sind.
final reminderSettingsProvider = Provider<AsyncValue<ReminderSettings>>((ref) {
  final minutes = ref.watch(settingValueProvider(SettingKeys.reminderMinutes));
  final offsets = ref.watch(
    settingValueProvider(SettingKeys.reminderDefaultOffsets),
  );
  final exact = ref.watch(settingValueProvider(SettingKeys.exactReminders));
  if (!minutes.hasValue || !offsets.hasValue || !exact.hasValue) {
    return const AsyncLoading();
  }
  return AsyncData(
    ReminderSettings(
      minutes: ReminderSettings.parseMinutes(minutes.value),
      defaultOffsets: ReminderSettings.parseOffsets(offsets.value),
      exact: exact.value == 'true',
    ),
  );
});
