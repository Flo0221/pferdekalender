import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
// Nur die eingebetteten Zeitzonendaten – niemals timezone/standalone.dart
// oder browser.dart (die laden Daten per HTTP nach).
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../features/pflege/domain/reminder_planner.dart';

/// Status der Benachrichtigungs-Berechtigungen.
class NotificationPermissionState {
  const NotificationPermissionState({
    required this.notificationsAllowed,
    required this.exactAlarmsAllowed,
  });

  final bool notificationsAllowed;
  final bool exactAlarmsAllowed;
}

/// Schnittstelle zum Betriebssystem. In Tests durch eine Fälschung ersetzt.
abstract interface class NotificationGateway {
  Future<void> init();

  /// Löscht alle geplanten Benachrichtigungen und plant [notifications] neu.
  Future<void> replaceAll(
    List<PlannedNotification> notifications, {
    required bool exact,
  });

  Future<NotificationPermissionState> permissionState();

  /// Fragt die Benachrichtigungs-Berechtigung an (Android 13+).
  Future<bool> requestNotifications();

  /// Öffnet die Systemeinstellung für „Wecker & Erinnerungen“ (Android 12+).
  Future<bool> requestExactAlarms();

  Future<void> showTest(String title, String body);
}

/// Echte Umsetzung mit flutter_local_notifications. Alles bleibt lokal.
class LocalNotificationGateway implements NotificationGateway {
  LocalNotificationGateway({
    required this.channelName,
    required this.channelDescription,
  });

  final String channelName;
  final String channelDescription;
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'erinnerungen';
  static const _icon = 'ic_stat_pferdekalender';

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  @override
  Future<void> init() async {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } on Object catch (e) {
      debugPrint('Zeitzone unbekannt, nutze Europe/Berlin: $e');
      tz.setLocalLocation(tz.getLocation('Europe/Berlin'));
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings(_icon),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
    _initialized = true;
  }

  NotificationDetails get _details => NotificationDetails(
    android: AndroidNotificationDetails(
      _channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: _icon,
    ),
    iOS: const DarwinNotificationDetails(),
  );

  @override
  Future<void> replaceAll(
    List<PlannedNotification> notifications, {
    required bool exact,
  }) async {
    await init();
    await _plugin.cancelAllPendingNotifications();
    final canExact =
        exact && (await _android?.canScheduleExactNotifications() ?? false);
    for (final n in notifications) {
      final at = tz.TZDateTime(
        tz.local,
        n.date.year,
        n.date.month,
        n.date.day,
        n.minutes ~/ 60,
        n.minutes % 60,
      );
      await _plugin.zonedSchedule(
        id: n.id,
        scheduledDate: at,
        notificationDetails: _details,
        androidScheduleMode: canExact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
        title: n.title,
        body: n.body,
        payload: n.payload,
      );
    }
  }

  @override
  Future<NotificationPermissionState> permissionState() async {
    await init();
    final android = _android;
    if (android == null) {
      return const NotificationPermissionState(
        notificationsAllowed: true,
        exactAlarmsAllowed: true,
      );
    }
    return NotificationPermissionState(
      notificationsAllowed: await android.areNotificationsEnabled() ?? false,
      exactAlarmsAllowed:
          await android.canScheduleExactNotifications() ?? false,
    );
  }

  @override
  Future<bool> requestNotifications() async {
    await init();
    final android = _android;
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    return await ios?.requestPermissions(alert: true, sound: true) ?? false;
  }

  @override
  Future<bool> requestExactAlarms() async {
    await init();
    return await _android?.requestExactAlarmsPermission() ?? true;
  }

  @override
  Future<void> showTest(String title, String body) async {
    await init();
    await _plugin.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: _details,
    );
  }
}
