import 'package:catalog_jogos/core/network/dio_client.dart';
import 'package:catalog_jogos/features/games/data/repositories/game_repository_impl.dart';
import 'package:catalog_jogos/features/games/data/sources/game_remote_datasource.dart';
import 'package:catalog_jogos/features/games/domain/entities/game_entity.dart';
import 'package:catalog_jogos/features/games/domain/repositories/game_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:catalog_jogos/features/games/data/sources/game_mock_datasource.dart'; // Importa o Mock

final gameRemoteDataSourceProvider = Provider<GameRemoteDataSource>(
  (ref) => GameMockDataSource(), // Troca para o Mock
);

final gameRepositoryProvider = Provider<GameRepository>(
  (ref) => GameRepositoryImpl(
    ref.watch(gameRemoteDataSourceProvider),
  ),
);

final gamesProvider = FutureProvider.family<List<GameEntity>, String?>(
  (ref, search) async {
    final repository = ref.watch(gameRepositoryProvider);

    return repository.getGames(search: search);
  },
);

final gameDetailProvider = FutureProvider.family<GameEntity, int>(
  (ref, id) async {
    final repository = ref.watch(gameRepositoryProvider);
    return repository.getGameDetails(id);
  },
);
