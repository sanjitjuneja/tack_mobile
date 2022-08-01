import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/add_edit_tack/models/counter_offer_option_data.dart';
import 'package:tacks/src/add_edit_tack/models/description_data.dart';
import 'package:tacks/src/add_edit_tack/models/price_data.dart';
import 'package:tacks/src/add_edit_tack/models/time_estimation_data.dart';
import 'package:tacks/src/add_edit_tack/models/title_data.dart';

part 'add_edit_tack_event.dart';

part 'add_edit_tack_state.dart';

class AddEditTackBloc extends Bloc<AddEditTackEvent, AddEditTackState> {
  final AppRouterDelegate _appRouter;
  final EditTackUseCase _editTackUseCase;

  AddEditTackBloc({
    required Tack? tack,
    required bool isAdd,
    required AppRouterDelegate appRouter,
    required EditTackUseCase editTackUseCase,
  })  : _appRouter = appRouter,
        _editTackUseCase = editTackUseCase,
        super(
          AddEditTackState.fromTack(tack, isAdd),
        ) {
    on<CreateTackRequest>(_onCreateTackRequest);
    on<EditTackRequest>(_onEditTackRequest);
    on<ClearAction>(_onClearAction);
    on<TitleChange>(_onTitleChange);
    on<PriceChange>(_onPriceChange);
    on<DescriptionChange>(_onDescriptionChange);
    on<TimeEstimationChange>(_onTimeEstimationChange);
    on<TimeEstimationInChange>(_onTimeEstimationInChange);
    on<CounterOfferOptionChange>(_onCounterOfferOptionChange);
  }

  Future<void> _onCreateTackRequest(
    CreateTackRequest event,
    Emitter<AddEditTackState> emit,
  ) async {
    _appRouter.push(ProgressDialog.page());
    try {
      // TODO: add creation tack API call.
      _appRouter.pop();
      _appRouter.popWithResult(true);
    } catch (e) {
      _appRouter.replace(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.tackCreate',
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onEditTackRequest(
    EditTackRequest event,
    Emitter<AddEditTackState> emit,
  ) async {
    _appRouter.push(ProgressDialog.page());
    try {
      await _editTackUseCase.execute(
        UpdateTackPayload(
          tackId: state.tack!.id,
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

  Future<void> _onClearAction(
    ClearAction event,
    Emitter<AddEditTackState> emit,
  ) async {
    emit(state.clear());
  }

  Future<void> _onTitleChange(
    TitleChange event,
    Emitter<AddEditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        title: event.title,
      ),
    );
  }

  Future<void> _onPriceChange(
    PriceChange event,
    Emitter<AddEditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        price: event.price,
      ),
    );
  }

  Future<void> _onDescriptionChange(
    DescriptionChange event,
    Emitter<AddEditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        description: event.description,
      ),
    );
  }

  Future<void> _onTimeEstimationChange(
    TimeEstimationChange event,
    Emitter<AddEditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        timeEstimation: event.timeEstimation,
      ),
    );
  }

  Future<void> _onTimeEstimationInChange(
    TimeEstimationInChange event,
    Emitter<AddEditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        timeEstimationIn: event.estimationIn,
      ),
    );
  }

  Future<void> _onCounterOfferOptionChange(
    CounterOfferOptionChange event,
    Emitter<AddEditTackState> emit,
  ) async {
    emit(
      state.copyWith(
        allowCounterOffer: event.allowCounterOffer,
      ),
    );
  }
}
