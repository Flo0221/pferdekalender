import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/platform/web_env.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../einstellungen/domain/reminder_settings.dart';
import '../../einstellungen/ui/settings_providers.dart';
import '../data/care_repository.dart';
import '../domain/ics_export.dart';
import 'care_labels.dart';
import 'care_providers.dart';

/// Offene Pflegetermine aller aktiven Pferde (mit Pferde- und Artnamen).
final openCareEventsProvider = StreamProvider<List<ReminderCandidate>>(
  (ref) => ref.watch(careRepositoryProvider).watchOpenEvents(),
);

/// Web-App: Kalender-Export statt Benachrichtigungen. Auf Android/iOS gibt
/// es dafür echte Benachrichtigungen, daher dort ausgeblendet.
bool calendarExportAvailable(WidgetRef ref) => ref.read(webEnvProvider).isWeb;

IcsEvent icsEventFor(AppLocalizations l10n, ReminderCandidate c) {
  final e = c.event;
  final details = [
    eventSubtitle(l10n, e),
    ?e.notes,
  ].where((s) => s.trim().isNotEmpty).join('\n');
  return IcsEvent(
    uid: careEventUid(e.id),
    date: e.date,
    startMinutes: e.timeMinutes,
    summary: '${c.horseName}: ${eventTitle(l10n, e, c.typeName)}',
    description: details,
    alarmOffsetsDays: e.reminderOffsets,
  );
}

/// Termine von heute bis einschließlich heute + 3 Monate, nach Datum.
List<ReminderCandidate> upcomingForExport(
  List<ReminderCandidate> open,
  LocalDate today,
) {
  final end = today.addMonths(3);
  return open
      .where((c) => !c.event.date.isBefore(today) && !c.event.date.isAfter(end))
      .toList()
    ..sort((a, b) => a.event.date.compareTo(b.event.date));
}

Future<void> _download(
  BuildContext context,
  WidgetRef ref,
  List<ReminderCandidate> items, {
  required String kind,
}) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  if (items.isEmpty) {
    messenger.showSnackBar(SnackBar(content: Text(l10n.icsExportNone)));
    return;
  }
  final settings =
      ref.read(reminderSettingsProvider).value ?? const ReminderSettings();
  final ics = buildIcs(
    [for (final c in items) icsEventFor(l10n, c)],
    reminderMinutes: settings.minutes,
    now: DateTime.now(),
    alarmText: l10n.icsAlarmText,
  );
  await ref
      .read(webEnvProvider)
      .downloadFile(
        utf8.encode(ics),
        icsFileName(LocalDate.today(), kind: kind),
        'text/calendar',
      );
  messenger.showSnackBar(
    SnackBar(content: Text(l10n.icsExportDone(items.length))),
  );
}

/// Ein einzelner offener Termin als .ics.
Future<void> exportCareEventToCalendar(
  BuildContext context,
  WidgetRef ref,
  String eventId,
) async {
  final open = await ref.read(careRepositoryProvider).getOpenEvents();
  if (!context.mounted) return;
  await _download(context, ref, [
    for (final c in open)
      if (c.event.id == eventId) c,
  ], kind: 'termin');
}

/// Alle offenen Termine der nächsten 3 Monate (alle Pferde) als .ics.
Future<void> exportUpcomingToCalendar(
  BuildContext context,
  WidgetRef ref,
) async {
  final open = await ref.read(careRepositoryProvider).getOpenEvents();
  if (!context.mounted) return;
  await _download(
    context,
    ref,
    upcomingForExport(open, LocalDate.today()),
    kind: 'termine',
  );
}
