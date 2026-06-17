import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/game_entity.dart';
import 'genre_model.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel {
  final int id;
  final String name;

  @JsonKey(name: 'background_image')
  final String? backgroundImage;

  final double? rating;
  final String? released;
  final List<GenreModel>? genres;

  const GameModel({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.rating,
    this.released,
    this.genres,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameModelToJson(this);

  GameEntity toEntity() {
    return GameEntity(
      id: id,
      name: name,
      backgroundImage: backgroundImage,
      rating: rating,
      released: released,
      genres: genres?.map((g) => g.name).toList(),
    );
  }
}
