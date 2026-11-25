import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/format/formatters.dart';
import '../../../core/notifications/notification_gateway.dart';
import '../../../core/notifications/notification_providers.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../einstellungen/domain/reminder_settings.dart';
import '../../einstellungen/ui/settings_providers.dart';
import '../../pferd/domain/horse_logic.dart';
import '../data/care_repository.dart';
import '../domain/reminder_planner.dart';
import 'care_labels.dart';
import 'care_providers.dart';

/// Baut aus Terminen und Geburtstagen die Liste der Benachrichtigungen.
/// Reine Funktion (bis auf Texte), damit sie testbar ist.
List<PlannedNotification> buildReminderPlan({
  required AppLocalizations l10n,
  required List<ReminderCandidate> care,
  required List<BirthdayCandidate> birthdays,
  required ReminderSettings settings,
  required DateTime now,
}) {
  final today = LocalDate.fromDateTime(now);
  final sources = <ReminderSource>[
    for (final c in care)
      ReminderSource(
        payload: 'care:${c.event.id}',
        date: c.event.date,
        eventMinutes: c.event.timeMinutes,
        offsets: c.event.reminderOffsets,
        title: '${c.horseName}: ${eventTitle(l10n, c.event, c.typeName)}',
        bodyFor: (offset) => l10n.notificationCareBody(
          c.typeName,
          c.horseName,
          _when(l10n, offset, c.event.date, c.event.timeMinutes),
        ),
      ),
    for (final b in birthdays)
      for (final year in [0, 1])
        if (nextBirthday(b.birthDate, today).addYears(year) case final day)
          ReminderSource(
            payload: 'birthday:${b.horseId}',
            date: day,
            offsets: const [0],
            title: l10n.notificationBirthdayTitle,
            bodyFor: (_) => l10n.notificationBirthdayBody(
              b.horseName,
              l10n.careToday,
              ageOn(b.birthDate, day)?.years ?? 0,
            ),
          ),
  ];
  return planNotifications(
    sources,
    now: now,
    reminderMinutes: settings.minutes,
  );
}

String _when(AppLocalizations l10n, int offset, LocalDate date, int? minutes) {
  final day = switch (offset) {
    0 => l10n.careToday,
    1 => l10n.careTomorrow,
    _ => l10n.careInDays(offset),
  };
  return minutes == null ? day : '$day, ${Fmt.time(minutes)}';
}

/// Hält die geplanten System-Benachrichtigungen mit der Datenbank synchron:
/// Bei jeder Änderung (Termin, Erinnerung, Pferd, Einstellung) werden alle
/// Benachrichtigungen gelöscht und neu geplant – einfach und robust.
/// Läuft auch bei jedem App-Start (deckt Updates und verpasste Neustarts ab).
class ReminderSync {
  ReminderSync({
    required this.gateway,
    required this.l10n,
    required this.care,
    required this.birthdays,
    this.debounce = const Duration(milliseconds: 400),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final NotificationGateway gateway;
  final AppLocalizations l10n;
  final Stream<List<ReminderCandidate>> care;
  final Stream<List<BirthdayCandidate>> birthdays;
  final Duration debounce;
  final DateTime Function() _clock;

  final _subs = <StreamSubscription<Object?>>[];
  List<ReminderCandidate>? _care;
  List<BirthdayCandidate>? _birthdays;
  ReminderSettings? _settings;
  Timer? _timer;
  Future<void> _running = Future.value();

  void start() {
    _subs
      ..add(care.listen((v) => _update(() => _care = v)))
      ..add(birthdays.listen((v) => _update(() => _birthdays = v)));
  }

  void updateSettings(ReminderSettings settings) =>
      _update(() => _settings = settings);

  void _update(void Function() apply) {
    apply();
    if (_care == null || _birthdays == null || _settings == null) return;
    _timer?.cancel();
    _timer = Timer(debounce, () => _running = _running.then((_) => syncNow()));
  }

  /// Plant sofort neu (nach Laden aller Eingaben).
  Future<void> syncNow() async {
    final care = _care, birthdays = _birthdays, settings = _settings;
    if (care == null || birthdays == null || settings == null) return;
    final plan = buildReminderPlan(
      l10n: l10n,
      care: care,
      birthdays: birthdays,
      settings: settings,
      now: _clock(),
    );
    try {
      await gateway.replaceAll(plan, exact: settings.exact);
    } on Object catch (e, st) {
      debugPrint('Erinnerungen konnten nicht geplant werden: $e\n$st');
    }
  }

  Future<void> dispose() async {
    _timer?.cancel();
    for (final s in _subs) {
      await s.cancel();
    }
  }
}

/// Startet den Abgleich; wird in der App-Wurzel beobachtet.
final reminderSyncProvider = Provider<ReminderSync>((ref) {
  final repo = ref.watch(careRepositoryProvider);
  final sync = ReminderSync(
    gateway: ref.watch(notificationGatewayProvider),
    l10n: ref.watch(appL10nProvider),
    care: repo.watchReminderCandidates(),
    birthdays: repo.watchBirthdayCandidates(),
  )..start();
  ref.listen(reminderSettingsProvider, (_, next) {
    if (next.value case final s?) sync.updateSettings(s);
  }, fireImmediately: true);
  ref.onDispose(sync.dispose);
  return sync;
});
