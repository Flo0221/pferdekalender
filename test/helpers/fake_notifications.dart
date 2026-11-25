import 'package:pferdekalender/core/notifications/notification_gateway.dart';
import 'package:pferdekalender/features/pflege/domain/reminder_planner.dart';

/// Merkt sich geplante Benachrichtigungen statt das System aufzurufen.
class FakeNotificationGateway implements NotificationGateway {
  List<PlannedNotification> planned = [];
  int replaceCalls = 0;
  bool notificationsAllowed = true;
  bool exactAllowed = false;
  bool lastExact = false;
  int permissionRequests = 0;
  final shown = <String>[];

  @override
  int maxPending = 400;

  @override
  Future<void> init() async {}

  @override
  Future<void> replaceAll(
    List<PlannedNotification> notifications, {
    required bool exact,
  }) async {
    planned = List.of(notifications);
    lastExact = exact;
    replaceCalls++;
  }

  @override
  Future<NotificationPermissionState> permissionState() async =>
      NotificationPermissionState(
        notificationsAllowed: notificationsAllowed,
        exactAlarmsAllowed: exactAllowed,
      );

  @override
  Future<bool> requestNotifications() async {
    permissionRequests++;
    return notificationsAllowed;
  }

  @override
  Future<bool> requestExactAlarms() async => exactAllowed;

  @override
  Future<void> showTest(String title, String body) async => shown.add(body);
}
