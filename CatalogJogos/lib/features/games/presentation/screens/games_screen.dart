import 'package:catalog_jogos/features/games/presentation/providers/games_provider.dart';
import 'package:catalog_jogos/features/games/presentation/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GamesScreen extends ConsumerWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsync = ref.watch(gamesProvider(null));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog Jogos'),
        centerTitle: true,
      ),
      body: gamesAsync.when(
        data: (games) => ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return GameCard(
              game: game,
              onTap: () {
                context.push('/game/${game.id}');
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Erro ao carregar jogos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => ref.refresh(gamesProvider(null)),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tentar Novamente'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
