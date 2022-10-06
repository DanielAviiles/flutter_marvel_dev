import 'package:json_annotation/json_annotation.dart';
part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  CharacterModel({
    required this.id,
    required this.nameHero,
    this.descriptionHero,
    this.dateModified,
    this.collectionComics,
    required this.imgsUrl,
  });

  @JsonKey()
  final int id;

  @JsonKey(name: 'name')
  final String nameHero;

  @JsonKey(name: 'description')
  final String? descriptionHero;

  @JsonKey(name: 'images')
  final String imgsUrl;

  @JsonKey(name: 'modified')
  final DateTime? dateModified;

  @JsonKey(name: 'comics')
  final Map<String, dynamic>? collectionComics;

  CharacterModel copyWith({
    int? id,
    String? nameHero,
    String? descriptionHero,
    DateTime? dateModified,
    Map<String, dynamic>? collectionComics,
    String? imgsUrl,
  }) =>
      CharacterModel(
        id: id ?? this.id,
        nameHero: nameHero ?? this.nameHero,
        descriptionHero: descriptionHero ?? this.descriptionHero,
        dateModified: dateModified ?? this.dateModified,
        collectionComics: collectionComics ?? this.collectionComics,
        imgsUrl: imgsUrl ?? this.imgsUrl,
      );

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}
