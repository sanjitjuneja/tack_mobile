import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:groups/groups.dart';
import 'package:navigation/navigation.dart';

import '../models/counter_offer_option_data.dart';
import '../models/description_data.dart';
import '../models/group_data.dart';
import '../models/price_data.dart';
import '../models/time_estimation_data.dart';
import '../models/title_data.dart';

part 'add_edit_tack_event.dart';

part 'add_edit_tack_state.dart';

class AddEditTackBloc extends Bloc<AddEditTackEvent, AddEditTackState> {
  final AppRouterDelegate _appRouter;
  final CreateTackUseCase _createTackUseCase;
  final EditTackUseCase _editTackUseCase;

  AddEditTackBloc({
    required TemplateTack? templateTack,
    required Tack? tack,
    required bool isAdd,
    required AppRouterDelegate appRouter,
    required GetCurrentGroupUseCase getCurrentGroupUseCase,
    required CreateTackUseCase createTackUseCase,
    required EditTackUseCase editTackUseCase,
  })  : _appRouter = appRouter,
        _createTackUseCase = createTackUseCase,
        _editTackUseCase = editTackUseCase,
        super(
          AddEditTackState.fromTack(
            getCurrentGroupUseCase.execute(NoParams()),
            templateTack,
            tack,
            isAdd,
          ),
        ) {
    on<CreateTackRequest>(_onCreateTackRequest);
    on<EditTackRequest>(_onEditTackRequest);

    on<ClearAction>(_onClearAction);

    on<GroupChange>(_onGroupChange);
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
    if (!state.isReadyToProceed) {
      return emit(state.copyWith(isValidationEnabled: true));
    }

    try {
      _appRouter.pushProgress();
      final Tack newTack = await _createTackUseCase.execute(
        CreateTackPayload(
          title: state.titleData.title,
          price: state.priceData.parsedPrice,
          description: state.descriptionData.description,
          estimatedTime: state.timeEstimationData.timeInSeconds,
          shouldAllowCounterOffers: state.counterOfferData.allow,
          groupId: state.groupData.group!.id,
        ),
      );
      _appRouter.popProgress();
      _appRouter.popWithResult(newTack);
    } catch (e) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
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
    if (!state.isReadyToProceed) {
      return emit(state.copyWith(isValidationEnabled: true));
    } else if (!state.isAnyDataChanged) {
      return _appRouter.popWithResult(null);
    }

    try {
      _appRouter.pushProgress();
      final Tack newTack = await _editTackUseCase.execute(
        UpdateTackPayload(
          tackId: state.tack!.id,
          title: state.titleData.title,
          price: state.priceData.parsedPrice,
          description: state.descriptionData.description,
          estimatedTime: state.timeEstimationData.timeInSeconds,
          shouldAllowCounterOffers: state.counterOfferData.allow,
          groupId: state.groupData.group!.id,
        ),
      );
      _appRouter.popProgress();
      _appRouter.popWithResult(newTack);
    } catch (e) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
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

  Future<void> _onGroupChange(
    GroupChange event,
    Emitter<AddEditTackState> emit,
  ) async {
    final Group? group = await _appRouter.pushForResult(
      PickGroupFeature.page(state.groupData.group),
    );

    if (group != null) emit(state.copyWith(group: group));
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
