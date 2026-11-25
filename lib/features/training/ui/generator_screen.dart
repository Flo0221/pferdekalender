import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../einstellungen/domain/setting_keys.dart';
import '../../einstellungen/ui/settings_providers.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/training.dart';
import 'training_labels.dart';
import 'training_providers.dart';

/// Eingaben für den Plan-Generator.
class GeneratorScreen extends ConsumerStatefulWidget {
  const GeneratorScreen({super.key});

  @override
  ConsumerState<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends ConsumerState<GeneratorScreen> {
  TrainingGoal _goal = TrainingGoal.muskelaufbau;
  int _fitness = 3;
  int _days = 4;
  int _weeks = 8;
  LocalDate _start = LocalDate.today();
  Set<String>? _forms;
  final Set<String> _exclusions = {};
  final _restrictions = TextEditingController();
  int? _share;
  int _buffer = 20;
  int _defaultMinutes = 60;
  bool _disclaimerChecked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showDisclaimerOnce());
  }

  @override
  void dispose() {
    _restrictions.dispose();
    super.dispose();
  }

  /// Hinweis beim ersten Erstellen eines Trainingsplans.
  Future<void> _showDisclaimerOnce() async {
    if (_disclaimerChecked || !mounted) return;
    _disclaimerChecked = true;
    final repo = ref.read(settingsRepositoryProvider);
    if (await repo.getValue(SettingKeys.trainingDisclaimerSeen) == 'true') {
      return;
    }
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.info_outline),
        title: Text(l10n.generatorDisclaimerTitle),
        content: Text(l10n.disclaimer),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.generatorDisclaimerOk),
          ),
        ],
      ),
    );
    await repo.setValue(SettingKeys.trainingDisclaimerSeen, 'true');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final catalog = ref.watch(trainingCatalogProvider).value;
    final horse = ref.watch(selectedHorseProvider).value;
    final horseCount = ref.watch(activeHorsesProvider).value?.length ?? 1;
    final forms = _forms ??= {
      if (catalog != null)
        for (final f in catalog.forms)
          if (f.key != 'springen') f.key,
    };
    final share = _share ?? (100 / (horseCount < 1 ? 1 : horseCount)).round();

    Widget header(String text) => Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 6),
      child: Semantics(
        header: true,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.generatorTitle)),
      body: catalog == null || horse == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                header(l10n.generatorGoal),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final g in TrainingGoal.values)
                      ChoiceChip(
                        label: Text(goalName(l10n, g)),
                        selected: _goal == g,
                        onSelected: (_) => setState(() => _goal = g),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  goalHint(l10n, _goal),
                  style: _goal == TrainingGoal.wiedereinstieg
                      ? theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.w600,
                        )
                      : theme.textTheme.bodyMedium,
                ),
                header(l10n.generatorFitness(_fitness)),
                Slider(
                  value: _fitness.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: '$_fitness',
                  semanticFormatterCallback: (v) =>
                      l10n.generatorFitness(v.round()),
                  onChanged: (v) => setState(() => _fitness = v.round()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.generatorFitnessLow,
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      l10n.generatorFitnessHigh,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                header(l10n.generatorDays(_days)),
                SegmentedButton<int>(
                  segments: [
                    for (final d in [3, 4, 5, 6])
                      ButtonSegment(value: d, label: Text('$d')),
                  ],
                  selected: {_days},
                  onSelectionChanged: (s) => setState(() => _days = s.single),
                ),
                header(l10n.generatorWeeks),
                SegmentedButton<int>(
                  segments: [
                    for (final w in [4, 6, 8, 12])
                      ButtonSegment(
                        value: w,
                        label: Text(l10n.generatorWeeksValue(w)),
                      ),
                  ],
                  selected: {_weeks},
                  onSelectionChanged: (s) => setState(() => _weeks = s.single),
                ),
                const SizedBox(height: 16),
                DateField(
                  label: l10n.generatorStart,
                  value: _start,
                  clearable: false,
                  lastDate: LocalDate.today().addYears(1),
                  onChanged: (d) => setState(() => _start = d ?? _start),
                ),
                header(l10n.generatorForms),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final f in catalog.forms)
                      FilterChip(
                        label: Text(f.name),
                        selected: forms.contains(f.key),
                        onSelected: (on) => setState(
                          () => on ? forms.add(f.key) : forms.remove(f.key),
                        ),
                      ),
                  ],
                ),
                if (forms.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      l10n.generatorFormsNone,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                header(l10n.generatorExclusions),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final e in catalog.exclusions)
                      FilterChip(
                        label: Text(e.name),
                        selected: _exclusions.contains(e.tag),
                        onSelected: (on) => setState(
                          () => on
                              ? _exclusions.add(e.tag)
                              : _exclusions.remove(e.tag),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _restrictions,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: l10n.generatorRestrictions,
                    hintText: l10n.generatorRestrictionsHint,
                  ),
                ),
                header(l10n.generatorShare(horse.displayName, share)),
                Text(l10n.generatorShareHint, style: theme.textTheme.bodySmall),
                Slider(
                  value: share.toDouble(),
                  min: 10,
                  max: 100,
                  divisions: 18,
                  label: '$share %',
                  onChanged: (v) => setState(() => _share = v.round()),
                ),
                header(l10n.generatorBuffer(_buffer)),
                Slider(
                  value: _buffer.toDouble(),
                  min: 0,
                  max: 45,
                  divisions: 9,
                  label: '$_buffer',
                  onChanged: (v) => setState(() => _buffer = v.round()),
                ),
                header(l10n.generatorDefaultMinutes(_defaultMinutes)),
                Slider(
                  value: _defaultMinutes.toDouble(),
                  min: 0,
                  max: 180,
                  divisions: 12,
                  label: '$_defaultMinutes',
                  onChanged: (v) => setState(() => _defaultMinutes = v.round()),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.disclaimer,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  icon: const Icon(Icons.preview_outlined),
                  label: Text(l10n.generatorPreview),
                  onPressed: forms.isEmpty
                      ? null
                      : () => context.push(
                          Routes.trainingPreview,
                          extra: TrainingParams(
                            goal: _goal,
                            fitness: _fitness,
                            daysPerWeek: _days,
                            weeks: _weeks,
                            startDate: _start,
                            forms: {...forms},
                            exclusions: {..._exclusions},
                            restrictions: _restrictions.text.trim().isEmpty
                                ? null
                                : _restrictions.text.trim(),
                            sharePercent: share,
                            bufferMinutes: _buffer,
                            defaultMinutes: _defaultMinutes,
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
