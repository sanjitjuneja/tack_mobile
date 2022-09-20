import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:groups/groups.dart';
import 'package:navigation/navigation.dart';

part 'deeplink_event.dart';

part 'deeplink_state.dart';

class DeeplinkBloc extends Bloc<DeeplinkEvent, DeeplinkState> {
  final AppRouterDelegate _appRouter;
  final GetLastDeeplinkUseCase _getLastDeeplinkUseCase;
  final ResetLastDeeplinkUseCase _resetLastDeeplinkUseCase;
  final ObserveDeeplinkUseCase _observeDeeplinkUseCase;
  final FetchGroupInviteUseCase _fetchGroupInviteUseCase;

  late StreamSubscription<DeeplinkIntent?> _deeplinkSubscription;

  DeeplinkBloc({
    required AppRouterDelegate appRouter,
    required GetLastDeeplinkUseCase getLastDeeplinkUseCase,
    required ResetLastDeeplinkUseCase resetLastDeeplinkUseCase,
    required ObserveDeeplinkUseCase observeDeeplinkUseCase,
    required FetchGroupInviteUseCase fetchGroupInviteUseCase,
  })  : _appRouter = appRouter,
        _getLastDeeplinkUseCase = getLastDeeplinkUseCase,
        _resetLastDeeplinkUseCase = resetLastDeeplinkUseCase,
        _observeDeeplinkUseCase = observeDeeplinkUseCase,
        _fetchGroupInviteUseCase = fetchGroupInviteUseCase,
        super(const DeeplinkState()) {
    on<InitialCheck>(_onInitialCheck);
    on<ResetLastDeeplinkAction>(_onResetLastDeeplinkAction);
    on<DeeplinkAction>(_onDeeplinkAction);

    _deeplinkSubscription = _observeDeeplinkUseCase.execute(NoParams()).listen(
      (DeeplinkIntent? event) {
        if (event != null) add(DeeplinkAction(intent: event));
      },
    );
  }

  Future<void> _onInitialCheck(
    InitialCheck event,
    Emitter<DeeplinkState> emit,
  ) async {
    final DeeplinkIntent? intent = _getLastDeeplinkUseCase.execute(NoParams());
    if (intent != null) add(DeeplinkAction(intent: intent));
  }

  Future<void> _onResetLastDeeplinkAction(
    ResetLastDeeplinkAction event,
    Emitter<DeeplinkState> emit,
  ) async {
    _resetLastDeeplinkUseCase.execute(NoParams());
  }

  Future<void> _onDeeplinkAction(
    DeeplinkAction event,
    Emitter<DeeplinkState> emit,
  ) async {
    add(const ResetLastDeeplinkAction());

    switch (event.intent.destination) {
      case DeeplinkDestination.invite:
        __onGroupInvite(
          event.intent,
          emit,
        );
        break;
      default:
        return;
    }
  }

  Future<void> __onGroupInvite(
    DeeplinkIntent intent,
    Emitter<DeeplinkState> emit,
  ) async {
    try {
      _appRouter.pushProgress();
      final GroupInvite groupInvite = await _fetchGroupInviteUseCase.execute(
        FetchGroupInvitePayload(
          uri: intent.link,
        ),
      );
      _appRouter.popProgress();
      final GroupDetailsScreenResult? result;

      if (groupInvite.groupDetails != null) {
        result = await _appRouter.pushForResult(
          GroupDetailsFeature.groupPage(
            groupDetails: groupInvite.groupDetails!,
          ),
        );
      } else {
        result = await _appRouter.pushForResult(
          GroupDetailsFeature.groupInvitationPage(
            invitation: groupInvite.invitation!,
          ),
        );
      }

      __onInviteResult(
        result: result,
        group: groupInvite.groupDetails?.group ?? groupInvite.invitation!.group,
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

  Future<void> __onInviteResult({
    required GroupDetailsScreenResult? result,
    required Group group,
  }) async {
    final TranslationParams translationParams =
        <AlertPropertyKey, Map<String, String>>{
      AlertPropertyKey.message: <String, String>{
        'groupName': group.name,
      },
    };

    switch (result) {
      case GroupDetailsScreenResult.joinGroup:
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.inGroupNow',
              translationParams: translationParams,
            ),
          ),
        );
        break;
      case GroupDetailsScreenResult.declineInvitation:
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.declineGroupInvite',
              translationParams: translationParams,
            ),
          ),
        );
        break;
      case GroupDetailsScreenResult.leaveGroup:
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.noMoreGroupMember',
              translationParams: translationParams,
            ),
          ),
        );
        break;
      default:
        return;
    }
  }

  @override
  Future<void> close() async {
    _deeplinkSubscription.cancel();

    return super.close();
  }
}
