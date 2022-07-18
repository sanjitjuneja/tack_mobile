part of mappers;

class TackStatusMapper implements Mapper<String, domain.TackStatus> {
  static const String _preparing = 'P';
  static const String _inProgress = 'IP';
  static const String _waitingReview = 'WR';
  static const String _completed = 'F';

  @override
  domain.TackStatus fromEntity(String entity) {
    switch (entity) {
      case _preparing:
        return domain.TackStatus.preparing;
      case _inProgress:
        return domain.TackStatus.inProgress;
      case _waitingReview:
        return domain.TackStatus.waitingReview;
      case _completed:
        return domain.TackStatus.completed;
      default:
        throw Exception('Invalid value');
    }
  }

  @override
  String toEntity(domain.TackStatus item) {
    switch (item) {
      case domain.TackStatus.preparing:
        return _preparing;
      case domain.TackStatus.inProgress:
        return _inProgress;
      case domain.TackStatus.waitingReview:
        return _waitingReview;
      case domain.TackStatus.completed:
        return _completed;
    }
  }
}
