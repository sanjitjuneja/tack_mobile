part of tacks;

class CompleteTackPayload extends Equatable {
  final Tack tack;

  const CompleteTackPayload({
    required this.tack,
  });

  @override
  List<Object> get props => <Object>[
    tack,
  ];
}
