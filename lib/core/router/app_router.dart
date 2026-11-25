import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/dienstplan/ui/dienstplan_screen.dart';
import '../../features/dienstplan/ui/shift_patterns_screen.dart';
import '../../features/dienstplan/ui/shift_templates_screen.dart';
import '../../features/einstellungen/ui/settings_screen.dart';
import '../../features/futter/ui/futter_screen.dart';
import '../../features/pferd/ui/horse_edit_screen.dart';
import '../../features/pferd/ui/horse_list_screen.dart';
import '../../features/pferd/ui/pferd_screen.dart';
import '../../features/pflege/ui/care_edit_screen.dart';
import '../../features/pflege/ui/care_intervals_screen.dart';
import '../../features/pflege/ui/care_types_screen.dart';
import '../../features/pflege/ui/pflege_screen.dart';
import '../../features/training/ui/training_screen.dart';
import '../time/local_date.dart';
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
      routes: [
        GoRoute(
          path: 'eintragsarten',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const CareTypesScreen(),
        ),
        GoRoute(
          path: 'intervalle',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const CareIntervalsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.shiftTemplates,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ShiftTemplatesScreen(),
    ),
    GoRoute(
      path: Routes.shiftPatterns,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ShiftPatternsScreen(),
      routes: [
        GoRoute(
          path: 'neu',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const ShiftPatternEditScreen(),
        ),
        GoRoute(
          path: ':id',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) =>
              ShiftPatternEditScreen(patternId: state.pathParameters['id']),
        ),
      ],
    ),
    GoRoute(
      path: Routes.careNewBase,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final iso = state.uri.queryParameters['datum'];
        LocalDate? date;
        try {
          date = iso == null ? null : LocalDate.parse(iso);
        } on FormatException {
          date = null;
        }
        return CareEditScreen(initialDate: date);
      },
    ),
    GoRoute(
      path: '/pflege-eintrag/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          CareEditScreen(eventId: state.pathParameters['id']),
    ),
    GoRoute(
      path: Routes.horseList,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const HorseListScreen(),
      routes: [
        GoRoute(
          path: 'neu',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const HorseEditScreen(),
        ),
        GoRoute(
          path: ':id/bearbeiten',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) =>
              HorseEditScreen(horseId: state.pathParameters['id']),
        ),
      ],
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
