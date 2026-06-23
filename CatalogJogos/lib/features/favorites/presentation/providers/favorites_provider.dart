import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catalog_jogos/core/database/helper.dart';
import 'package:catalog_jogos/features/favorites/data/sources/favorite_local_datasource.dart';
import 'package:catalog_jogos/features/games/data/models/game_model.dart';

final databaseHelperProvider = Provider<DatabaseHelper?>((ref) => kIsWeb ? null : DatabaseHelper.instance);

final favoriteLocalDatasourceProvider = Provider<FavoriteLocalDatasource>((ref) =>
    FavoriteLocalDatasource(ref.read(databaseHelperProvider)));

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<GameModel>>(
  (ref) => FavoritesNotifier(ref.read(favoriteLocalDatasourceProvider)),
);

class FavoritesNotifier extends StateNotifier<List<GameModel>> {
	final FavoriteLocalDatasource _datasource;
	FavoritesNotifier(this._datasource) : super([]) {
		load();
	}

	Future<void> load() async {
		state = await _datasource.getFavorites();
	}

	Future<void> toggle(GameModel game) async {
		final exists = state.any((g) => g.id == game.id);
		if (exists) {
			await _datasource.removeFavorite(game.id);
		} else {
			await _datasource.addFavorite(game);
		}
		await load();
	}
}