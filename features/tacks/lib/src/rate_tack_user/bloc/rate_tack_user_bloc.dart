import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/rate_tack_user/models/comment_data.dart';
import 'package:tacks/src/rate_tack_user/models/rate_data.dart';

part 'rate_tack_user_event.dart';

part 'rate_tack_user_state.dart';

class RateTackUserBloc extends Bloc<RateTackUserEvent, RateTackUserState> {
  // max words for comment.
  static const int _commentMaxWordsLength = 100;
  // minimal rating for send
  static const int _rateMinimalValue = 0;
  // maximal rating for send
  static const int _rateMaximalValue = 5;

  final AppRouterDelegate _appRouter;
  final RateTackUseCase _rateTackUseCase;

  RateTackUserBloc({
    required Tack tack,
    required TackUser tackUser,
    required AppRouterDelegate appRouter,
    required RateTackUseCase rateTackUseCase,
  })  : _appRouter = appRouter,
        _rateTackUseCase = rateTackUseCase,
        super(
          RateTackUserState(
            tack: tack,
            tackUser: tackUser,
            commentData: const CommentData(
              maxWords: _commentMaxWordsLength,
              isRequired: true,
            ),
            rateData: const RateData(
              minRate: _rateMinimalValue,
              maxRate: _rateMaximalValue,
              isRequired: true,
            ),
          ),
        ) {
    on<RatingChange>(_onRatingChange);
    on<CommentChange>(_onCommentChange);
    on<SendRating>(_onSendRating);
  }

  Future<void> _onRatingChange(
    RatingChange event,
    Emitter<RateTackUserState> emit,
  ) async {
    emit(state.copyWith(rate: event.rating));
  }

  Future<void> _onCommentChange(
    CommentChange event,
    Emitter<RateTackUserState> emit,
  ) async {
    emit(state.copyWith(comment: event.comment));
  }

  Future<void> _onSendRating(
    SendRating event,
    Emitter<RateTackUserState> emit,
  ) async {
    _appRouter.push(ProgressDialog.page());
    try {
      await _rateTackUseCase.execute(
        RateTackPayload(
          tackId: state.tack.id,
          comment: state.commentData.comment,
          rating: state.rateData.rate.toInt(),
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(true);
    } catch (e) {
      _appRouter.replace(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.rateTack',
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }
}
