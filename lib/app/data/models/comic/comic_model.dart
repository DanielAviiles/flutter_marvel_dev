import 'package:json_annotation/json_annotation.dart';
part 'comic_model.g.dart';

@JsonSerializable()
class ComicModel {
  ComicModel({
    required this.id,
    required this.titleComic,
    this.dateModified,
    this.descriptionComic,
    this.resourceUri,
  });

  @JsonKey()
  final int id;

  @JsonKey()
  final String titleComic;

  @JsonKey()
  final String? descriptionComic;

  @JsonKey()
  final DateTime? dateModified;

  @JsonKey()
  final String? resourceUri;

  ComicModel copyWith({
    int? id,
    String? titleComic,
    DateTime? dateModified,
    String? descriptionComic,
    String? resourceUri,
  }) =>
      ComicModel(
        id: id ?? this.id,
        titleComic: titleComic ?? this.titleComic,
        dateModified: dateModified ?? this.dateModified,
        descriptionComic: descriptionComic ?? this.descriptionComic,
        resourceUri: resourceUri ?? this.resourceUri,
      );

  factory ComicModel.fromJson(Map<String, dynamic> json) =>
      _$ComicModelFromJson(json);
  Map<String, dynamic> toJson() => _$ComicModelToJson(this);
}
