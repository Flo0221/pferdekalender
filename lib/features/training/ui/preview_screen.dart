import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/training.dart';
import '../domain/training_generator.dart';
import 'training_labels.dart';
import 'training_providers.dart';

/// Vorschau des generierten Plans (Regel 7): Wochen mit Belastungskurve,
/// Einheiten tauschen oder entfernen, dann übernehmen.
class PreviewScreen extends ConsumerStatefulWidget {
  const PreviewScreen({super.key, required this.params});

  final TrainingParams params;

  @override
  ConsumerState<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends ConsumerState<PreviewScreen> {
  GeneratedPlan? _plan;

  /// Bearbeitete Einheiten je Woche (Tauschen/Entfernen).
  late List<List<GeneratedSession>> _weeks;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _generate();
  }

  Future<void> _generate() async {
    final p = widget.params;
    final generator = await ref.read(trainingGeneratorProvider.future);
    final availability = await ref.read(availabilityLoaderProvider)(
      p.startDate,
      p.endDate,
    );
    final horse = ref.read(selectedHorseProvider).value;
    // Bereits erledigte/fixierte Einheiten im Zeitraum berücksichtigen.
    final existing = horse == null
        ? const <TrainingSession>[]
        : await ref.read(trainingRepositoryProvider).getSessions(horse.id);
    final fixed = [
      for (final s in existing)
        if (!s.date.isBefore(p.startDate) &&
            !s.date.isAfter(p.endDate) &&
            s.status != SessionStatus.cancelled &&
            (s.planId == null || s.pinned || s.status == SessionStatus.done))
          FixedSession(
            date: s.date,
            level: s.level,
            form: s.form,
            minutes: s.durationMinutes,
          ),
    ];
    final plan = generator.generate(
      params: p,
      availability: availability,
      fixed: fixed,
    );
    if (!mounted) return;
    setState(() {
      _plan = plan;
      _weeks = [for (final w in plan.weeks) List.of(w.sessions)];
    });
  }

  double _load(List<GeneratedSession> sessions) {
    final catalog = ref.read(trainingCatalogProvider).value;
    return sessions.fold(
      0,
      (a, s) => a + (catalog?.load(s.level, s.minutes) ?? 0),
    );
  }

  Future<void> _apply() async {
    final l10n = AppLocalizations.of(context);
    final horse = ref.read(selectedHorseProvider).value;
    if (horse == null) return;
    final active = ref.read(activePlanProvider).value;
    if (active != null) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.previewReplaceTitle),
          content: Text(l10n.previewReplaceText),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.actionCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.previewReplace),
            ),
          ],
        ),
      );
      if (ok != true || !mounted) return;
    }
    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    await ref
        .read(trainingRepositoryProvider)
        .savePlan(
          horseId: horse.id,
          params: widget.params,
          sessions: [for (final w in _weeks) ...w],
          today: LocalDate.today(),
        );
    messenger.showSnackBar(SnackBar(content: Text(l10n.previewSaved)));
    if (mounted) {
      context
        ..pop()
        ..pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final plan = _plan;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.previewTitle),
        actions: [
          TextButton(
            onPressed: (plan == null || _saving) ? null : _apply,
            child: Text(l10n.previewApply),
          ),
        ],
      ),
      body: plan == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                if (widget.params.restrictions case final r?)
                  ListTile(
                    leading: const Icon(Icons.warning_amber_outlined),
                    title: Text(l10n.generatorRestrictions),
                    subtitle: Text(r),
                  ),
                _LoadCurve(
                  loads: [for (final w in _weeks) _load(w)],
                  deload: [for (final w in plan.weeks) w.isDeload],
                ),
                for (final w in plan.weeks) _week(l10n, w),
              ],
            ),
    );
  }

  Widget _week(AppLocalizations l10n, PlannedWeek w) {
    final theme = Theme.of(context);
    final sessions = _weeks[w.index];
    final dayFormat = DateFormat('EE d.M.', 'de_DE');
    final warning = w.warning;
    final reasons = warning == null
        ? const <String>[]
        : [
            if (warning.nightDays > 0) l10n.previewWarningNight,
            if (warning.noTimeDays > 0) l10n.previewWarningTime,
            if (warning.coveredDays > 0) l10n.previewWarningCovered,
          ];
    final days = [for (var i = 0; i < 7; i++) w.start.addDays(i)];

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(
              '${l10n.previewWeek(w.index + 1)} · ${Fmt.date(w.start)}',
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              [
                l10n.trainingWeekLoad(points(_load(sessions))),
                if (w.isDeload) l10n.previewDeload,
              ].join(' · '),
            ),
          ),
          if (warning != null)
            Container(
              color: theme.colorScheme.errorContainer,
              padding: const EdgeInsets.all(12),
              child: Text(
                [
                  '${l10n.previewWarning(w.index + 1, warning.achieved, warning.requested)}'
                      '${reasons.isEmpty ? '' : ' – ${reasons.join(', ')}'}.',
                  if (warning.shorterPossible > 0)
                    l10n.previewWarningShorter(warning.shorterPossible),
                ].join('\n'),
                style: TextStyle(color: theme.colorScheme.onErrorContainer),
              ),
            ),
          if (w.formRepeatWarning)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                l10n.previewFormRepeat,
                style: theme.textTheme.bodySmall,
              ),
            ),
          for (final d in days)
            if (!d.isAfter(widget.params.endDate))
              ...() {
                final daySessions = sessions.where((s) => s.date == d).toList();
                if (daySessions.isEmpty) {
                  final kind = w.restDays[d];
                  if (kind == RestKind.beforeStart) return const <Widget>[];
                  return [
                    ListTile(
                      dense: true,
                      leading: SizedBox(
                        width: 56,
                        child: Text(dayFormat.format(d.toLocalDateTime())),
                      ),
                      title: Text(switch (kind) {
                        RestKind.covered => l10n.previewRest_covered,
                        RestKind.afterNight => l10n.previewRest_afterNight,
                        RestKind.noTime => l10n.previewRest_noTime,
                        _ => l10n.previewRest_rest,
                      }, style: theme.textTheme.bodySmall),
                    ),
                  ];
                }
                return [
                  for (final s in daySessions)
                    _sessionTile(l10n, w, s, dayFormat),
                ];
              }(),
        ],
      ),
    );
  }

  Widget _sessionTile(
    AppLocalizations l10n,
    PlannedWeek w,
    GeneratedSession s,
    DateFormat dayFormat,
  ) {
    final color = levelColor(s.level);
    return ListTile(
      leading: SizedBox(
        width: 56,
        child: Text(dayFormat.format(s.date.toLocalDateTime())),
      ),
      title: Text(s.unit.name),
      subtitle: Text(l10n.trainingSessionMeta(s.level, s.minutes)),
      onTap: () => _details(l10n, s),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(
            child: CircleAvatar(radius: 6, backgroundColor: color),
          ),
          IconButton(
            tooltip: l10n.previewSwap,
            icon: const Icon(Icons.swap_horiz),
            onPressed: () => _swap(l10n, w, s),
          ),
          IconButton(
            tooltip: l10n.previewRemove,
            icon: const Icon(Icons.close),
            onPressed: () => setState(() => _weeks[w.index].remove(s)),
          ),
        ],
      ),
    );
  }

  Future<void> _swap(
    AppLocalizations l10n,
    PlannedWeek w,
    GeneratedSession s,
  ) async {
    final generator = await ref.read(trainingGeneratorProvider.future);
    final alt = generator.alternative(s, widget.params, w.index);
    if (!mounted) return;
    if (alt == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.previewNoAlternative)));
      return;
    }
    setState(() {
      final list = _weeks[w.index];
      list[list.indexOf(s)] = alt;
    });
  }

  Future<void> _details(
    AppLocalizations l10n,
    GeneratedSession s,
  ) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      final theme = Theme.of(context);
      Widget section(String title, List<String> lines) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleSmall),
            for (final l in lines) Text('• $l'),
          ],
        ),
      );
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            Text(s.unit.name, style: theme.textTheme.titleLarge),
            Text(
              '${Fmt.date(s.date)} · ${l10n.trainingSessionMeta(s.level, s.minutes)}',
            ),
            const SizedBox(height: 12),
            section(l10n.trainingWhyHere, reasonLines(l10n, s.reason)),
            section(l10n.trainingFieldWarmup, s.content.warmup),
            section(l10n.trainingFieldWork, s.content.work),
            section(l10n.trainingFieldCooldown, s.content.cooldown),
            if (s.content.pauseHint case final h?)
              Text(h, style: theme.textTheme.bodySmall),
          ],
        ),
      );
    },
  );
}

/// Balkendiagramm der Wochenbelastung (eigener Painter, keine Bibliothek).
class _LoadCurve extends StatelessWidget {
  const _LoadCurve({required this.loads, required this.deload});

  final List<double> loads;
  final List<bool> deload;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    if (loads.isEmpty) return const SizedBox.shrink();
    final max = loads.reduce((a, b) => a > b ? a : b);
    final min = loads.reduce((a, b) => a < b ? a : b);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.previewLoadCurve, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          Semantics(
            label: l10n.previewLoadCurveLabel(points(min), points(max)),
            excludeSemantics: true,
            child: SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < loads.length; i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              points(loads[i]),
                              style: theme.textTheme.labelSmall,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 2),
                            Container(
                              height: max == 0 ? 0 : 80 * loads[i] / max,
                              decoration: BoxDecoration(
                                color: deload[i]
                                    ? theme.colorScheme.tertiary
                                    : theme.colorScheme.primary,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text('${i + 1}', style: theme.textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
