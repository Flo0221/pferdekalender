import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'backup_actions.dart';
import 'backup_files.dart';
import 'backup_providers.dart';

final _autoBackupProvider = FutureProvider.autoDispose<DateTime?>((ref) async {
  final files = ref.watch(backupFilesProvider);
  if (!files.keepsAutoBackupLocally) return null;
  try {
    return (await files.latestAutoBackup())?.$1;
  } on Object {
    return null;
  }
});

/// Einstellungen → Datensicherung.
class BackupSection extends ConsumerWidget {
  const BackupSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final last = ref.watch(lastExportProvider);
    final auto = ref.watch(_autoBackupProvider).value;
    String date(DateTime d) => Fmt.date(LocalDate.fromDateTime(d.toLocal()));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: const Icon(Icons.upload_file_outlined),
          title: Text(l10n.backupExport),
          subtitle: Text(
            '${l10n.backupExportHint}\n'
            '${last == null ? l10n.backupNever : l10n.backupLastExport(date(last))}',
          ),
          isThreeLine: true,
          onTap: () => exportFlow(context, ref),
        ),
        ListTile(
          leading: const Icon(Icons.download_outlined),
          title: Text(l10n.backupImport),
          subtitle: Text(l10n.backupImportHint),
          onTap: () async {
            await importFlow(context, ref);
            ref.invalidate(_autoBackupProvider);
          },
        ),
        if (auto != null)
          ListTile(
            leading: const Icon(Icons.restore),
            title: Text(l10n.backupRestoreAuto),
            subtitle: Text(l10n.backupRestoreAutoHint(date(auto))),
            onTap: () async {
              final latest = await ref
                  .read(backupFilesProvider)
                  .latestAutoBackup();
              if (latest == null || !context.mounted) return;
              await importFlow(context, ref, preselected: latest.$2);
              ref.invalidate(_autoBackupProvider);
            },
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Text(l10n.backupDataWarning, style: theme.textTheme.bodySmall),
        ),
      ],
    );
  }
}

/// Dezentes Banner „Letzte Sicherung vor X Tagen – jetzt sichern?“.
class ExportReminderBanner extends ConsumerWidget {
  const ExportReminderBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(exportReminderProvider)) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final last = ref.watch(lastExportProvider);
    final days = last == null
        ? null
        : DateTime.now().toUtc().difference(last).inDays;
    return Material(
      color: scheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
        child: Row(
          children: [
            ExcludeSemantics(
              child: Icon(
                Icons.save_outlined,
                color: scheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                days == null
                    ? l10n.backupReminderNever
                    : l10n.backupReminder(days),
                style: TextStyle(color: scheme.onSecondaryContainer),
              ),
            ),
            TextButton(
              onPressed: () => ref
                  .read(settingsRepositoryForBackupProvider)
                  .snoozeExportReminder(),
              child: Text(l10n.backupReminderLater),
            ),
            TextButton(
              onPressed: () => exportFlow(context, ref),
              child: Text(l10n.backupReminderAction),
            ),
          ],
        ),
      ),
    );
  }
}
