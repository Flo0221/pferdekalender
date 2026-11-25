import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_info.dart';
import '../../../core/db/database_provider.dart';
import '../../einstellungen/domain/setting_keys.dart';
import '../../einstellungen/ui/settings_providers.dart';
import '../../pferd/ui/horse_providers.dart';
import '../data/backup_service.dart';
import '../domain/backup_format.dart';

String currentPlatformName() {
  if (kIsWeb) return 'web';
  return defaultTargetPlatform.name.toLowerCase();
}

final backupServiceProvider = Provider<BackupService>(
  (ref) => BackupService(
    ref.watch(databaseProvider),
    ref.watch(photoStorageProvider),
    appVersion: appVersion,
    platform: currentPlatformName(),
  ),
);

/// Zeitpunkt der letzten Sicherung (UTC) oder `null`.
final lastExportProvider = Provider<DateTime?>((ref) {
  final v = ref.watch(settingValueProvider(SettingKeys.lastExportAt)).value;
  return v == null ? null : DateTime.tryParse(v);
});

/// Export-Erinnerung anzeigen?
final exportReminderProvider = Provider<bool>((ref) {
  final horses = ref.watch(activeHorsesProvider).value ?? const [];
  final snooze = ref
      .watch(settingValueProvider(SettingKeys.exportSnoozedUntil))
      .value;
  final lastLoaded = ref
      .watch(settingValueProvider(SettingKeys.lastExportAt))
      .hasValue;
  if (!lastLoaded) return false;
  return shouldRemindExport(
    lastExport: ref.watch(lastExportProvider),
    snoozedUntil: snooze == null ? null : DateTime.tryParse(snooze),
    hasData: horses.isNotEmpty,
    now: DateTime.now().toUtc(),
  );
});

/// „Später“: Erinnerung für einen Tag ausblenden.
class ExportReminderActions {
  ExportReminderActions(this._ref);
  final Ref _ref;

  Future<void> snoozeExportReminder() => _ref
      .read(settingsRepositoryProvider)
      .setValue(
        SettingKeys.exportSnoozedUntil,
        DateTime.now().toUtc().add(const Duration(days: 1)).toIso8601String(),
      );
}

final settingsRepositoryForBackupProvider = Provider<ExportReminderActions>(
  ExportReminderActions.new,
);
