import 'package:catalog_jogos/features/games/domain/entities/game_entity.dart';

abstract class GameRepository {
  Future<List<GameEntity>> getGames({
    String? search,
  });

  Future<GameEntity> getGameDetails(
    int id,
  );
}