import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/notifications/notification_gateway.dart';
import '../../../core/notifications/notification_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/reminder_settings.dart';
import '../domain/setting_keys.dart';
import 'settings_providers.dart';

/// Status der Systemberechtigungen (wird beim Öffnen neu gelesen).
final _permissionProvider =
    FutureProvider.autoDispose<NotificationPermissionState?>((ref) async {
      try {
        return await ref.watch(notificationGatewayProvider).permissionState();
      } on Object {
        return null;
      }
    });

/// Einstellungen → Erinnerungen.
class ReminderSettingsSection extends ConsumerWidget {
  const ReminderSettingsSection({super.key});

  static const _offsetChoices = [0, 1, 3, 7, 14];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings =
        ref.watch(reminderSettingsProvider).value ?? const ReminderSettings();
    final permission = ref.watch(_permissionProvider).value;
    final repo = ref.read(settingsRepositoryProvider);
    final gateway = ref.read(notificationGatewayProvider);

    final supported = permission?.supported ?? true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!supported)
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.settingsReminderWebOnly),
          ),
        if (supported && permission != null && !permission.notificationsAllowed)
          ListTile(
            leading: Icon(
              Icons.notifications_off_outlined,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(l10n.settingsReminderPermissionOff),
            onTap: () async {
              await gateway.requestNotifications();
              ref.invalidate(_permissionProvider);
            },
          ),
        ListTile(
          leading: const Icon(Icons.schedule),
          title: Text(l10n.settingsReminderTime),
          subtitle: Text(Fmt.time(settings.minutes)),
          onTap: () async {
            final t = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: settings.minutes ~/ 60,
                minute: settings.minutes % 60,
              ),
            );
            if (t == null) return;
            await repo.setValue(
              SettingKeys.reminderMinutes,
              '${t.hour * 60 + t.minute}',
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Text(l10n.settingsReminderDefaults),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final o in _offsetChoices)
                FilterChip(
                  label: Text(
                    o == 0
                        ? l10n.careReminderOnDay
                        : l10n.careReminderDaysBefore(o),
                  ),
                  selected: settings.defaultOffsets.contains(o),
                  onSelected: (on) {
                    final next = {...settings.defaultOffsets};
                    on ? next.add(o) : next.remove(o);
                    repo.setValue(
                      SettingKeys.reminderDefaultOffsets,
                      ReminderSettings.encodeOffsets(next),
                    );
                  },
                ),
            ],
          ),
        ),
        if (permission?.exactAlarmsSupported ?? true)
          SwitchListTile(
            secondary: const Icon(Icons.alarm_outlined),
            title: Text(l10n.settingsReminderExact),
            subtitle: Text(
              settings.exact &&
                      permission != null &&
                      !permission.exactAlarmsAllowed
                  ? l10n.settingsReminderExactDenied
                  : l10n.settingsReminderExactHint,
            ),
            value: settings.exact,
            onChanged: (on) async {
              if (on) {
                await gateway.requestExactAlarms();
                ref.invalidate(_permissionProvider);
              }
              await repo.setValue(SettingKeys.exactReminders, '$on');
            },
          ),
        if (supported)
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: Text(l10n.settingsReminderTest),
            onTap: () async {
              if (permission != null && !permission.notificationsAllowed) {
                await gateway.requestNotifications();
                ref.invalidate(_permissionProvider);
              }
              await gateway.showTest(
                l10n.notificationTestTitle,
                l10n.notificationTestBody,
              );
            },
          ),
      ],
    );
  }
}
