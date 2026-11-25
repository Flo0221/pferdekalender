import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/platform/web_env.dart';
import '../../../../core/time/local_date.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/care_event.dart';
import '../care_calendar_export.dart';
import 'care_event_tile.dart';

/// Einteilung offener Termine für die Heute-Karte. Reine Logik.
({List<CareEvent> overdue, List<CareEvent> today, List<CareEvent> next7})
groupForToday(Iterable<CareEvent> open, LocalDate today) {
  final overdue = <CareEvent>[];
  final now = <CareEvent>[];
  final next = <CareEvent>[];
  for (final e in open) {
    if (e.done) continue;
    final d = today.daysUntil(e.date);
    if (d < 0) {
      overdue.add(e);
    } else if (d == 0) {
      now.add(e);
    } else if (d <= 7) {
      next.add(e);
    }
  }
  int byDate(CareEvent a, CareEvent b) => a.date.compareTo(b.date);
  return (
    overdue: overdue..sort(byDate),
    today: now..sort(byDate),
    next7: next..sort(byDate),
  );
}

/// Web-App: „Heute / überfällig / nächste 7 Tage“ oben im Pflege-Tab
/// (Ersatz für Benachrichtigungen) und Kalender-Export. Setzt außerdem das
/// App-Abzeichen (überfällig + heute, alle Pferde), wo der Browser es kann.
class CareTodayCard extends ConsumerWidget {
  const CareTodayCard({
    super.key,
    required this.events,
    required this.onShowAll,
  });

  /// Einträge des ausgewählten Pferdes.
  final List<CareEvent> events;
  final VoidCallback onShowAll;

  static const _maxRows = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final today = LocalDate.today();
    final g = groupForToday(events, today);

    final all = ref.watch(openCareEventsProvider).value;
    if (all != null) {
      final due = groupForToday(all.map((c) => c.event), today);
      ref.read(webEnvProvider).setBadge(due.overdue.length + due.today.length);
    }

    final rows = [...g.overdue, ...g.today, ...g.next7];
    Widget count(String label, int n, Color? color) => Expanded(
      child: Semantics(
        label: '$label: $n',
        excludeSemantics: true,
        child: Column(
          children: [
            Text(
              '$n',
              style: theme.textTheme.headlineSmall?.copyWith(color: color),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Semantics(
                header: true,
                child: Text(
                  l10n.todayCardTitle,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                count(
                  l10n.todayOverdue,
                  g.overdue.length,
                  g.overdue.isEmpty ? null : theme.colorScheme.error,
                ),
                count(l10n.todayToday, g.today.length, null),
                count(l10n.todayNext7, g.next7.length, null),
              ],
            ),
            if (rows.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(l10n.todayNothing),
              )
            else ...[
              const SizedBox(height: 4),
              for (final e in rows.take(_maxRows))
                CareEventTile(event: e, showDate: true),
              if (rows.length > _maxRows)
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: onShowAll,
                    child: Text(l10n.todayShowAll),
                  ),
                ),
            ],
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Wrap(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => exportUpcomingToCalendar(context, ref),
                    icon: const Icon(Icons.event_outlined),
                    label: Text(l10n.icsExportUpcoming),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Text(
                l10n.icsExportUpcomingHint,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
