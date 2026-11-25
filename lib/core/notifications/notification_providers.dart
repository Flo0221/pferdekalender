import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import 'notification_gateway.dart';

/// Deutsche Texte ohne BuildContext (für Benachrichtigungen im Hintergrund).
final appL10nProvider = Provider<AppLocalizations>(
  (ref) => lookupAppLocalizations(const Locale('de')),
);

/// Zugang zu den System-Benachrichtigungen. In Tests überschreiben.
final notificationGatewayProvider = Provider<NotificationGateway>((ref) {
  if (kIsWeb) return const UnsupportedNotificationGateway();
  final l10n = ref.watch(appL10nProvider);
  return LocalNotificationGateway(
    channelName: l10n.notificationChannelName,
    channelDescription: l10n.notificationChannelDescription,
  );
});
