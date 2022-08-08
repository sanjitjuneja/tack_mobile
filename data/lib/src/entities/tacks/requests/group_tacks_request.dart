part of tacks_entities;

class GroupTacksRequest extends JsonSerializable {
  final int groupId;

  const GroupTacksRequest({
    required this.groupId,
  });
}
