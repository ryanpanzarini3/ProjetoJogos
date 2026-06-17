class GameEntity {
  final int id;
  final String name;
  final String? backgroundImage;
  final double? rating;
  final String? released;
  final List<String>? genres;

  const GameEntity({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.rating,
    this.released,
    this.genres,
  });
}