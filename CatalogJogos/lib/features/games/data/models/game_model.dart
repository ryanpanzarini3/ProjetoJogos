import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel {
  final int id;
  final String name;
  final String? backgroundImage;
  final double? rating;

  const GameModel({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.rating,
  });

  factory GameModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GameModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GameModelToJson(this);
}