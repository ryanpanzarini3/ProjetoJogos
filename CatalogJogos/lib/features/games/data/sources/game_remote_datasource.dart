import 'package:catalog_jogos/core/errors/exceptions.dart';
import 'package:catalog_jogos/features/games/data/models/game_model.dart';
import 'package:dio/dio.dart';

abstract class GameRemoteDataSource {
  Future<List<GameModel>> getGames({
    String? search,
  });

  Future<GameModel> getGameDetails(
    int id,
  );
}

class GameRemoteDataSourceImpl implements GameRemoteDataSource {
  final Dio dio;

  GameRemoteDataSourceImpl(this.dio);

  @override
  Future<List<GameModel>> getGames({
    String? search,
  }) async {
    try {
      final response = await dio.get(
        '/games',
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );

      final results = response.data['results'] as List;

      return results
          .map(
            (json) => GameModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<GameModel> getGameDetails(
    int id,
  ) async {
    try {
      final response = await dio.get(
        '/games/$id',
      );

      return GameModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
