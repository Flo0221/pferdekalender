import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../time/calendar_grid.dart';
import '../time/local_date.dart';

/// Kurzes, farbiges Abzeichen unter dem Tag (z. B. Schicht-Kürzel „F“).
class CalendarBadge {
  const CalendarBadge(this.label, this.color, {this.semanticLabel});
  final String label;
  final Color color;
  final String? semanticLabel;
}

/// Eigener, schlanker Kalender (Monat / 2 Wochen / Woche, Montag zuerst).
/// Unter jedem Tag erscheinen bis zu 4 farbige Punkte ([dotsFor]).
class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    super.key,
    required this.focused,
    required this.selected,
    required this.span,
    required this.dotsFor,
    required this.onSelect,
    required this.onFocusChange,
    required this.onSpanChange,
    this.semanticsCountFor,
    this.badgeFor,
  });

  /// Optionales Abzeichen je Tag; ersetzt dann die Punkte.
  final CalendarBadge? Function(LocalDate day)? badgeFor;

  final LocalDate focused;
  final LocalDate selected;
  final CalendarSpan span;

  /// Farben der Punkte für einen Tag (leer = keine Punkte).
  final List<Color> Function(LocalDate day) dotsFor;

  /// Anzahl Einträge für Screenreader (optional).
  final int Function(LocalDate day)? semanticsCountFor;
  final ValueChanged<LocalDate> onSelect;
  final ValueChanged<LocalDate> onFocusChange;
  final ValueChanged<CalendarSpan> onSpanChange;

  static final _monthFormat = DateFormat('MMMM yyyy', 'de_DE');
  static final _dayFormat = DateFormat('EEEE, d. MMMM yyyy', 'de_DE');
  static const _weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final weeks = calendarWeeks(focused, span);
    final spanLabel = switch (span) {
      CalendarSpan.month => l10n.careFormatMonth,
      CalendarSpan.twoWeeks => l10n.careFormat2Weeks,
      CalendarSpan.week => l10n.careFormatWeek,
    };
    final title = span == CalendarSpan.month
        ? _monthFormat.format(focused.toLocalDateTime())
        : _monthFormat.format(weeks.first.first.toLocalDateTime());

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (d) {
        final v = d.primaryVelocity ?? 0;
        if (v.abs() < 200) return;
        onFocusChange(shiftFocus(focused, span, v < 0 ? 1 : -1));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: l10n.calendarPrevious,
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => onFocusChange(shiftFocus(focused, span, -1)),
                ),
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: l10n.calendarNext,
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => onFocusChange(shiftFocus(focused, span, 1)),
                ),
                OutlinedButton(
                  onPressed: () => onSpanChange(
                    CalendarSpan.values[(span.index + 1) %
                        CalendarSpan.values.length],
                  ),
                  child: Text(spanLabel),
                ),
              ],
            ),
            ExcludeSemantics(
              child: Row(
                children: [
                  for (final w in _weekdays)
                    Expanded(
                      child: Center(
                        child: Text(
                          w,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            for (final week in weeks)
              Row(
                children: [
                  for (final day in week)
                    Expanded(child: _dayCell(context, day, l10n)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _dayCell(BuildContext context, LocalDate day, AppLocalizations l10n) {
    final scheme = Theme.of(context).colorScheme;
    final today = LocalDate.today();
    final inMonth = span != CalendarSpan.month || day.month == focused.month;
    final isSelected = day == selected;
    final isToday = day == today;
    final dots = dotsFor(day);
    final badge = badgeFor?.call(day);
    final count = semanticsCountFor?.call(day) ?? dots.length;

    final Color? fill = isSelected
        ? scheme.primary
        : isToday
        ? scheme.primaryContainer
        : null;
    final textColor = isSelected
        ? scheme.onPrimary
        : isToday
        ? scheme.onPrimaryContainer
        : inMonth
        ? scheme.onSurface
        : scheme.onSurface.withValues(alpha: 0.35);

    return Semantics(
      button: true,
      selected: isSelected,
      label:
          '${_dayFormat.format(day.toLocalDateTime())}'
          '${badge?.semanticLabel != null ? ', ${badge!.semanticLabel}' : ''}'
          '${count > 0 ? ', ${l10n.calendarEntries(count)}' : ''}',
      excludeSemantics: true,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => onSelect(day),
        child: SizedBox(
          height: badge == null ? 48 : 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
                child: Text('${day.day}', style: TextStyle(color: textColor)),
              ),
              const SizedBox(height: 2),
              if (badge != null)
                Container(
                  constraints: const BoxConstraints(minWidth: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: badge.color.withValues(alpha: inMonth ? 1 : 0.4),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color:
                          ThemeData.estimateBrightnessForColor(badge.color) ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (final c in dots.take(4))
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: inMonth ? c : c.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
