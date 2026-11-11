import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/accueil/accueil_screen.dart';
import '../../features/discussion/discussion_screen.dart';
import '../../features/profil/profil_screen.dart';
import '../../features/routine/routine_screen.dart';
import '../../features/scanner/scanner_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../navigation/main_scaffold_page.dart';
import 'not_found_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  initialLocation: '/accueil',
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffoldPage(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/accueil',
              builder: (context, state) => const AccueilScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/routine',
              builder: (context, state) => const RoutineScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/scanner',
              name: 'scanner',
              builder: (context, state) => const ScannerScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/discussion',
              name: 'discussion',
              builder: (context, state) => const DiscussionScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/profil',
              name: 'profil',
              builder: ((context, state) => const ProfilScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
