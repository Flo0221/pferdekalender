import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/backup_format.dart';
import 'backup_files.dart';
import 'backup_providers.dart';

String backupErrorText(AppLocalizations l10n, BackupException e) =>
    switch (e.error) {
      BackupError.notABackup => l10n.backupErrorNotABackup,
      BackupError.tooNew => l10n.backupErrorTooNew,
      BackupError.corrupt => l10n.backupErrorCorrupt,
    };

/// Export: Sicherung erstellen und teilen/speichern.
Future<void> exportFlow(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  messenger.showSnackBar(SnackBar(content: Text(l10n.backupExporting)));
  final (bytes, manifest) = await ref.read(backupServiceProvider).export();
  await ref
      .read(backupFilesProvider)
      .share(
        bytes,
        backupFileName(DateTime.now()),
        subject: l10n.backupShareSubject,
      );
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(l10n.backupExportDone(manifest.photos))),
    );
}

/// Import: Datei wählen, prüfen, bestätigen, aktuellen Stand sichern,
/// ersetzen.
Future<void> importFlow(
  BuildContext context,
  WidgetRef ref, {
  Uint8List? preselected,
}) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final files = ref.read(backupFilesProvider);
  final service = ref.read(backupServiceProvider);
  final bytes = preselected ?? await files.pickZip();
  if (bytes == null || !context.mounted) return;

  final BackupManifest manifest;
  try {
    manifest = service.readManifest(bytes);
    checkCompatible(manifest, currentSchema: service.schemaVersion);
  } on BackupException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(backupErrorText(l10n, e))));
    return;
  }

  final ok = await showDialog<bool>(
    context: context,
    builder: (context) {
      final scheme = Theme.of(context).colorScheme;
      return AlertDialog(
        title: Text(l10n.backupImportConfirmTitle),
        content: Text(
          l10n.backupImportConfirmText(
            Fmt.date(LocalDate.fromDateTime(manifest.createdAt.toLocal())),
            manifest.platform,
            manifest.appVersion,
            manifest.tables['horses'] ?? 0,
            manifest.photos,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: scheme.error,
              foregroundColor: scheme.onError,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.backupImportConfirm),
          ),
        ],
      );
    },
  );
  if (ok != true || !context.mounted) return;

  // Pflicht: vorher den aktuellen Stand sichern.
  if (!files.keepsAutoBackupLocally) {
    final go = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.backupAutoShareTitle),
        content: Text(l10n.backupAutoShareText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.backupAutoShareContinue),
          ),
        ],
      ),
    );
    if (go != true) return;
  }
  final (current, _) = await service.export(markExported: false);
  await files.keepAutoBackup(
    current,
    backupFileName(DateTime.now(), prefix: 'pferdekalender-vor-import'),
  );

  try {
    final result = await service.import(bytes);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          '${l10n.backupAutoSaved} ${l10n.backupImportDone(result.rows, result.photos)}',
        ),
      ),
    );
  } on BackupException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(backupErrorText(l10n, e))));
  }
}
