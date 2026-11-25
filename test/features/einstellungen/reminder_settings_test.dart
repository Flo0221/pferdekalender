import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/core/router/app_router.dart';
import 'package:pferdekalender/core/router/routes.dart';
import 'package:pferdekalender/features/einstellungen/domain/setting_keys.dart';
import 'package:pferdekalender/features/einstellungen/ui/settings_providers.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('Erinnerungen: Vorbelegung ändern und Test-Benachrichtigung', (
    tester,
  ) async {
    final app = TestApp.create();
    await app.pump(tester);
    unawaited(app.container.read(routerProvider).push(Routes.settings));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Uhrzeit der Erinnerungen'), 200);
    expect(find.text('Uhrzeit der Erinnerungen'), findsOneWidget);
    expect(find.text('09:00'), findsOneWidget);

    // „7 Tage vorher“ zusätzlich zur Standard-Vorbelegung „1 Tag vorher“.
    await tester.scrollUntilVisible(
      find.widgetWithText(FilterChip, '7 Tage vorher'),
      200,
    );
    await tester.ensureVisible(
      find.widgetWithText(FilterChip, '7 Tage vorher'),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilterChip, '7 Tage vorher'));
    await tester.pumpAndSettle();
    expect(
      await app.container
          .read(settingsRepositoryProvider)
          .getValue(SettingKeys.reminderDefaultOffsets),
      '1,7',
    );

    await tester.scrollUntilVisible(
      find.text('Test-Benachrichtigung senden'),
      200,
    );
    await tester.tap(find.text('Test-Benachrichtigung senden'));
    await tester.pumpAndSettle();
    expect(app.notifications.shown, ['So sehen Erinnerungen aus.']);

    await app.dispose(tester);
  });
}
