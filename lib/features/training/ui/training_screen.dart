import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/calendar_grid.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/month_calendar.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../dienstplan/ui/shift_providers.dart';
import '../../dienstplan/ui/widgets/shift_badge.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/training.dart';
import 'training_labels.dart';
import 'training_providers.dart';
import 'widgets/session_tile.dart';

enum _View { calendar, week }

/// Tab „Training“: Kalender, Wochenansicht, Plan.
class TrainingScreen extends ConsumerStatefulWidget {
  const TrainingScreen({super.key});

  @override
  ConsumerState<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends ConsumerState<TrainingScreen> {
  _View _view = _View.calendar;
  LocalDate _selected = LocalDate.today();
  LocalDate _focused = LocalDate.today();
  CalendarSpan _span = CalendarSpan.month;
  bool _redistributing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final horse = ref.watch(selectedHorseProvider).value;
    final sessions = ref.watch(selectedHorseSessionsProvider).value ?? const [];
    final plan = ref.watch(activePlanProvider).value;
    final shiftChanged = ref.watch(shiftChangedSincePlanProvider);

    return TabScaffold(
      title: l10n.titleTraining,
      actions: [
        if (horse != null)
          IconButton(
            tooltip: l10n.trainingGenerator,
            icon: const Icon(Icons.auto_awesome_outlined),
            onPressed: () => context.push(Routes.trainingGenerator),
          ),
      ],
      floatingActionButton: horse == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () =>
                  context.push(Routes.trainingNew(date: _selected.toIso())),
              icon: const Icon(Icons.add),
              label: Text(l10n.trainingAddSession),
            ),
      body: horse == null
          ? EmptyState(
              icon: Icons.fitness_center_outlined,
              title: l10n.emptyTrainingTitle,
              message: l10n.trainingNoHorse,
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                if (plan != null) _planCard(l10n, plan, shiftChanged),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<_View>(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(
                          value: _View.calendar,
                          label: Text(l10n.trainingViewCalendar),
                        ),
                        ButtonSegment(
                          value: _View.week,
                          label: Text(l10n.trainingViewWeek),
                        ),
                      ],
                      selected: {_view},
                      onSelectionChanged: (s) =>
                          setState(() => _view = s.single),
                    ),
                  ),
                ),
                if (sessions.isEmpty && plan == null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Text(
                      l10n.emptyTrainingMessage,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ...switch (_view) {
                  _View.calendar => _calendarView(l10n, sessions),
                  _View.week => _weekView(l10n, sessions),
                },
              ],
            ),
    );
  }

  Widget _planCard(
    AppLocalizations l10n,
    TrainingPlan plan,
    bool shiftChanged,
  ) {
    final theme = Theme.of(context);
    final p = plan.params;
    final today = LocalDate.today();
    final week = (p.startDate.daysUntil(today) ~/ 7 + 1).clamp(1, p.weeks);
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: Text(l10n.trainingPlanActive(goalName(l10n, p.goal))),
            subtitle: Text(
              l10n.trainingPlanWeekOf(week, p.weeks, Fmt.date(p.endDate)),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (_) => _endPlan(plan),
              itemBuilder: (_) => [
                PopupMenuItem(value: 'end', child: Text(l10n.trainingPlanEnd)),
              ],
            ),
          ),
          if (shiftChanged)
            Container(
              color: theme.colorScheme.tertiaryContainer,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.trainingShiftChanged,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.trainingShiftChangedHint,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.tonal(
                      onPressed: _redistributing
                          ? null
                          : () => _redistribute(plan),
                      child: Text(l10n.trainingRedistribute),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _endPlan(TrainingPlan plan) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showConfirmDialog(
      context,
      title: l10n.trainingPlanEndTitle,
      message: l10n.trainingPlanEndText,
      confirmLabel: l10n.trainingPlanEnd,
      destructive: true,
    );
    if (!ok) return;
    await ref
        .read(trainingRepositoryProvider)
        .endPlan(plan.id, LocalDate.today());
  }

  Future<void> _redistribute(TrainingPlan plan) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _redistributing = true);
    try {
      final today = LocalDate.today();
      final generator = await ref.read(trainingGeneratorProvider.future);
      final availability = await ref.read(availabilityLoaderProvider)(
        plan.params.startDate,
        plan.params.endDate,
      );
      await ref
          .read(trainingRepositoryProvider)
          .redistribute(
            plan: plan,
            generator: generator,
            availability: availability,
            today: today,
          );
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.trainingRedistributed)),
      );
    } finally {
      if (mounted) setState(() => _redistributing = false);
    }
  }

  List<Widget> _calendarView(
    AppLocalizations l10n,
    List<TrainingSession> sessions,
  ) {
    final byDay = <LocalDate, List<TrainingSession>>{};
    for (final s in sessions) {
      (byDay[s.date] ??= []).add(s);
    }
    final day = byDay[_selected] ?? const <TrainingSession>[];
    return [
      MonthCalendar(
        focused: _focused,
        selected: _selected,
        span: _span,
        dotsFor: (d) => [
          for (final s in byDay[d] ?? const <TrainingSession>[])
            levelColor(
              s.level,
            ).withValues(alpha: s.status == SessionStatus.cancelled ? 0.35 : 1),
        ],
        onSelect: (d) => setState(() {
          _selected = d;
          if (_span == CalendarSpan.month && d.month != _focused.month) {
            _focused = d;
          }
        }),
        onFocusChange: (d) => setState(() => _focused = d),
        onSpanChange: (s) => setState(() {
          _span = s;
          _focused = _selected;
        }),
      ),
      const Divider(height: 1),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Semantics(
          header: true,
          child: Text(
            Fmt.date(_selected),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
      if (day.isEmpty)
        ListTile(title: Text(l10n.trainingDayEmpty))
      else
        for (final s in day) SessionTile(session: s),
    ];
  }

  List<Widget> _weekView(
    AppLocalizations l10n,
    List<TrainingSession> sessions,
  ) {
    final theme = Theme.of(context);
    final weekStart = _selected.startOfWeek;
    final weekEnd = weekStart.addDays(6);
    final catalog = ref.watch(trainingCatalogProvider).value;
    final shiftDays =
        ref.watch(shiftDaysProvider((weekStart, weekEnd))).value ?? const {};
    final templates = ref.watch(shiftTemplateMapProvider).value ?? const {};
    double load(TrainingSession s) => s.status == SessionStatus.cancelled
        ? 0
        : (catalog?.load(s.level, s.durationMinutes) ??
              s.level * s.durationMinutes / 10);

    final days = [for (var i = 0; i < 7; i++) weekStart.addDays(i)];
    final perDay = {
      for (final d in days) d: sessions.where((s) => s.date == d).toList(),
    };
    final dayLoad = {
      for (final d in days)
        d: perDay[d]!.fold<double>(0, (a, s) => a + load(s)),
    };
    final maxLoad = dayLoad.values.fold<double>(0, (a, b) => b > a ? b : a);
    final total = dayLoad.values.fold<double>(0, (a, b) => a + b);
    final dayFormat = DateFormat('EE d.M.', 'de_DE');

    return [
      Row(
        children: [
          IconButton(
            tooltip: l10n.calendarPrevious,
            icon: const Icon(Icons.chevron_left),
            onPressed: () => setState(() => _selected = _selected.addWeeks(-1)),
          ),
          Expanded(
            child: Text(
              '${Fmt.date(weekStart)} – ${Fmt.date(weekEnd)}',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
            ),
          ),
          IconButton(
            tooltip: l10n.calendarNext,
            icon: const Icon(Icons.chevron_right),
            onPressed: () => setState(() => _selected = _selected.addWeeks(1)),
          ),
        ],
      ),
      for (final d in days)
        InkWell(
          onTap: () => setState(() => _selected = d),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 64,
                  child: Text(
                    dayFormat.format(d.toLocalDateTime()),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: d == LocalDate.today()
                          ? FontWeight.w700
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: 36,
                  child: switch (shiftDays[d]?.templateId) {
                    final id? when templates[id] != null => ShiftBadge(
                      template: templates[id]!,
                      size: 26,
                    ),
                    _ => const SizedBox.shrink(),
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (perDay[d]!.isEmpty)
                        Text(
                          l10n.trainingLevel_0,
                          style: theme.textTheme.bodySmall,
                        ),
                      for (final s in perDay[d]!)
                        InkWell(
                          onTap: () => context.push(Routes.trainingEdit(s.id)),
                          child: Text(
                            '${s.title} · ${l10n.trainingSessionMeta(s.level, s.durationMinutes)}',
                            style: TextStyle(
                              decoration: s.status == SessionStatus.cancelled
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                      const SizedBox(height: 4),
                      _LoadBar(
                        value: maxLoad == 0 ? 0 : dayLoad[d]! / maxLoad,
                        color: levelColor(
                          perDay[d]!.fold(
                            0,
                            (m, s) => s.level > m ? s.level : m,
                          ),
                        ),
                        label: l10n.trainingLoadPoints(points(dayLoad[d]!)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Text(
          l10n.trainingWeekLoad(points(total)),
          style: theme.textTheme.titleSmall,
        ),
      ),
    ];
  }
}

class _LoadBar extends StatelessWidget {
  const _LoadBar({
    required this.value,
    required this.color,
    required this.label,
  });

  final double value;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
                color: color,
                backgroundColor: scheme.surfaceContainerHighest,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 48,
            child: Text(
              label,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
