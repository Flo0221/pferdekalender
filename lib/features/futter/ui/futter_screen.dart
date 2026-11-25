import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/feed.dart';
import '../domain/feed_logic.dart';
import 'feed_labels.dart';
import 'feed_providers.dart';

/// Tab „Futter“: Tagesration des ausgewählten Pferdes.
class FutterScreen extends ConsumerStatefulWidget {
  const FutterScreen({super.key});

  @override
  ConsumerState<FutterScreen> createState() => _FutterScreenState();
}

class _FutterScreenState extends ConsumerState<FutterScreen> {
  LocalDate _date = LocalDate.today();
  static final _dayFormat = DateFormat('EEEE, d. MMMM', 'de_DE');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final horse = ref.watch(selectedHorseProvider).value;
    final plans = ref.watch(selectedHorseFeedPlansProvider).value;
    final supplements =
        ref.watch(selectedHorseSupplementsProvider).value ?? const [];
    final items = ref.watch(feedItemMapProvider).value ?? const {};
    final trainingDays = ref.watch(trainingDaysProvider);

    final actions = [
      if (horse != null) ...[
        IconButton(
          tooltip: l10n.feedSupplements,
          icon: const Icon(Icons.medication_liquid_outlined),
          onPressed: () => context.push(Routes.feedSupplements),
        ),
        IconButton(
          tooltip: l10n.feedVersions,
          icon: const Icon(Icons.history),
          onPressed: () => context.push(Routes.feedVersions),
        ),
        IconButton(
          tooltip: l10n.feedItems,
          icon: const Icon(Icons.inventory_2_outlined),
          onPressed: () => context.push(Routes.feedItems),
        ),
      ],
    ];

    if (horse == null) {
      return TabScaffold(
        title: l10n.titleFutter,
        body: EmptyState(
          icon: Icons.grass_outlined,
          title: l10n.emptyFutterTitle,
          message: l10n.feedNoHorse,
        ),
      );
    }
    if (plans == null) {
      return TabScaffold(
        title: l10n.titleFutter,
        actions: actions,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (plans.isEmpty) {
      return TabScaffold(
        title: l10n.titleFutter,
        actions: actions,
        body: ListView(
          children: [
            EmptyState(
              icon: Icons.grass_outlined,
              title: l10n.emptyFutterTitle,
              message: l10n.emptyFutterMessage,
            ),
            Center(
              child: FilledButton.icon(
                icon: const Icon(Icons.add),
                label: Text(l10n.feedCreatePlan),
                onPressed: () => context.push(Routes.feedPlanNew),
              ),
            ),
          ],
        ),
      );
    }

    final training = trainingDays.contains(_date);
    final ration = rationFor(
      date: _date,
      plans: plans,
      supplements: supplements,
      trainingDay: training,
    );
    final use = averageDailyUse(
      from: LocalDate.today(),
      days: 14,
      plans: plans,
      supplements: supplements,
      isTrainingDay: trainingDays.contains,
    );
    final stockLines = [
      for (final MapEntry(key: id, value: daily) in use.entries)
        if (items[id] case final item? when item.stock != null)
          (item, daysOfStockLeft(item, daily)),
    ];
    final plan = ration.plan;

    return TabScaffold(
      title: l10n.titleFutter,
      actions: actions,
      floatingActionButton: plan == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(Routes.feedPlanEdit(plan.id)),
              icon: const Icon(Icons.edit_outlined),
              label: Text(l10n.feedEditPlan),
            ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          Row(
            children: [
              IconButton(
                tooltip: l10n.feedPreviousDay,
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(() => _date = _date.addDays(-1)),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _date = LocalDate.today()),
                  child: Column(
                    children: [
                      Text(
                        _dayFormat.format(_date.toLocalDateTime()),
                        style: theme.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        training ? l10n.feedTrainingDay : l10n.feedRestDay,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                tooltip: l10n.feedNextDay,
                icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(() => _date = _date.addDays(1)),
              ),
            ],
          ),
          for (final (item, days) in stockLines)
            if (isLowStock(item) || (days != null && days <= 7))
              Card(
                color: theme.colorScheme.errorContainer,
                margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: ListTile(
                  leading: Icon(
                    Icons.warning_amber_outlined,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  title: Text(
                    isLowStock(item)
                        ? l10n.feedLowStock(item.name)
                        : l10n.feedStockDays(item.name, days!),
                    style: TextStyle(color: theme.colorScheme.onErrorContainer),
                  ),
                  subtitle: days == null || !isLowStock(item)
                      ? null
                      : Text(
                          l10n.feedStockDays(item.name, days),
                          style: TextStyle(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                ),
              ),
          if (plan == null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.feedNoPlanOnDay(
                  Fmt.date(
                    plans
                        .map((p) => p.validFrom)
                        .reduce((a, b) => a.isBefore(b) ? a : b),
                  ),
                ),
              ),
            )
          else ...[
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(
                l10n.feedPlanValidSince(plan.name, Fmt.date(plan.validFrom)),
              ),
              subtitle: plan.notes == null ? null : Text(plan.notes!),
            ),
            for (final m in ration.meals)
              _meal(l10n, m.name, m.timeMinutes, m.lines, items),
          ],
          if (ration.daily.isNotEmpty)
            _meal(l10n, l10n.feedDaily, null, ration.daily, items),
          if (ration.totals.isNotEmpty)
            Card(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(
                      l10n.feedDayTotal,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  for (final MapEntry(key: id, value: total)
                      in ration.totals.entries)
                    ListTile(
                      dense: true,
                      title: Text(items[id]?.name ?? '?'),
                      trailing: Text(amountText(l10n, total, items[id])),
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(l10n.feedDisclaimer, style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }

  Widget _meal(
    AppLocalizations l10n,
    String name,
    int? time,
    List<RationLine> lines,
    Map<String, FeedItem> items,
  ) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(name, style: theme.textTheme.titleMedium),
            trailing: time == null ? null : Text(Fmt.time(time)),
          ),
          if (lines.isEmpty)
            ListTile(dense: true, title: Text(l10n.feedMealEmpty)),
          for (final l in lines)
            ListTile(
              dense: true,
              title: Text(items[l.itemId]?.name ?? '?'),
              subtitle: switch (l) {
                RationLine(temporary: true) => Text(l10n.feedTemporary),
                RationLine(variant: FeedVariant.trainingDay) => Text(
                  l10n.feedVariantOnlyTraining,
                ),
                RationLine(variant: FeedVariant.restDay) => Text(
                  l10n.feedVariantOnlyRest,
                ),
                _ => null,
              },
              trailing: Text(amountText(l10n, l.amount, items[l.itemId])),
            ),
        ],
      ),
    );
  }
}
