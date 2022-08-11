part of tacks;

class CancelTackPayload extends Equatable {
  final Tack tack;

  const CancelTackPayload({
    required this.tack,
  });

  @override
  List<Object> get props => <Object>[
    tack,
  ];
}
