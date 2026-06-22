import 'package:catalog_jogos/features/games/data/models/game_model.dart';
import 'package:catalog_jogos/features/games/data/sources/game_remote_datasource.dart';
import 'package:catalog_jogos/features/games/data/models/genre_model.dart';

class GameMockDataSource implements GameRemoteDataSource {
  final List<GameModel> _mockGames = [
    GameModel(
      id: 1,
      name: "Cyberpunk 2077",
      backgroundImage: "https://images.unsplash.com/photo-1605899435973-ca2d1a8861cf?auto=format&fit=crop&q=80&w=1000",
      rating: 4.8,
      released: "2020-12-10",
      genres: [const GenreModel(id: 1, name: "RPG"), const GenreModel(id: 2, name: "Action")],
    ),
    GameModel(
      id: 2,
      name: "The Legend of Zelda",
      backgroundImage: "https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=1000",
      rating: 4.9,
      released: "2017-03-03",
      genres: [const GenreModel(id: 3, name: "Adventure")],
    ),
    GameModel(
      id: 3,
      name: "Elden Ring",
      backgroundImage: "https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&q=80&w=1000",
      rating: 4.9,
      released: "2022-02-25",
      genres: [const GenreModel(id: 1, name: "RPG")],
    ),
    GameModel(
      id: 4,
      name: "God of War Ragnarök",
      backgroundImage: "https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=1000",
      rating: 4.9,
      released: "2022-11-09",
      genres: [const GenreModel(id: 2, name: "Action")],
    ),
  ];

  @override
  Future<List<GameModel>> getGames({String? search}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (search != null && search.isNotEmpty) {
      return _mockGames
          .where((g) => g.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    return _mockGames;
  }

  @override
  Future<GameModel> getGameDetails(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockGames.firstWhere((g) => g.id == id);
  }
}
