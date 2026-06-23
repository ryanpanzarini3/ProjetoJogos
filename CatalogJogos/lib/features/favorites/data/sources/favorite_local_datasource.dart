import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:catalog_jogos/core/database/helper.dart';
import 'package:catalog_jogos/features/games/data/models/game_model.dart';

class FavoriteLocalDatasource {
	final DatabaseHelper? _db;
	FavoriteLocalDatasource(DatabaseHelper? db) : _db = kIsWeb ? null : db {
		debugPrint('FavoriteLocalDatasource init: kIsWeb=\$kIsWeb _db=\${_db == null}');
	}

	Future<List<GameModel>> getFavorites() async {
		debugPrint('getFavorites: kIsWeb=\$kIsWeb _db=\${_db == null}');
		if (kIsWeb || _db == null) {
			debugPrint('getFavorites: using SharedPreferences');
			final prefs = await SharedPreferences.getInstance();
			final list = prefs.getStringList('favorites') ?? [];
			return list.map((s) => GameModel.fromJson(json.decode(s) as Map<String, dynamic>)).toList();
		}

		try {
			final db = await _db!.database;
			final maps = await db.query('favorites');
			return maps.map((m) => GameModel.fromJson(m)).toList();
		} catch (_) {
			final prefs = await SharedPreferences.getInstance();
			final list = prefs.getStringList('favorites') ?? [];
			return list.map((s) => GameModel.fromJson(json.decode(s) as Map<String, dynamic>)).toList();
		}
	}

	Future<void> addFavorite(GameModel game) async {
		if (kIsWeb || _db == null) {
			final prefs = await SharedPreferences.getInstance();
			final list = prefs.getStringList('favorites') ?? [];
			final filtered = list.where((s) {
				final m = json.decode(s) as Map<String, dynamic>;
				return m['id'] != game.id;
			}).toList();
			filtered.add(json.encode(game.toJson()));
			await prefs.setStringList('favorites', filtered);
			return;
		}

		try {
			final db = await _db!.database;
			final row = {
				'id': game.id,
				'name': game.name,
				'background_image': game.backgroundImage,
				'rating': game.rating,
				'released': game.released,
			};
			await db.insert('favorites', row, conflictAlgorithm: ConflictAlgorithm.replace);
		} catch (_) {
			final prefs = await SharedPreferences.getInstance();
			final list = prefs.getStringList('favorites') ?? [];
			final filtered = list.where((s) {
				final m = json.decode(s) as Map<String, dynamic>;
				return m['id'] != game.id;
			}).toList();
			filtered.add(json.encode(game.toJson()));
			await prefs.setStringList('favorites', filtered);
		}
	}

	Future<void> removeFavorite(int id) async {
		if (kIsWeb || _db == null) {
			final prefs = await SharedPreferences.getInstance();
			final list = prefs.getStringList('favorites') ?? [];
			final filtered = list.where((s) {
				final m = json.decode(s) as Map<String, dynamic>;
				return m['id'] != id;
			}).toList();
			await prefs.setStringList('favorites', filtered);
			return;
		}

		try {
			final db = await _db!.database;
			await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
		} catch (_) {
			final prefs = await SharedPreferences.getInstance();
			final list = prefs.getStringList('favorites') ?? [];
			final filtered = list.where((s) {
				final m = json.decode(s) as Map<String, dynamic>;
				return m['id'] != id;
			}).toList();
			await prefs.setStringList('favorites', filtered);
		}
	}

	Future<bool> isFavorite(int id) async {
		if (kIsWeb || _db == null) {
			final prefs = await SharedPreferences.getInstance();
			final list = prefs.getStringList('favorites') ?? [];
			return list.any((s) {
				final m = json.decode(s) as Map<String, dynamic>;
				return m['id'] == id;
			});
		}

		try {
			final db = await _db!.database;
			final result = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
			return result.isNotEmpty;
		} catch (_) {
			final prefs = await SharedPreferences.getInstance();
			final list = prefs.getStringList('favorites') ?? [];
			return list.any((s) {
				final m = json.decode(s) as Map<String, dynamic>;
				return m['id'] == id;
			});
		}
	}
}