part of tacks_entities;

class CompleteTackRequest extends JsonSerializable {
  final int tackId;

  const CompleteTackRequest({
    required this.tackId,
  });
}
