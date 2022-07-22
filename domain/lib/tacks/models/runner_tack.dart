part of tacks;

class RunnerTack extends Equatable {
  final Tack tack;
  final Offer? offer;

  bool get isTracking =>
      tack.status != TackStatus.created &&
      tack.status != TackStatus.pendingAccept;

  const RunnerTack({
    required this.tack,
    required this.offer,
  });

  @override
  List<Object?> get props => <Object?>[
        tack,
        offer,
      ];
}
