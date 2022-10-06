class ParamsRequestModel {
  ParamsRequestModel({
    this.name = '',
    this.offset = 0,
  });

  final String name;
  final int offset;

  ParamsRequestModel copyWith({String? name, int? offset}) =>
      ParamsRequestModel(
        name: name ?? this.name,
        offset: offset ?? this.offset,
      );
}
