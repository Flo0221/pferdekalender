import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/backup/ui/backup_section.dart';
import '../../features/pferd/ui/widgets/horse_switcher.dart';
import '../../l10n/generated/app_localizations.dart';
import '../router/routes.dart';

/// Gemeinsames Gerüst der fünf Haupt-Tabs: AppBar mit Pferde-Umschalter
/// (bzw. Titel) und Zahnrad für die Einstellungen.
class TabScaffold extends StatelessWidget {
  const TabScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showHorseSwitcher = true,
    this.actions = const [],
    this.floatingActionButton,
  });

  /// Titel, falls kein Pferd angelegt ist oder [showHorseSwitcher] aus ist.
  final String title;
  final Widget body;

  /// Der Dienstplan gehört zur Person – dort ohne Umschalter.
  final bool showHorseSwitcher;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: showHorseSwitcher
            ? HorseSwitcher(fallbackTitle: title)
            : Text(title),
        actions: [
          ...actions,
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.actionSettings,
            onPressed: () => context.push(Routes.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          // Erinnerung an die Datensicherung (nach 7 Tagen).
          const ExportReminderBanner(),
          Expanded(child: body),
        ],
      ),
      // Alle Tabs liegen gleichzeitig im Baum (IndexedStack) – ohne HeroMode
      // kollidieren die Standard-Hero-Tags der FABs beim Seitenwechsel.
      floatingActionButton: floatingActionButton == null
          ? null
          : HeroMode(enabled: false, child: floatingActionButton!),
    );
  }
}
