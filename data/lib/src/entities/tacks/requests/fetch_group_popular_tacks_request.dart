part of tacks_entities;

class FetchGroupPopularTacksRequest extends JsonSerializable {
  final int groupId;

  const FetchGroupPopularTacksRequest({
    required this.groupId,
  });
}
