part of tacks_entities;

class GroupPopularTacksRequest extends JsonSerializable {
  final int groupId;

  const GroupPopularTacksRequest({
    required this.groupId,
  });
}
