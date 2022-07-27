part of 'rate_tack_user_bloc.dart';

class RateTackUserState {
  final Tack tack;
  final TackUser tackUser;
  final CommentData commentData;
  final RateData rateData;

  bool get isReadyToProceed => commentData.isValid && rateData.isValid;

  const RateTackUserState({
    required this.tack,
    required this.tackUser,
    required this.commentData,
    required this.rateData,
  });

  RateTackUserState copyWith({
    String? comment,
    double? rate,
  }) {
    return RateTackUserState(
      tack: tack,
      tackUser: tackUser,
      commentData: comment != null
          ? commentData.copyWith(comment: comment)
          : commentData,
      rateData: rate != null ? rateData.copyWith(rate: rate) : rateData,
    );
  }
}
