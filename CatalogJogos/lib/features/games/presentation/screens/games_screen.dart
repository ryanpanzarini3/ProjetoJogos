import 'package:catalog_jogos/features/games/presentation/providers/games_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamesScreen extends ConsumerWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsync = ref.watch(gamesProvider(null));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog Jogos'),
      ),
      body: gamesAsync.when(
        data: (games) => ListView.builder(
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return ListTile(
              leading: game.backgroundImage != null
                  ? Image.network(
                      game.backgroundImage!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.gamepad),
                    )
                  : const Icon(Icons.gamepad),
              title: Text(game.name),
              subtitle: Text(
                  'Rating: ${game.rating ?? 'N/A'} | Released: ${game.released ?? 'N/A'}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text('Erro ao carregar jogos'),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(gamesProvider(null)),
                child: const Text('Tentar Novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
