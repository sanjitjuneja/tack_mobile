part of tacks;

class CreateTackPayload extends Equatable {
  final String title;
  final int price;
  final String description;
  final int estimatedTime;
  final bool shouldAllowCounterOffers;
  final int groupId;

  CreateTackPayload({
    required this.title,
    required double price,
    required this.description,
    required this.estimatedTime,
    required this.shouldAllowCounterOffers,
    required this.groupId,
  }) : price = (price * 100).toInt();

  @override
  List<Object> get props => <Object>[
        title,
        price,
        description,
        estimatedTime,
        shouldAllowCounterOffers,
        groupId,
      ];
}
