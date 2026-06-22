final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<GameModel>>(
 (ref) => FavoritesNotifier(ref.read(favoriteLocalDatasourceProvider)),
);
class FavoritesNotifier extends StateNotifier<List<GameModel>> {
 final FavoriteLocalDatasource _datasource;
 FavoritesNotifier(this._datasource) : super([]) { load(); }
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