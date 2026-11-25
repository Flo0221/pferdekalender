import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/dienstplan/ui/dienstplan_screen.dart';
import '../../features/einstellungen/ui/settings_screen.dart';
import '../../features/futter/ui/futter_screen.dart';
import '../../features/pferd/ui/pferd_screen.dart';
import '../../features/pflege/ui/pflege_screen.dart';
import '../../features/training/ui/training_screen.dart';
import 'app_shell.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter createRouter({String initialLocation = Routes.pflege}) => GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: initialLocation,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(navigationShell: shell),
      branches: [
        _branch(Routes.pflege, const PflegeScreen()),
        _branch(Routes.training, const TrainingScreen()),
        _branch(Routes.futter, const FutterScreen()),
        _branch(Routes.dienst, const DienstplanScreen()),
        _branch(Routes.pferd, const PferdScreen()),
      ],
    ),
    GoRoute(
      path: Routes.settings,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

StatefulShellBranch _branch(String path, Widget screen) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, state) => screen)],
);

final routerProvider = Provider<GoRouter>((ref) {
  final router = createRouter();
  ref.onDispose(router.dispose);
  return router;
});
