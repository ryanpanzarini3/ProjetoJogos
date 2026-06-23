import 'package:catalog_jogos/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:catalog_jogos/features/games/data/models/game_model.dart';
import 'package:catalog_jogos/features/games/presentation/providers/games_provider.dart';
import 'package:catalog_jogos/features/games/presentation/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GamesScreen extends ConsumerStatefulWidget {
  const GamesScreen({super.key});

  @override
  ConsumerState<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends ConsumerState<GamesScreen> {
  String? _searchQuery;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gamesAsync = ref.watch(gamesProvider(_searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Pesquisar jogos',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.isEmpty ? null : value;
                  });
                  ref.refresh(gamesProvider(_searchQuery));
                },
              )
            : const Text('Catalog Jogos'),
        centerTitle: true,
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchQuery = null;
                    _searchController.clear();
                  });
                  ref.refresh(gamesProvider(null));
                },
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = null;
                  _searchController.clear();
                  ref.refresh(gamesProvider(null));
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.push('/favorites'),
          ),
        ],
      ),
      body: gamesAsync.when(
        data: (games) => Consumer(
          builder: (context, ref, _) {
            final favorites = ref.watch(favoritesProvider);
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                final isFav = favorites.any((fav) => fav.id == game.id);
                return GameCard(
                  game: game,
                  isFavorite: isFav,
                  onFavoriteTap: () async {
                    final gameModel = GameModel(
                      id: game.id,
                      name: game.name,
                      backgroundImage: game.backgroundImage,
                      rating: game.rating,
                      released: game.released,
                      genres: null,
                    );
                    await ref.read(favoritesProvider.notifier).toggle(gameModel);
                  },
                  onTap: () {
                    context.push('/game/${game.id}');
                  },
                );
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
