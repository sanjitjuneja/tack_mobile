part of mappers;

class TackStatusMapper implements Mapper<String, domain.TackStatus> {
  static const String _created = 'created';
  static const String _active = 'active';
  static const String _accepted = 'accepted';
  static const String _inProgress = 'in_progress';
  static const String _waitingReview = 'waiting_review';
  static const String _finished = 'finished';

  const TackStatusMapper();

  @override
  domain.TackStatus fromEntity(String entity) {
    switch (entity) {
      case _created:
        return domain.TackStatus.created;
      case _active:
        return domain.TackStatus.pendingAccept;
      case _accepted:
        return domain.TackStatus.pendingStart;
      case _inProgress:
        return domain.TackStatus.inProgress;
      case _waitingReview:
        return domain.TackStatus.pendingReview;
      case _finished:
        return domain.TackStatus.completed;
      default:
        throw Exception('Invalid value');
    }
  }

  @override
  String toEntity(domain.TackStatus item) {
    switch (item) {
      case domain.TackStatus.created:
        return _created;
      case domain.TackStatus.pendingAccept:
        return _active;
      case domain.TackStatus.pendingStart:
        return _accepted;
      case domain.TackStatus.inProgress:
        return _inProgress;
      case domain.TackStatus.pendingReview:
        return _waitingReview;
      case domain.TackStatus.completed:
        return _finished;
    }
  }
}
