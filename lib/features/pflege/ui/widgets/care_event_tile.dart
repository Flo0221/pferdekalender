import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/format/formatters.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/time/local_date.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/care_event.dart';
import '../care_actions.dart';
import '../care_labels.dart';
import '../care_providers.dart';

/// Ein Eintrag in Listen: farbiges Symbol, Titel, Zusatzinfo, Erledigt-Haken.
class CareEventTile extends ConsumerWidget {
  const CareEventTile({super.key, required this.event, this.showDate = false});

  final CareEvent event;

  /// In „Anstehend“/„Historie“ das Datum anzeigen (im Kalender nicht nötig).
  final bool showDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final type = ref.watch(careTypeMapProvider)[event.typeId];
    final today = LocalDate.today();
    final overdue = event.isOverdue(today);
    final color = Color(type?.colorValue ?? 0xFF757575);

    final dateText = showDate ? _dateLine(l10n, today, overdue) : null;
    final subtitle = [
      ?dateText,
      eventSubtitle(l10n, event),
    ].where((s) => s.isNotEmpty).join(' · ');

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.18),
        foregroundColor: color,
        child: ExcludeSemantics(child: Icon(careIconFor(type?.iconKey ?? ''))),
      ),
      title: Text(
        eventTitle(l10n, event, type?.name ?? ''),
        style: event.done
            ? TextStyle(color: theme.colorScheme.onSurfaceVariant)
            : null,
      ),
      subtitle: subtitle.isEmpty
          ? null
          : Text(
              subtitle,
              style: overdue
                  ? TextStyle(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    )
                  : null,
            ),
      trailing: Semantics(
        label: event.done ? l10n.careMarkOpen : l10n.careMarkDone,
        excludeSemantics: true,
        child: Checkbox(
          value: event.done,
          onChanged: (v) async {
            if (v == true) {
              await markDoneFlow(context, ref, event);
            } else {
              await ref.read(careRepositoryProvider).markOpen(event.id);
            }
          },
        ),
      ),
      onTap: () => context.push(Routes.careEdit(event.id)),
    );
  }

  String _dateLine(AppLocalizations l10n, LocalDate today, bool overdue) {
    if (event.done) return Fmt.date(event.date);
    if (overdue) return l10n.careOverdueSince(event.date.daysUntil(today));
    final rel = relativeDay(l10n, event.date, today);
    final abs = Fmt.date(event.date);
    return rel == abs ? abs : '$rel · $abs';
  }
}
