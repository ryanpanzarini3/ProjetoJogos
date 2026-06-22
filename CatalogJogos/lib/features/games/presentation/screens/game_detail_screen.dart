import 'package:catalog_jogos/features/games/presentation/providers/games_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameDetailScreen extends ConsumerWidget {
  final int gameId;

  const GameDetailScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(gameDetailProvider(gameId));

    return Scaffold(
      body: gameAsync.when(
        data: (game) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'game-image-${game.id}',
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (game.backgroundImage != null)
                        Image.network(game.backgroundImage!, fit: BoxFit.cover)
                      else
                        Container(color: Colors.grey[900]),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0xFF121212)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBB86FC),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildInfoBadge(Icons.star, game.rating?.toString() ?? 'N/A', Colors.amber),
                        const SizedBox(width: 12),
                        _buildInfoBadge(Icons.calendar_today, game.released ?? 'TBA', Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'SOBRE O JOGO',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Este é um dos títulos mais aclamados da indústria. Explore mundos vastos e viva aventuras épicas nesta experiência imersiva de nova geração.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[300], height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    if (game.genres != null) ...[
                      const Text(
                        'CATEGORIAS',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: game.genres!
                            .map((genre) => Chip(
                                  label: Text(genre),
                                  backgroundColor: const Color(0xFF2C2C2C),
                                  side: BorderSide(color: const Color(0xFFBB86FC).withOpacity(0.3)),
                                ))
                            .toList(),
                      ),
                    ],
                    const SizedBox(height: 100), // Espaço extra no final
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF03DAC6),
        label: const Text('ADICIONAR AOS FAVORITOS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.favorite_border, color: Colors.black),
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
