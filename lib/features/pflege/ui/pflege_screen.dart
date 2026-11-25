import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/calendar_grid.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/month_calendar.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/care_event.dart';
import '../domain/care_logic.dart';
import '../domain/care_type.dart';
import 'care_labels.dart';
import 'care_providers.dart';
import 'widgets/care_event_tile.dart';

enum _View { calendar, upcoming, history }

/// Tab „Pflege“: Kalender, anstehende Termine und Historie.
class PflegeScreen extends ConsumerStatefulWidget {
  const PflegeScreen({super.key});

  @override
  ConsumerState<PflegeScreen> createState() => _PflegeScreenState();
}

class _PflegeScreenState extends ConsumerState<PflegeScreen> {
  _View _view = _View.calendar;
  LocalDate _selected = LocalDate.today();
  LocalDate _focused = LocalDate.today();
  CalendarSpan _span = CalendarSpan.month;
  String? _historyType;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final horse = ref.watch(selectedHorseProvider).value;
    final events = ref.watch(selectedHorseCareEventsProvider).value ?? const [];

    return TabScaffold(
      title: l10n.titlePflege,
      floatingActionButton: horse == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(
                Routes.careNew(
                  date: _view == _View.calendar ? _selected.toIso() : null,
                ),
              ),
              icon: const Icon(Icons.add),
              label: Text(l10n.careAdd),
            ),
      body: horse == null
          ? EmptyState(
              icon: Icons.healing_outlined,
              title: l10n.emptyPflegeTitle,
              message: l10n.emptyPflegeNoHorse,
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<_View>(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(
                          value: _View.calendar,
                          label: Text(l10n.careViewCalendar),
                        ),
                        ButtonSegment(
                          value: _View.upcoming,
                          label: Text(l10n.careViewUpcoming),
                        ),
                        ButtonSegment(
                          value: _View.history,
                          label: Text(l10n.careViewHistory),
                        ),
                      ],
                      selected: {_view},
                      onSelectionChanged: (s) =>
                          setState(() => _view = s.single),
                    ),
                  ),
                ),
                Expanded(
                  child: switch (_view) {
                    _View.calendar => _calendarView(l10n, events),
                    _View.upcoming => _upcomingView(l10n, events),
                    _View.history => _historyView(l10n, events),
                  },
                ),
              ],
            ),
    );
  }

  Widget _calendarView(AppLocalizations l10n, List<CareEvent> events) {
    final byDay = <LocalDate, List<CareEvent>>{};
    for (final e in events) {
      (byDay[e.date] ??= []).add(e);
    }
    final dayEvents = byDay[_selected] ?? const <CareEvent>[];
    if (events.isEmpty) {
      return ListView(
        children: [
          _calendar(l10n, byDay),
          EmptyState(
            icon: Icons.healing_outlined,
            title: l10n.emptyPflegeTitle,
            message: l10n.emptyPflegeMessage,
          ),
        ],
      );
    }
    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        _calendar(l10n, byDay),
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
        if (dayEvents.isEmpty)
          ListTile(title: Text(l10n.careDayEmpty))
        else
          for (final e in dayEvents) CareEventTile(event: e),
      ],
    );
  }

  Widget _calendar(
    AppLocalizations l10n,
    Map<LocalDate, List<CareEvent>> byDay,
  ) {
    final types = ref.watch(careTypeMapProvider);
    return MonthCalendar(
      focused: _focused,
      selected: _selected,
      span: _span,
      dotsFor: (day) => [
        for (final e in byDay[day] ?? const <CareEvent>[])
          Color(types[e.typeId]?.colorValue ?? 0xFF757575)
              .withValues(alpha: e.done ? 0.45 : 1),
      ],
      semanticsCountFor: (day) => byDay[day]?.length ?? 0,
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
    );
  }

  Widget _upcomingView(AppLocalizations l10n, List<CareEvent> events) {
    final open = upcomingSorted(events);
    if (open.isEmpty) {
      return EmptyState(
        icon: Icons.event_available_outlined,
        title: l10n.careUpcomingEmpty,
        message: l10n.emptyPflegeMessage,
      );
    }
    final today = LocalDate.today();
    final overdue = open.where((e) => e.isOverdue(today)).toList();
    final rest = open.where((e) => !e.isOverdue(today)).toList();
    final error = Theme.of(context).colorScheme.error;
    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        if (overdue.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Semantics(
              header: true,
              child: Text(
                l10n.careOverdue,
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(color: error),
              ),
            ),
          ),
          for (final e in overdue) CareEventTile(event: e, showDate: true),
          const Divider(),
        ],
        for (final e in rest) CareEventTile(event: e, showDate: true),
      ],
    );
  }

  Widget _historyView(AppLocalizations l10n, List<CareEvent> events) {
    final types = ref.watch(careTypeMapProvider);
    final usedTypeIds = {
      for (final e in events)
        if (e.done) e.typeId,
    };
    final history = historySorted(events, typeId: _historyType);
    final filterType = _historyType == null ? null : types[_historyType];

    // Wirkstoffwechsel auf einen Blick (bei Filter „Wurmkur“).
    String? ingredients;
    if (filterType?.kind == CareKind.wurmkur) {
      final list = distinctSuggestions(
        history.map((e) => e.fields[CareFields.wirkstoff] as String?),
      ).take(4);
      if (list.isNotEmpty) {
        ingredients = l10n.careHistoryActiveIngredients(list.join(' → '));
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(l10n.careFilterAll),
                  selected: _historyType == null,
                  onSelected: (_) => setState(() => _historyType = null),
                ),
              ),
              for (final id in usedTypeIds)
                if (types[id] case final type?)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      avatar: Icon(careIconFor(type.iconKey), size: 18),
                      label: Text(type.name),
                      selected: _historyType == id,
                      onSelected: (on) =>
                          setState(() => _historyType = on ? id : null),
                    ),
                  ),
            ],
          ),
        ),
        if (ingredients != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              ingredients,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        Expanded(
          child: history.isEmpty
              ? EmptyState(
                  icon: Icons.history,
                  title: l10n.careHistoryEmpty,
                  message: '',
                )
              : ListView(
                  padding: const EdgeInsets.only(bottom: 96),
                  children: [
                    for (final e in history)
                      CareEventTile(event: e, showDate: true),
                  ],
                ),
        ),
      ],
    );
  }
}
