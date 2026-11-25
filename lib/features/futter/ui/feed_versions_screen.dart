import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/feed.dart';
import '../domain/feed_logic.dart';
import 'feed_providers.dart';

/// Historie der Planversionen.
class FeedVersionsScreen extends ConsumerWidget {
  const FeedVersionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final plans = ref.watch(selectedHorseFeedPlansProvider).value ?? const [];
    final today = LocalDate.today();
    final current = planOn(plans, today);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.feedVersions)),
      floatingActionButton: plans.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () =>
                  newFeedVersion(context, ref, current ?? plans.first),
              icon: const Icon(Icons.add),
              label: Text(l10n.feedVersionNew),
            ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          for (final p in plans)
            ListTile(
              leading: Icon(
                p.id == current?.id ? Icons.check_circle : Icons.history,
              ),
              title: Text(p.name),
              subtitle: Text(
                [
                  '${l10n.feedPlanValidFrom} ${Fmt.date(p.validFrom)}',
                  if (p.id == current?.id) l10n.feedVersionCurrent,
                  if (p.validFrom.isAfter(today))
                    l10n.feedVersionFuture(Fmt.date(p.validFrom)),
                ].join(' · '),
              ),
              onTap: () => context.push(Routes.feedPlanEdit(p.id)),
              trailing: IconButton(
                tooltip: l10n.actionDelete,
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  final ok = await showConfirmDialog(
                    context,
                    title: l10n.feedVersionDeleteTitle,
                    message: l10n.feedVersionDeleteText,
                    confirmLabel: l10n.actionDelete,
                    destructive: true,
                  );
                  if (ok) {
                    await ref.read(feedRepositoryProvider).deletePlan(p.id);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

/// Neue Version: Datum wählen, aktuelle kopieren, Editor öffnen.
Future<void> newFeedVersion(
  BuildContext context,
  WidgetRef ref,
  FeedPlan base,
) async {
  final l10n = AppLocalizations.of(context);
  final picked = await showDatePicker(
    context: context,
    helpText: l10n.feedVersionNewTitle,
    initialDate: LocalDate.today().toLocalDateTime(),
    firstDate: base.validFrom.addDays(1).isAfter(LocalDate.today())
        ? base.validFrom.addDays(1).toLocalDateTime()
        : LocalDate.today().addYears(-1).toLocalDateTime(),
    lastDate: LocalDate.today().addYears(2).toLocalDateTime(),
  );
  if (picked == null || !context.mounted) return;
  final id = await ref
      .read(feedRepositoryProvider)
      .createVersion(base, LocalDate.fromDateTime(picked));
  if (context.mounted) await context.push(Routes.feedPlanEdit(id));
}
