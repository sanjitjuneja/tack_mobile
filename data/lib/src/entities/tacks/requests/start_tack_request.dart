part of tacks_entities;

class StartTackRequest extends JsonSerializable {
  final int tackId;

  const StartTackRequest({
    required this.tackId,
  });
}
