import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/blood_evaluation.dart';
import 'blood_providers.dart';

/// Gesundheit: Liste der Blutbilder des ausgewählten Pferdes.
class HealthScreen extends ConsumerWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tests = ref.watch(selectedHorseBloodTestsProvider).value ?? const [];
    final catalog = ref.watch(bloodCatalogProvider).value;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.healthTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.bloodNew),
        icon: const Icon(Icons.add),
        label: Text(l10n.healthAddTest),
      ),
      body: tests.isEmpty
          ? EmptyState(
              icon: Icons.bloodtype_outlined,
              title: l10n.healthNoTest,
              message: l10n.healthTestsEmptyHint,
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                for (final t in tests)
                  () {
                    final e = catalog == null ? null : evaluate(t, catalog);
                    return ListTile(
                      leading: Icon(
                        e != null && e.vetFirst
                            ? Icons.local_hospital_outlined
                            : Icons.bloodtype_outlined,
                        color: e != null && e.vetFirst
                            ? Theme.of(context).colorScheme.error
                            : null,
                      ),
                      title: Text([Fmt.date(t.date), ?t.lab].join(' · ')),
                      subtitle: Text(
                        e == null || e.summary.isEmpty
                            ? l10n.bloodNoDeviations
                            : e.summary.join(' · '),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(Routes.bloodDetail(t.id)),
                    );
                  }(),
              ],
            ),
    );
  }
}
