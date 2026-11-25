import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/calendar_grid.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/minutes_field.dart';
import '../../../core/widgets/month_calendar.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/shift.dart';
import '../domain/shift_logic.dart';
import 'shift_providers.dart';
import 'shift_templates_screen.dart';
import 'widgets/shift_badge.dart';

/// Tab „Dienst“: persönlicher Schichtplan (pferdeunabhängig).
class DienstplanScreen extends ConsumerStatefulWidget {
  const DienstplanScreen({super.key});

  @override
  ConsumerState<DienstplanScreen> createState() => _DienstplanScreenState();
}

/// Auswahl im Schnell-Modus: eine Vorlage oder „Leeren“.
sealed class _QuickPick {
  const _QuickPick();
}

class _PickTemplate extends _QuickPick {
  const _PickTemplate(this.id);
  final String id;
}

class _PickClear extends _QuickPick {
  const _PickClear();
}

class _DienstplanScreenState extends ConsumerState<DienstplanScreen> {
  LocalDate _focused = LocalDate.today();
  LocalDate _selected = LocalDate.today();
  CalendarSpan _span = CalendarSpan.month;
  bool _quick = false;
  _QuickPick? _pick;

  (LocalDate, LocalDate) get _range {
    final weeks = calendarWeeks(_focused, _span);
    // Einen Tag davor laden (Nachtschicht am Vortag), bis Wochenende des
    // ausgewählten Tages (Wochensumme).
    final first = weeks.first.first.addDays(-1);
    var last = weeks.last.last;
    final selWeekEnd = _selected.startOfWeek.addDays(6);
    if (selWeekEnd.isAfter(last)) last = selWeekEnd;
    final selWeekStart = _selected.startOfWeek;
    return (selWeekStart.isBefore(first) ? selWeekStart : first, last);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final templates = ref.watch(shiftTemplatesProvider).value;
    final templateMap = ref.watch(shiftTemplateMapProvider).value ?? const {};
    final days = ref.watch(shiftDaysProvider(_range)).value ?? const {};

    final hasTemplates = templates != null && templates.isNotEmpty;

    return TabScaffold(
      title: l10n.titleDienst,
      showHorseSwitcher: false,
      actions: [
        if (hasTemplates)
          IconButton(
            tooltip: _quick ? l10n.shiftQuickModeEnd : l10n.shiftQuickMode,
            isSelected: _quick,
            icon: const Icon(Icons.edit_calendar_outlined),
            selectedIcon: const Icon(Icons.check),
            onPressed: () => setState(() {
              _quick = !_quick;
              _pick ??= _PickTemplate(templates.first.id);
            }),
          ),
        IconButton(
          tooltip: l10n.shiftPatterns,
          icon: const Icon(Icons.repeat),
          onPressed: () => context.push(Routes.shiftPatterns),
        ),
        IconButton(
          tooltip: l10n.shiftTemplates,
          icon: const Icon(Icons.view_list_outlined),
          onPressed: () => context.push(Routes.shiftTemplates),
        ),
      ],
      body: templates == null
          ? const Center(child: CircularProgressIndicator())
          : !hasTemplates
          ? _noTemplates(l10n)
          : Column(
              children: [
                if (_quick) _quickBar(l10n, templates),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      MonthCalendar(
                        focused: _focused,
                        selected: _selected,
                        span: _span,
                        dotsFor: (day) => [
                          if (days[day]?.otherPersonCovers ?? false)
                            Theme.of(context).colorScheme.tertiary,
                        ],
                        semanticsCountFor: (_) => 0,
                        badgeFor: (day) => _badge(l10n, days[day], templateMap),
                        onSelect: (d) => _onDayTap(d, days[d]),
                        onFocusChange: (d) => setState(() => _focused = d),
                        onSpanChange: (s) => setState(() {
                          _span = s;
                          _focused = _selected;
                        }),
                      ),
                      const Divider(height: 1),
                      if (!_quick) _dayDetails(l10n, days, templateMap),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _noTemplates(AppLocalizations l10n) => ListView(
    children: [
      EmptyState(
        icon: Icons.work_history_outlined,
        title: l10n.emptyDienstTitle,
        message: l10n.emptyDienstMessage,
      ),
      Center(
        child: FilledButton.icon(
          icon: const Icon(Icons.auto_awesome_outlined),
          label: Text(l10n.shiftCreateDefaults),
          onPressed: () =>
              ref.read(shiftRepositoryProvider).createDefaultTemplates(),
        ),
      ),
      const SizedBox(height: 8),
      Center(
        child: TextButton.icon(
          icon: const Icon(Icons.add),
          label: Text(l10n.shiftTemplateNew),
          onPressed: () => editShiftTemplate(context, ref, null),
        ),
      ),
    ],
  );

  CalendarBadge? _badge(
    AppLocalizations l10n,
    ShiftDay? day,
    Map<String, ShiftTemplate> templates,
  ) {
    if (day == null) return null;
    final t = day.templateId == null ? null : templates[day.templateId];
    final scheme = Theme.of(context).colorScheme;
    if (t == null) {
      if (day.overrideMinutes == null) return null;
      return CalendarBadge(
        Fmt.duration(day.overrideMinutes!).replaceAll(' ', ''),
        scheme.surfaceContainerHighest,
        semanticLabel:
            '${l10n.shiftStableToday} ${Fmt.duration(day.overrideMinutes!)}',
      );
    }
    final label = day.overrideMinutes == null ? t.shortCode : '${t.shortCode}*';
    return CalendarBadge(label, Color(t.colorValue), semanticLabel: t.name);
  }

  Future<void> _onDayTap(LocalDate d, ShiftDay? day) async {
    if (!_quick) {
      setState(() {
        _selected = d;
        if (_span == CalendarSpan.month && d.month != _focused.month) {
          _focused = d;
        }
      });
      return;
    }
    final repo = ref.read(shiftRepositoryProvider);
    switch (_pick) {
      case _PickTemplate(:final id):
        // Gleiche Schicht nochmal antippen entfernt sie wieder.
        await repo.setShift(d, day?.templateId == id ? null : id);
      case _PickClear():
        await repo.saveDay(ShiftDay(date: d));
      case null:
        break;
    }
  }

  Widget _quickBar(AppLocalizations l10n, List<ShiftTemplate> templates) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.secondaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              l10n.shiftQuickHint,
              style: TextStyle(color: scheme.onSecondaryContainer),
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                for (final t in templates)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      avatar: ShiftBadge(template: t, size: 22),
                      label: Text(t.name),
                      selected: switch (_pick) {
                        _PickTemplate(:final id) => id == t.id,
                        _ => false,
                      },
                      onSelected: (_) =>
                          setState(() => _pick = _PickTemplate(t.id)),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    avatar: const Icon(Icons.backspace_outlined, size: 18),
                    label: Text(l10n.shiftQuickClear),
                    selected: _pick is _PickClear,
                    onSelected: (_) =>
                        setState(() => _pick = const _PickClear()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AddShiftChip(
                    onCreated: (id) =>
                        setState(() => _pick = _PickTemplate(id)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayDetails(
    AppLocalizations l10n,
    Map<LocalDate, ShiftDay> days,
    Map<String, ShiftTemplate> templates,
  ) {
    final theme = Theme.of(context);
    final day = days[_selected];
    final availability = availabilityFor(
      _selected,
      _selected,
      days,
      templates,
    ).single;
    final t = availability.template;
    final week = availabilityFor(
      _selected.startOfWeek,
      _selected.startOfWeek.addDays(6),
      days,
      templates,
    );
    final patternName = day?.source == ShiftSource.pattern
        ? ref
              .watch(shiftPatternsProvider)
              .value
              ?.where((p) => p.id == day?.patternId)
              .firstOrNull
              ?.name
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Semantics(
            header: true,
            child: Text(Fmt.date(_selected), style: theme.textTheme.titleSmall),
          ),
        ),
        ListTile(
          leading: t == null
              ? const Icon(Icons.event_busy_outlined)
              : ShiftBadge(template: t),
          title: Text(t?.name ?? l10n.shiftNoShift),
          subtitle: Text(
            [
              if (t?.startMinutes != null && t?.endMinutes != null)
                l10n.shiftTimeRange(
                  Fmt.time(t!.startMinutes!),
                  Fmt.time(t.endMinutes!),
                ),
              if (availability.minutes != null)
                '${l10n.shiftStableToday} ${Fmt.duration(availability.minutes!)}'
                    '${availability.isOverride ? ' *' : ''}',
              if (availability.otherPersonCovers) l10n.shiftOtherPerson,
              if (patternName != null) l10n.shiftFromPattern(patternName),
              ?day?.note,
              if (day == null) l10n.shiftDayEmpty,
            ].join('\n'),
          ),
          isThreeLine: true,
          trailing: IconButton(
            tooltip: l10n.shiftDayEdit,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _editDay(day ?? ShiftDay(date: _selected)),
          ),
          onTap: () => _editDay(day ?? ShiftDay(date: _selected)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Text(
            l10n.shiftWeekTotal(Fmt.duration(totalMinutes(week))),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _editDay(ShiftDay day) async {
    final result = await showModalBottomSheet<ShiftDay>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _DayEditor(day: day),
    );
    if (result != null) {
      await ref.read(shiftRepositoryProvider).saveDay(result);
    }
  }
}

/// Bearbeiten eines einzelnen Tages: Schicht, eigene Stallzeit, Beisteller.
class _DayEditor extends ConsumerStatefulWidget {
  const _DayEditor({required this.day});
  final ShiftDay day;

  @override
  ConsumerState<_DayEditor> createState() => _DayEditorState();
}

class _DayEditorState extends ConsumerState<_DayEditor> {
  final _formKey = GlobalKey<FormState>();
  late String? _templateId = widget.day.templateId;
  late bool _override = widget.day.overrideMinutes != null;
  late final _minutes = TextEditingController(
    text: '${widget.day.overrideMinutes ?? 20}',
  );
  late bool _covers = widget.day.otherPersonCovers;
  late final _note = TextEditingController(text: widget.day.note);

  @override
  void dispose() {
    _minutes.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final templates = ref.watch(shiftTemplatesProvider).value ?? const [];
    final changedTemplate = _templateId != widget.day.templateId;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    '${l10n.shiftDayEdit} · ${Fmt.date(widget.day.date)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      ChoiceChip(
                        label: Text(l10n.shiftNoShift),
                        selected: _templateId == null,
                        onSelected: (_) => setState(() => _templateId = null),
                      ),
                      for (final t in templates)
                        ChoiceChip(
                          avatar: ShiftBadge(template: t, size: 22),
                          label: Text(t.name),
                          selected: _templateId == t.id,
                          onSelected: (_) => setState(() => _templateId = t.id),
                        ),
                      AddShiftChip(
                        onCreated: (id) => setState(() => _templateId = id),
                      ),
                    ],
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.shiftOverride),
                    subtitle: Text(l10n.shiftOverrideHint),
                    value: _override,
                    onChanged: (v) => setState(() => _override = v),
                  ),
                  if (_override)
                    MinutesField(
                      controller: _minutes,
                      label: l10n.shiftStableToday,
                      onChanged: () => setState(() {}),
                    ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.shiftOtherPerson),
                    subtitle: Text(l10n.shiftOtherPersonHint),
                    value: _covers,
                    onChanged: (v) => setState(() => _covers = v),
                  ),
                  TextFormField(
                    controller: _note,
                    decoration: InputDecoration(labelText: l10n.shiftNote),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.actionCancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    Navigator.pop(
                      context,
                      ShiftDay(
                        date: widget.day.date,
                        templateId: _templateId,
                        overrideMinutes: _override
                            ? int.parse(_minutes.text.trim())
                            : null,
                        otherPersonCovers: _covers,
                        note: _note.text,
                        // Eine geänderte Schicht ist ab jetzt manuell.
                        source: changedTemplate
                            ? ShiftSource.manual
                            : widget.day.source,
                        patternId: changedTemplate
                            ? null
                            : widget.day.patternId,
                      ),
                    );
                  },
                  child: Text(l10n.actionSave),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
