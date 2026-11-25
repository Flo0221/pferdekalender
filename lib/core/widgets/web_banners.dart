import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../platform/web_env.dart';
import '../platform/web_providers.dart';

/// Hinweise nur für die Web-App: neue Version und „bitte installieren“.
/// Auf Android/iOS (native) leer.
class WebBanners extends ConsumerWidget {
  const WebBanners({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final env = ref.watch(webEnvProvider);
    if (!env.isWeb) return const SizedBox.shrink();
    final update = ref.watch(updateAvailableProvider).value ?? false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (update) const _UpdateBanner(),
        if (!env.isStandalone) const _InstallBanner(),
      ],
    );
  }
}

class _UpdateBanner extends ConsumerWidget {
  const _UpdateBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.primaryContainer,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
          child: Row(
            children: [
              ExcludeSemantics(
                child: Icon(
                  Icons.system_update_alt,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.webUpdateAvailable,
                  style: TextStyle(color: scheme.onPrimaryContainer),
                ),
              ),
              // Nie automatisch neu laden – nur auf Knopfdruck, damit keine
              // Eingabe verloren geht.
              TextButton(
                onPressed: () => ref.read(webEnvProvider).applyUpdate(),
                child: Text(l10n.webUpdateReload),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstallBanner extends ConsumerWidget {
  const _InstallBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.errorContainer,
      child: InkWell(
        onTap: () => showInstallGuide(context, ref),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              ExcludeSemantics(
                child: Icon(
                  Icons.install_mobile,
                  color: scheme.onErrorContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.webInstallBanner,
                  style: TextStyle(color: scheme.onErrorContainer),
                ),
              ),
              TextButton(
                onPressed: () => showInstallGuide(context, ref),
                child: Text(l10n.webInstallHow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kurze bebilderte Anleitung „Zum Home-Bildschirm“.
Future<void> showInstallGuide(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context);
  final apple = ref.read(webEnvProvider).isAppleMobile;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.webInstallTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Step(1, Icons.ios_share, l10n.webInstallStep1),
            _Step(2, Icons.add_box_outlined, l10n.webInstallStep2),
            _Step(3, Icons.home_outlined, l10n.webInstallStep3),
            if (!apple) ...[
              const SizedBox(height: 8),
              Text(l10n.webInstallOtherBrowser),
            ],
            const SizedBox(height: 12),
            Text(
              l10n.webInstallWhy,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
      ],
    ),
  );
}

class _Step extends StatelessWidget {
  const _Step(this.number, this.icon, this.text);
  final int number;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: CircleAvatar(
              radius: 20,
              backgroundColor: scheme.primaryContainer,
              child: Icon(icon, color: scheme.onPrimaryContainer),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text('$number. $text')),
        ],
      ),
    );
  }
}
