import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';

/// Untere Navigationsleiste. Jeder Tab ist ein eigener Branch der
/// [StatefulShellRoute] und behält seinen Zustand.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // Erneutes Antippen des aktiven Tabs springt zu dessen Startseite.
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.healing_outlined),
            selectedIcon: const Icon(Icons.healing),
            label: l10n.tabPflege,
          ),
          NavigationDestination(
            icon: const Icon(Icons.fitness_center_outlined),
            selectedIcon: const Icon(Icons.fitness_center),
            label: l10n.tabTraining,
          ),
          NavigationDestination(
            icon: const Icon(Icons.grass_outlined),
            selectedIcon: const Icon(Icons.grass),
            label: l10n.tabFutter,
          ),
          NavigationDestination(
            icon: const Icon(Icons.work_history_outlined),
            selectedIcon: const Icon(Icons.work_history),
            label: l10n.tabDienst,
          ),
          NavigationDestination(
            icon: const Icon(Icons.pets_outlined),
            selectedIcon: const Icon(Icons.pets),
            label: l10n.tabPferd,
          ),
        ],
      ),
    );
  }
}
