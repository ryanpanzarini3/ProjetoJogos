class FavoriteLocalDatasource {
 final DatabaseHelper _db;
 FavoriteLocalDatasource(this._db);
 Future<List<GameModel>> getFavorites() async {
 final db = await _db.database;
 final maps = await db.query('favorites');
 return maps.map((m) => GameModel.fromJson(m)).toList();
 }
 Future<void> addFavorite(GameModel game) async {
 final db = await _db.database;
 await db.insert('favorites', game.toJson(),
 conflictAlgorithm: ConflictAlgorithm.replace);
 }
 Future<void> removeFavorite(int id) async {
 final db = await _db.database;
 await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
 }
 Future<bool> isFavorite(int id) async {
 final db = await _db.database;
 final result = await db.query('favorites',
 where: 'id = ?', whereArgs: [id]);
 return result.isNotEmpty;
 }
}