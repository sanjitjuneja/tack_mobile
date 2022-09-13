import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/payment.dart';

import '../../../add_edit_tack/ui/add_edit_tack_page.dart';
import '../../models/ongoing_tacker_screen_result.dart';
import '../../view_extensions/ongoing_tack_to_view_extension.dart';
import '../../../rate_tack_user/ui/rate_tack_user_page.dart';

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
    on<ContactRunner>(_onContactRunner);
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
    } catch (_) {}
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
      AddEditTack.editPage(state.tack),
    );

    if (tack != null) emit(state.copyWith(tack: tack));
  }

  Future<void> __onCompleteTack() async {
    try {
      _appRouter.push(ProgressDialog.page());
      await _completeTackUseCase.execute(
        CompleteTackPayload(tack: state.tack),
      );
      _appRouter.pop();

      await _appRouter.pushForResult(
        RateTackUser.page(
          tack: state.tack,
          isRateTacker: false,
        ),
      );

      _appRouter.popWithResult(OngoingTackerScreenResult.complete);
    } catch (e) {
      _appRouter.pop();
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
      _appRouter.push(ProgressDialog.page());
      await _cancelTackUseCase.execute(
        CancelTackPayload(tack: state.tack),
      );
      _appRouter.pop();
      _appRouter.popWithResult(OngoingTackerScreenResult.cancel);
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onContactRunner(
    ContactRunner event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    if (!state.hasContactData) return;

    final String phoneNumber = state.userContacts!.phoneNumber;
    PhoneCallUtility.callNumber(phoneNumber);
  }

  Future<void> _onSelectOffer(
    SelectOffer event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    _appRouter.push(PayForTackFeature.page(offer: event.offer));
  }

  Future<void> _onTackIntentAction(
    TackIntentAction event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    final WebSocketIntent<Tack> intent = event.tackIntent;

    switch (intent.action) {
      case WebSocketAction.create:
        return;
      case WebSocketAction.update:
        if (intent.objectId != state.tack.id) return;

        final Tack newTack = intent.object!;

        if (newTack.canContactOther && !state.hasContactData) {
          add(const FetchUserContactsAction());
        }

        return emit(
          state.copyWith(
            tack:newTack,
            currentStep: newTack.currentStepIndex(isTacker: true),
          ),
        );
      case WebSocketAction.delete:
        return;
    }
  }

  @override
  Future<void> close() async {
    _tackIntentSubscription.cancel();

    return super.close();
  }
}
