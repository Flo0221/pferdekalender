import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/shift.dart';
import '../domain/shift_logic.dart';
import 'shift_providers.dart';
import 'shift_templates_screen.dart' show AddShiftChip;

/// Liste der Rhythmen.
class ShiftPatternsScreen extends ConsumerWidget {
  const ShiftPatternsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final patterns = ref.watch(shiftPatternsProvider).value ?? const [];
    final templates = ref.watch(shiftTemplateMapProvider).value ?? const {};
    return Scaffold(
      appBar: AppBar(title: Text(l10n.shiftPatterns)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.shiftPatternNew),
        icon: const Icon(Icons.add),
        label: Text(l10n.shiftPatternNew),
      ),
      body: patterns.isEmpty
          ? EmptyState(
              icon: Icons.repeat,
              title: l10n.shiftPatternEmpty,
              message: l10n.shiftPatternStepsHint,
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                for (final p in patterns)
                  ListTile(
                    leading: const Icon(Icons.repeat),
                    title: Text(p.name),
                    subtitle: Text(
                      '${patternSummary(l10n, p.steps, templates)}\n'
                      '${l10n.shiftPatternRange(Fmt.date(p.startDate), Fmt.date(p.endDate))}',
                    ),
                    isThreeLine: true,
                    onTap: () => context.push(Routes.shiftPatternEdit(p.id)),
                    trailing: IconButton(
                      tooltip: l10n.shiftPatternDelete,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _delete(context, ref, p),
                    ),
                  ),
              ],
            ),
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    ShiftPattern p,
  ) async {
    final l10n = AppLocalizations.of(context);
    final choice = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.shiftPatternDelete),
        content: Text(l10n.shiftPatternDeleteText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.shiftPatternDeleteKeepDays),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.shiftPatternDeleteWithDays),
          ),
        ],
      ),
    );
    if (choice == null) return;
    await ref
        .read(shiftRepositoryProvider)
        .deletePattern(p.id, removeDays: choice, from: LocalDate.today());
  }
}

/// „2× F · 2× S · 2× N · 4× –“
String patternSummary(
  AppLocalizations l10n,
  List<String?> steps,
  Map<String, ShiftTemplate> templates,
) => [
  for (final (id, n) in compressSteps(steps))
    '$n× ${id == null ? '–' : (templates[id]?.shortCode ?? '?')}',
].join(' · ');

/// Rhythmus anlegen oder erneut ausrollen.
class ShiftPatternEditScreen extends ConsumerStatefulWidget {
  const ShiftPatternEditScreen({super.key, this.patternId});

  final String? patternId;

  @override
  ConsumerState<ShiftPatternEditScreen> createState() =>
      _ShiftPatternEditScreenState();
}

class _ShiftPatternEditScreenState
    extends ConsumerState<ShiftPatternEditScreen> {
  final _name = TextEditingController();
  final _steps = <String?>[];
  LocalDate _start = LocalDate.today().startOfWeek;
  int _weeks = 8;
  bool _overwrite = false;
  bool _loaded = false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _loadOnce(List<ShiftPattern> patterns) {
    if (_loaded) return;
    _loaded = true;
    if (widget.patternId == null) return;
    for (final p in patterns) {
      if (p.id == widget.patternId) {
        _name.text = p.name;
        _steps.addAll(p.steps);
        _start = p.startDate;
        _weeks = p.weeks;
      }
    }
  }

  Future<void> _apply() async {
    final l10n = AppLocalizations.of(context);
    if (_steps.isEmpty) return;
    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(shiftRepositoryProvider)
        .applyPattern(
          ShiftPattern(
            id: widget.patternId ?? '',
            name: _name.text.trim().isEmpty
                ? l10n.shiftPatternDefaultName
                : _name.text,
            steps: List.of(_steps),
            startDate: _start,
            weeks: _weeks,
          ),
          overwriteManual: _overwrite,
        );
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          [
            l10n.shiftPatternApplied(result.days.length),
            if (result.skippedManual.isNotEmpty)
              l10n.shiftPatternSkipped(result.skippedManual.length),
          ].join('. '),
        ),
      ),
    );
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final patterns = ref.watch(shiftPatternsProvider).value;
    final templates = ref.watch(shiftTemplatesProvider).value ?? const [];
    final templateMap = ref.watch(shiftTemplateMapProvider).value ?? const {};
    if (patterns == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    _loadOnce(patterns);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.patternId == null ? l10n.shiftPatternNew : _name.text,
        ),
        actions: [
          TextButton(
            onPressed: (_steps.isEmpty || _saving) ? null : _apply,
            child: Text(l10n.shiftPatternApply),
          ),
        ],
      ),
      body: templates.isEmpty
          ? ListView(
              children: [
                EmptyState(
                  icon: Icons.repeat,
                  title: l10n.shiftPatternNew,
                  message: l10n.shiftNeedTemplates,
                ),
                Center(child: AddShiftChip(onCreated: (_) {})),
              ],
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                TextField(
                  controller: _name,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: l10n.shiftPatternName,
                    hintText: l10n.shiftPatternNameHint,
                  ),
                ),
                const SizedBox(height: 16),
                Text(l10n.shiftPatternSteps, style: theme.textTheme.titleSmall),
                Text(
                  l10n.shiftPatternStepsHint,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final t in templates)
                      ActionChip(
                        avatar: CircleAvatar(
                          backgroundColor: Color(t.colorValue),
                          radius: 8,
                        ),
                        label: Text('+ ${t.name}'),
                        onPressed: () => setState(() => _steps.add(t.id)),
                      ),
                    ActionChip(
                      label: Text('+ ${l10n.shiftNoShift}'),
                      onPressed: () => setState(() => _steps.add(null)),
                    ),
                    AddShiftChip(
                      onCreated: (id) => setState(() => _steps.add(id)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_steps.isNotEmpty)
                  Card(
                    child: ListTile(
                      title: Text(patternSummary(l10n, _steps, templateMap)),
                      subtitle: Text(l10n.shiftPatternCycle(_steps.length)),
                      trailing: IconButton(
                        tooltip: l10n.shiftPatternUndo,
                        icon: const Icon(Icons.undo),
                        onPressed: () => setState(_steps.removeLast),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_outlined),
                  title: Text(l10n.shiftPatternStart),
                  subtitle: Text(Fmt.date(_start)),
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _start.toLocalDateTime(),
                      firstDate: LocalDate.today()
                          .addYears(-1)
                          .toLocalDateTime(),
                      lastDate: LocalDate.today().addYears(3).toLocalDateTime(),
                    );
                    if (d != null) {
                      setState(() => _start = LocalDate.fromDateTime(d));
                    }
                  },
                ),
                Text(l10n.shiftPatternWeeks(_weeks)),
                Slider(
                  value: _weeks.toDouble(),
                  min: 1,
                  max: 52,
                  divisions: 51,
                  label: '$_weeks',
                  onChanged: (v) => setState(() => _weeks = v.round()),
                ),
                Text(
                  l10n.shiftPatternRange(
                    Fmt.date(_start),
                    Fmt.date(_start.addDays(_weeks * 7 - 1)),
                  ),
                  style: theme.textTheme.bodySmall,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.shiftPatternOverwrite),
                  subtitle: Text(l10n.shiftPatternOverwriteHint),
                  value: _overwrite,
                  onChanged: (v) => setState(() => _overwrite = v),
                ),
                if (_steps.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.shiftPatternPreview,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  _Preview(
                    steps: _steps,
                    start: _start,
                    templates: templateMap,
                  ),
                ],
              ],
            ),
    );
  }
}

/// Vorschau der ersten zwei Wochen.
class _Preview extends StatelessWidget {
  const _Preview({
    required this.steps,
    required this.start,
    required this.templates,
  });

  final List<String?> steps;
  final LocalDate start;
  final Map<String, ShiftTemplate> templates;

  static const _weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (var i = 0; i < 14; i++)
          () {
            final date = start.addDays(i);
            final id = steps[i % steps.length];
            final t = id == null ? null : templates[id];
            final color = t == null
                ? scheme.surfaceContainerHighest
                : Color(t.colorValue);
            final on =
                ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                ? Colors.white
                : Colors.black;
            return Semantics(
              label: '${Fmt.date(date)}: ${t?.name ?? '–'}',
              excludeSemantics: true,
              child: Container(
                width: 44,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      '${_weekdays[date.weekday - 1]} ${date.day}.',
                      style: TextStyle(fontSize: 10, color: on),
                    ),
                    Text(
                      t?.shortCode ?? '–',
                      style: TextStyle(fontWeight: FontWeight.w700, color: on),
                    ),
                  ],
                ),
              ),
            );
          }(),
      ],
    );
  }
}
