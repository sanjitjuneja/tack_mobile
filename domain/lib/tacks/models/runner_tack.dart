part of tacks;

class RunnerTack extends Equatable with IdentifiableMixin, Comparable {
  final int id;
  final Tack tack;
  final Offer? offer;

  bool get isTracking =>
      tack.status != TackStatus.created &&
      tack.status != TackStatus.pendingAccept;

  const RunnerTack({
    required this.id,
    required this.tack,
    required this.offer,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        tack,
        offer,
      ];

  @override
  int get itemId => id;

  @override
  int compareTo(covariant RunnerTack other) {
    return tack.compareTo(other.tack);
  }

  external int compare();
}
