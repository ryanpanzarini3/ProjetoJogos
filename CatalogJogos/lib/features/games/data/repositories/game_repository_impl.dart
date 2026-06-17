import '../../domain/entities/game_entity.dart';
import '../../domain/repositories/game_repository.dart';
import '../models/game_model.dart';
import '../sources/game_remote_datasource.dart';

class GameRepositoryImpl implements GameRepository {
final GameRemoteDataSource remoteDataSource;

GameRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<GameEntity>> getGames({
    String? search,
  }) async {
    final List<GameModel> games = await remoteDataSource.getGames(
      search: search,
    );

    return games.map((game) => game.toEntity()).toList();
  }

  @override
  Future<GameEntity> getGameDetails(
    int id,
  ) async {
    final GameModel game = await remoteDataSource.getGameDetails(id);

    return game.toEntity();
  }
}