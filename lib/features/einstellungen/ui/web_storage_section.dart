import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/platform/web_env.dart';
import '../../../core/platform/web_providers.dart';
import '../../../core/widgets/web_banners.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Einstellungen → Speicher im Browser (nur Web-App).
class WebStorageSection extends ConsumerWidget {
  const WebStorageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final env = ref.watch(webEnvProvider);
    final persisted = ref.watch(storagePersistedProvider).value;
    final estimate = ref.watch(storageEstimateProvider).value;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: Icon(
            persisted == true ? Icons.lock_outline : Icons.warning_amber,
          ),
          title: Text(
            l10n.webStoragePersisted(
              persisted == true ? l10n.webStorageYes : l10n.webStorageNo,
            ),
          ),
          subtitle: persisted == true ? null : Text(l10n.webStoragePersistHint),
        ),
        if (persisted == false)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: OutlinedButton(
                onPressed: () async {
                  await env.requestPersist();
                  ref.invalidate(storagePersistedProvider);
                },
                child: Text(l10n.webStorageRequest),
              ),
            ),
          ),
        ListTile(
          leading: const Icon(Icons.storage_outlined),
          title: Text(
            estimate == null
                ? l10n.webStorageUnknown
                : l10n.webStorageUsage(
                    formatBytes(estimate.usageBytes),
                    formatBytes(estimate.quotaBytes),
                  ),
          ),
        ),
        if (!env.isStandalone)
          ListTile(
            leading: const Icon(Icons.install_mobile),
            title: Text(l10n.webInstallTitle),
            subtitle: Text(l10n.webInstallBanner),
            onTap: () => showInstallGuide(context, ref),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Text(
            l10n.webDataLossWarning,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
