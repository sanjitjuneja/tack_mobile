part of tacks_entities;

class GroupTacksRequest extends JsonSerializable {
  final int groupId;
  final Map<String, String>? queryParameters;

  const GroupTacksRequest({
    required this.groupId,
    this.queryParameters,
  });
}
