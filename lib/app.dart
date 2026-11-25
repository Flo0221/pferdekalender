import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/einstellungen/domain/app_theme_mode.dart';
import 'features/einstellungen/ui/settings_providers.dart';
import 'features/pflege/ui/reminder_sync.dart';
import 'l10n/generated/app_localizations.dart';

class PferdekalenderApp extends ConsumerWidget {
  const PferdekalenderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    // Hält Benachrichtigungen mit der Datenbank synchron (auch beim Start).
    ref.watch(reminderSyncProvider);
    final mode = ref.watch(themeModeProvider).value ?? AppThemeMode.system;

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: switch (mode) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      },
      locale: const Locale('de', 'DE'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      routerConfig: router,
    );
  }
}
