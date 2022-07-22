import 'package:domain/domain.dart';

extension OngoingTackToViewExtension on TackStatus {
  String getTitle({required bool isTacker}) {
    return _fieldValue(isTacker, field: 'title');
  }

  String getSubTitle({required bool isTacker}) {
    return _fieldValue(isTacker, field: 'subtitle');
  }

  String getButtonLabel({required bool isTacker}) {
    return _fieldValue(isTacker, field: 'button');
  }

  String getNoteText({required bool isTacker}) {
    return _fieldValue(isTacker, field: 'note');
  }

  String _fieldValue(bool isTacker, {required String field}) {
    final String basicPath;
    if (isTacker) {
      basicPath = 'ongoingTackScreen.tacker';
    } else {
      basicPath = 'ongoingTackScreen.runner';
    }

    return <String>[basicPath, name, field].join('.');
  }
}

extension OngoingTackToStepIndexViewExtension on Tack {
  static const int tackerTackStepsCount = 5;
  static const int runnerTackStepsCount = 3;

  int currentStepIndex({required bool isTacker}) {
    if (isTacker) return _mapTackerTack(this);

    return _mapRunnerTack(this);
  }

  static int _mapTackerTack(Tack tack) {
    switch (tack.status) {
      case TackStatus.created:
        return 1;
      case TackStatus.pendingAccept:
        return 2;
      case TackStatus.pendingStart:
        return 3;
      case TackStatus.inProgress:
        return 4;
      case TackStatus.pendingReview:
        return 5;
      case TackStatus.completed:
        return 6;
    }
  }

  static int _mapRunnerTack(Tack tack) {
    switch (tack.status) {
      case TackStatus.created:
        return 0;
      case TackStatus.pendingAccept:
        return 1;
      case TackStatus.pendingStart:
        return 1;
      case TackStatus.inProgress:
        return 2;
      case TackStatus.pendingReview:
        return 3;
      case TackStatus.completed:
        return 4;
    }
  }
}

extension OngoingTackOfferToViewExtension on OfferType {
  String get title {
    return 'ongoingTackScreen.tacker.offer.$name';
  }
}
