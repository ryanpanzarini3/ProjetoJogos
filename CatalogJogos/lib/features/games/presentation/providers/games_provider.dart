import 'package:catalog_jogos/core/network/dio_client.dart';
import 'package:catalog_jogos/features/games/data/repositories/game_repository_impl.dart';
import 'package:catalog_jogos/features/games/data/sources/game_remote_datasource.dart';
import 'package:catalog_jogos/features/games/domain/entities/game_entity.dart';
import 'package:catalog_jogos/features/games/domain/repositories/game_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameRemoteDataSourceProvider = Provider<GameRemoteDataSource>(
  (ref) => GameRemoteDataSourceImpl(
    DioClient.instance,
  ),
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
