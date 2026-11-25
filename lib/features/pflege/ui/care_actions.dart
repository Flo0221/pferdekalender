import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/care_event.dart';
import 'care_providers.dart';

/// Fragt, ob der Folgetermin ab dem tatsächlichen Datum neu berechnet werden
/// soll. `true` = neu berechnen.
Future<bool> askRecalculateFollowUp(
  BuildContext context, {
  required LocalDate oldDate,
  required LocalDate newDate,
}) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.careRecalcTitle),
      content: Text(l10n.careRecalcText(Fmt.date(oldDate), Fmt.date(newDate))),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.careRecalcNo),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.careRecalcYes),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// „Als erledigt markieren“: tatsächliches Datum wählen, ggf. Folgetermin
/// neu berechnen lassen, Hinweis bei neu angelegtem Folgetermin.
Future<void> markDoneFlow(
  BuildContext context,
  WidgetRef ref,
  CareEvent event,
) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final repo = ref.read(careRepositoryProvider);
  final today = LocalDate.today();
  final initial = event.date.isAfter(today) ? today : event.date;

  final picked = await showDatePicker(
    context: context,
    helpText: l10n.careDoneDateTitle,
    initialDate: initial.toLocalDateTime(),
    firstDate: event.date.addYears(-2).toLocalDateTime(),
    lastDate: today.toLocalDateTime(),
  );
  if (picked == null || !context.mounted) return;
  final actual = LocalDate.fromDateTime(picked);

  final before = await repo.getFollowUp(event.id);
  var recalc = false;
  if (before != null &&
      !before.done &&
      event.repeat != null &&
      actual != event.date) {
    final target = event.repeat!.addTo(actual);
    if (target != before.date && context.mounted) {
      recalc = await askRecalculateFollowUp(
        context,
        oldDate: before.date,
        newDate: target,
      );
    }
  }
  await repo.markDone(event.id, actual, recalculateFollowUp: recalc);
  if (before == null) {
    final created = await repo.getFollowUp(event.id);
    if (created != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.careFollowUpCreated(Fmt.date(created.date))),
        ),
      );
    }
  }
}

/// Löschen mit Bestätigung; bietet an, den offenen Folgetermin mitzulöschen.
/// Gibt `true` zurück, wenn gelöscht wurde.
Future<bool> deleteEventFlow(
  BuildContext context,
  WidgetRef ref,
  CareEvent event,
) async {
  final l10n = AppLocalizations.of(context);
  final repo = ref.read(careRepositoryProvider);
  final followUp = await repo.getFollowUp(event.id);
  final openFollowUp = (followUp != null && !followUp.done) ? followUp : null;
  if (!context.mounted) return false;

  var alsoFollowUp = openFollowUp != null;
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        final scheme = Theme.of(context).colorScheme;
        return AlertDialog(
          title: Text(l10n.careDeleteTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.careDeleteText),
              if (openFollowUp != null)
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: alsoFollowUp,
                  onChanged: (v) => setState(() => alsoFollowUp = v ?? false),
                  title: Text(
                    l10n.careDeleteWithFollowUp(Fmt.date(openFollowUp.date)),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.actionCancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.actionDelete),
            ),
          ],
        );
      },
    ),
  );
  if (ok != true) return false;
  await repo.deleteEvent(event.id, deleteOpenFollowUp: alsoFollowUp);
  return true;
}
