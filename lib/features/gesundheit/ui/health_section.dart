import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/domain/horse.dart';
import '../../pferd/ui/widgets/section_card.dart';
import 'blood_providers.dart';

/// Karte „Gesundheit“ im Pferde-Profil (unter „Fotos“) mit Kurzinfo.
class HealthSection extends ConsumerWidget {
  const HealthSection({super.key, required this.horse});

  final Horse horse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tests = ref.watch(bloodTestsProvider(horse.id)).value ?? const [];
    final catalog = ref.watch(bloodCatalogProvider).value;
    final text = healthSummaryText(l10n, tests.firstOrNull, catalog);
    return SectionCard(
      title: l10n.healthTitle,
      action: IconButton(
        tooltip: l10n.healthAddTest,
        icon: const Icon(Icons.add),
        onPressed: () => context.push(Routes.bloodNew),
      ),
      child: ListTile(
        leading: const Icon(Icons.bloodtype_outlined),
        title: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(Routes.health),
      ),
    );
  }
}
