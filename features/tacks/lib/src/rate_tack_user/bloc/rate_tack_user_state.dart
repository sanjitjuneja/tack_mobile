part of 'rate_tack_user_bloc.dart';

class RateTackUserState {
  final Tack tack;
  final bool isRateTacker;
  final CommentData commentData;
  final RateData rateData;

  bool get isReadyToProceed => commentData.isValid && rateData.isValid;

  TackUser? get userToRate => isRateTacker ? tack.tacker : tack.runner;

  const RateTackUserState({
    required this.tack,
    required this.isRateTacker,
    required this.commentData,
    required this.rateData,
  });

  RateTackUserState copyWith({
    String? comment,
    double? rate,
  }) {
    return RateTackUserState(
      tack: tack,
      isRateTacker: isRateTacker,
      commentData: comment != null
          ? commentData.copyWith(comment: comment)
          : commentData,
      rateData: rate != null ? rateData.copyWith(rate: rate) : rateData,
    );
  }
}
