import 'package:catalog_jogos/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:catalog_jogos/features/games/presentation/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('Nenhum favorito ainda'))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final game = favorites[index];
                return GameCard(
                  game: game.toEntity(),
                  onTap: () => context.push('/game/${game.id}'),
                );
              },
            ),
    );
  }
}
