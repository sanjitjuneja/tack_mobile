part of 'rate_tack_user_bloc.dart';

abstract class RateTackUserEvent {
  const RateTackUserEvent();
}

class RatingChange extends RateTackUserEvent {
  final double rating;

  const RatingChange(this.rating);
}

class CommentChange extends RateTackUserEvent {
  final String comment;

  const CommentChange(
    this.comment,
  );
}

class SendRating extends RateTackUserEvent {
  const SendRating();
}
