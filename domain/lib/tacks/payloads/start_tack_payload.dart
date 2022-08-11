part of tacks;

class StartTackPayload extends Equatable {
  final Tack tack;

  const StartTackPayload({
    required this.tack,
  });

  @override
  List<Object> get props => <Object>[
    tack,
  ];
}
