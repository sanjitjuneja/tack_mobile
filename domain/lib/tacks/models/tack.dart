part of tacks;

class Tack extends Equatable with IdentifiableMixin, Comparable {
  final int id;
  final String title;
  final double price;
  final String description;
  final Duration? estimatedTime;
  final bool allowCounterOffers;
  final TackStatus status;
  final bool isCanceled;
  final TackUser tacker;
  final TackUser? runner;
  final Group group;
  final String? completionMessage;
  final DateTime? completionTime;

  bool get canTackerCancel => status < TackStatus.pendingStart;

  bool get canRunnerCancel => status < TackStatus.pendingReview;

  bool get isChooseRunnerStage => status == TackStatus.pendingAccept;

  bool get canContactOther => status > TackStatus.pendingAccept;

  const Tack({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.estimatedTime,
    required this.allowCounterOffers,
    required this.status,
    required this.isCanceled,
    required this.tacker,
    required this.runner,
    required this.group,
    required this.completionMessage,
    required this.completionTime,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        price,
        description,
        estimatedTime,
        allowCounterOffers,
        status,
        isCanceled,
        tacker,
        runner,
        group,
        completionMessage,
        completionTime,
      ];

  @override
  int get itemId => id;

  @override
  int compareTo(covariant Tack other) {
    return status.compareTo(other.status);
  }
}
