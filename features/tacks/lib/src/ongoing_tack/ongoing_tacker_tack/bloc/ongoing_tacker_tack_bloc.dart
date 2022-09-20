import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/payment.dart';

import '../../../add_edit_tack/ui/add_edit_tack_page.dart';
import '../../view_extensions/ongoing_tack_to_view_extension.dart';
import '../../../rate_tack_user/ui/rate_tack_user_page.dart';
import '../ui/ongoing_tacker_tack_page.dart';

part 'ongoing_tacker_tack_event.dart';

part 'ongoing_tacker_tack_state.dart';

class OngoingTackerTackBloc
    extends Bloc<OngoingTackerTackEvent, OngoingTackerTackState> {
  final AppRouterDelegate _appRouter;
  final ObserveTackerTackIntentUseCase _observeTackerTackIntentUseCase;
  final FetchUserContactsUseCase _fetchUserContactsUseCase;
  final CancelTackTackerUseCase _cancelTackUseCase;
  final CompleteTackTackerUseCase _completeTackUseCase;

  late StreamSubscription<WebSocketIntent<Tack>> _tackIntentSubscription;

  OngoingTackerTackBloc({
    required Tack tack,
    required AppRouterDelegate appRouter,
    required ObserveTackerTackIntentUseCase observeTackerTackIntentUseCase,
    required FetchUserContactsUseCase fetchUserContactsUseCase,
    required CancelTackTackerUseCase cancelTackTackerUseCase,
    required CompleteTackTackerUseCase completeTackUseCase,
  })  : _appRouter = appRouter,
        _observeTackerTackIntentUseCase = observeTackerTackIntentUseCase,
        _fetchUserContactsUseCase = fetchUserContactsUseCase,
        _cancelTackUseCase = cancelTackTackerUseCase,
        _completeTackUseCase = completeTackUseCase,
        super(
          OngoingTackerTackState(
            tack: tack,
            stepsCount:
                OngoingTackToStepIndexViewExtension.tackerTackStepsCount,
            currentStep: tack.currentStepIndex(isTacker: true),
          ),
        ) {
    on<FetchUserContactsAction>(_onFetchUserContactsAction);

    on<ActionPressed>(_onActionPressed);
    on<CancelTack>(_onCancelTack);
    on<MessageRunner>(_onMessageRunner);
    on<CallRunner>(_onCallRunner);
    on<SelectOffer>(_onSelectOffer);

    on<TackIntentAction>(_onTackIntentAction);

    _tackIntentSubscription = _observeTackerTackIntentUseCase
        .execute(NoParams())
        .listen((WebSocketIntent<Tack> tackIntent) {
      add(TackIntentAction(tackIntent: tackIntent));
    });

    if (tack.canContactOther) {
      add(const FetchUserContactsAction());
    }
  }

  Future<void> _onFetchUserContactsAction(
    FetchUserContactsAction event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    try {
      emit(state.copyWith(isContactsLoading: true));
      final UserContacts userContacts = await _fetchUserContactsUseCase.execute(
        FetchUserContactsPayload(
          tackId: state.tack.id,
        ),
      );
      emit(
        state.copyWith(
          userContacts: userContacts,
        ),
      );
    } catch (_) {
    } finally {
      emit(state.copyWith(isContactsLoading: false));
    }
  }

  Future<void> _onActionPressed(
    ActionPressed event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    switch (state.tack.status) {
      case TackStatus.created:
        return __onEditTack(emit);
      case TackStatus.pendingReview:
        return __onCompleteTack();
      default:
        break;
    }
  }

  Future<void> __onEditTack(Emitter<OngoingTackerTackState> emit) async {
    final Tack? tack = await _appRouter.pushForResult(
      AddEditTackFeature.editPage(state.tack),
    );

    if (tack != null) emit(state.copyWith(tack: tack));
  }

  Future<void> __onCompleteTack() async {
    try {
      _appRouter.pushProgress();
      await _completeTackUseCase.execute(
        CompleteTackPayload(tack: state.tack),
      );
      _appRouter.popProgress();
      _appRouter.removeNamed(
        OngoingTackerTackFeature.routeName(
          id: state.tack.id,
        ),
      );

      await _appRouter.pushForResult(
        RateTackUser.page(
          tack: state.tack,
          isRateTacker: false,
        ),
      );

      _appRouter.pushForResult(
        AppAlertDialog.page(
          SuccessAlert(
            contentKey: 'otherAlert.tackerTackCompleted',
          ),
        ),
      );
    } catch (e) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onCancelTack(
    CancelTack event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    final bool result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.cancelTackTacker',
          translationParams: <AlertPropertyKey, Map<String, String>>{
            AlertPropertyKey.message: {
              'tackName': state.tack.title,
            },
          },
        ),
      ),
    );

    if (!result) return;

    try {
      _appRouter.pushProgress();
      await _cancelTackUseCase.execute(
        CancelTackPayload(tack: state.tack),
      );
      _appRouter.popProgress();
      _appRouter.removeNamed(
        OngoingTackerTackFeature.routeName(
          id: state.tack.id,
        ),
      );
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.tackCancel',
          ),
        ),
      );
    } catch (e) {
      _appRouter.popProgress();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onMessageRunner(
    MessageRunner event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    if (!state.hasContactData) return;

    final String phoneNumber = state.userContacts!.phoneNumber;
    PhoneUtility.sendSMS(phoneNumber);
  }

  Future<void> _onCallRunner(
    CallRunner event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    if (!state.hasContactData) return;

    final String phoneNumber = state.userContacts!.phoneNumber;
    PhoneUtility.callNumber(phoneNumber);
  }

  Future<void> _onSelectOffer(
    SelectOffer event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    _appRouter.push(
      PayForTackFeature.page(
        offer: event.offer,
        tackPrice: state.tack.price,
      ),
    );
  }

  Future<void> _onTackIntentAction(
    TackIntentAction event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    final WebSocketIntent<Tack> intent = event.tackIntent;

    if (intent.objectId != state.tack.id) return;

    switch (intent.action) {
      case WebSocketAction.create:
        return;
      case WebSocketAction.update:
        final Tack newTack = intent.object!;

        if (newTack.canContactOther && !state.hasContactData) {
          add(const FetchUserContactsAction());
        }

        return emit(
          state.copyWith(
            tack: newTack,
            currentStep: newTack.currentStepIndex(isTacker: true),
          ),
        );
      case WebSocketAction.delete:
        return _appRouter.removeNamed(
          OngoingTackerTackFeature.routeName(
            id: state.tack.id,
          ),
        );
    }
  }

  @override
  Future<void> close() async {
    _tackIntentSubscription.cancel();

    return super.close();
  }
}
