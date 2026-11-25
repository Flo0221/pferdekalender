import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/app_info.dart';
import '../../../core/platform/web_env.dart';
import '../../../core/router/routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../backup/ui/backup_section.dart';
import '../domain/app_theme_mode.dart';
import 'reminder_settings_section.dart';
import 'settings_providers.dart';
import 'web_storage_section.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final mode = ref.watch(themeModeProvider).value ?? AppThemeMode.system;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.titleSettings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _SectionHeader(l10n.settingsAppearance),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<AppThemeMode>(
              segments: [
                ButtonSegment(
                  value: AppThemeMode.system,
                  icon: const Icon(Icons.brightness_auto_outlined),
                  label: Text(l10n.settingsThemeSystem),
                ),
                ButtonSegment(
                  value: AppThemeMode.light,
                  icon: const Icon(Icons.light_mode_outlined),
                  label: Text(l10n.settingsThemeLight),
                ),
                ButtonSegment(
                  value: AppThemeMode.dark,
                  icon: const Icon(Icons.dark_mode_outlined),
                  label: Text(l10n.settingsThemeDark),
                ),
              ],
              selected: {mode},
              onSelectionChanged: (selection) => ref
                  .read(settingsRepositoryProvider)
                  .setThemeMode(selection.single),
            ),
          ),
          const Divider(height: 32),
          _SectionHeader(l10n.backupTitle),
          const BackupSection(),
          if (ref.watch(webEnvProvider).isWeb) ...[
            const Divider(height: 32),
            _SectionHeader(l10n.webStorageTitle),
            const WebStorageSection(),
          ],
          const Divider(height: 32),
          _SectionHeader(l10n.settingsReminders),
          const ReminderSettingsSection(),
          const Divider(height: 32),
          _SectionHeader(l10n.titlePflege),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: Text(l10n.settingsCareTypes),
            subtitle: Text(l10n.settingsCareTypesHint),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.careTypes),
          ),
          ListTile(
            leading: const Icon(Icons.repeat),
            title: Text(l10n.settingsIntervals),
            subtitle: Text(l10n.settingsIntervalsHint),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.careIntervals),
          ),
          const Divider(height: 32),
          _SectionHeader(l10n.settingsNoticeTitle),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.disclaimer),
          ),
          _SectionHeader(l10n.settingsPrivacyTitle),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: Text(l10n.settingsPrivacyText),
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.pets_outlined),
            title: Text(l10n.appTitle),
            subtitle: Text('Version $appVersion'),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: l10n.appTitle,
              applicationVersion: appVersion,
              children: [
                Text(l10n.disclaimer, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Semantics(
        header: true,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
