part of tacks;

enum TackStatus with Comparable {
  created(1),
  pendingAccept(2),
  pendingStart(3),
  inProgress(4),
  pendingReview(5),
  completed(6);

  final int stageNumber;

  const TackStatus(this.stageNumber);

  operator >(TackStatus otherStatus) {
    return stageNumber > otherStatus.stageNumber;
  }

  operator <(TackStatus otherStatus) {
    return stageNumber < otherStatus.stageNumber;
  }

  @override
  int compareTo(covariant TackStatus other) {
    return -stageNumber.compareTo(other.stageNumber);
  }
}
