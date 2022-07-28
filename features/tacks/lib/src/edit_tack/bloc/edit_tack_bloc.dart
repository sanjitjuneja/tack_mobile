import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/edit_tack/models/counter_offer_option_data.dart';
import 'package:tacks/src/edit_tack/models/description_data.dart';
import 'package:tacks/src/edit_tack/models/price_data.dart';
import 'package:tacks/src/edit_tack/models/time_estimation_data.dart';
import 'package:tacks/src/edit_tack/models/title_data.dart';

part 'edit_tack_event.dart';

part 'edit_tack_state.dart';

class EditTackBloc extends Bloc<EditTackEvent, EditTackState> {
  final AppRouterDelegate _appRouter;
  final EditTackUseCase _editTackUseCase;

  EditTackBloc({
    required Tack tack,
    required AppRouterDelegate appRouter,
    required EditTackUseCase editTackUseCase,
  })  : _appRouter = appRouter,
        _editTackUseCase = editTackUseCase,
        super(
          EditTackState.fromTack(tack),
        ) {
    on<EditTackRequest>(_onEditTackRequest);
    on<TitleChange>(_onTitleChange);
    on<PriceChange>(_onPriceChange);
    on<DescriptionChange>(_onDescriptionChange);
    on<TimeEstimationChange>(_onTimeEstimationChange);
    on<TimeEstimationInChange>(_onTimeEstimationInChange);
    on<CounterOfferOptionChange>(_onCounterOfferOptionChange);
  }

  Future<void> _onEditTackRequest(
    EditTackRequest event,
    Emitter<EditTackState> emit,
  ) async {
    _appRouter.push(ProgressDialog.page());
    try {
      await _editTackUseCase.execute(
        UpdateTackPayload(
          tackId: state.tack.id,
          title: state.titleData.title,
          price: state.priceData.parsedPrice,
          description: state.descriptionData.description,
          estimatedTime: state.timeEstimationData.timeInSeconds!,
          shouldAllowCounterOffers: state.counterOfferData.allow,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(true);
    } catch (e) {
      _appRouter.replace(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.tackUpdate',
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onTitleChange(
    TitleChange event,
    Emitter<EditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        title: event.title,
      ),
    );
  }

  Future<void> _onPriceChange(
    PriceChange event,
    Emitter<EditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        price: event.price,
      ),
    );
  }

  Future<void> _onDescriptionChange(
    DescriptionChange event,
    Emitter<EditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        description: event.description,
      ),
    );
  }

  Future<void> _onTimeEstimationChange(
    TimeEstimationChange event,
    Emitter<EditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        timeEstimation: event.timeEstimation,
      ),
    );
  }

  Future<void> _onTimeEstimationInChange(
    TimeEstimationInChange event,
    Emitter<EditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        timeEstimationIn: event.estimationIn,
      ),
    );
  }

  Future<void> _onCounterOfferOptionChange(
    CounterOfferOptionChange event,
    Emitter<EditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        allowCounterOffer: event.allowCounterOffer,
      ),
    );
  }
}
