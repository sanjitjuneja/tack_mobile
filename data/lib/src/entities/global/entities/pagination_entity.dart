part of global_entities;

@JsonSerializable(createToJson: false)
@GenericConverter()
class PaginationEntity<T> extends JsonSerializable {
  final int count;
  final Uri? previous;
  final Uri? next;
  final List<T> results;

  const PaginationEntity({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory PaginationEntity.fromJson(Map<String, dynamic> json) {
    return _$PaginationEntityFromJson(json);
  }
}
