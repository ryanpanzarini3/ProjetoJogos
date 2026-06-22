import 'package:catalog_jogos/features/games/presentation/screens/game_detail_screen.dart';
import 'package:catalog_jogos/features/games/presentation/screens/games_screen.dart';
import 'package:catalog_jogos/features/settings/presentation/screens/settings_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GamesScreen(),
    ),
    GoRoute(
      path: '/game/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return GameDetailScreen(gameId: id);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
