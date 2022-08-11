part of tacks_entities;

class CancelTackRequest extends JsonSerializable {
  final int tackId;

  const CancelTackRequest({
    required this.tackId,
  });
}
