import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';

import '../../group_details/models/group_details_screen_result.dart';
import '../../group_details/ui/group_details_page.dart';

part 'invitations_event.dart';

part 'invitations_state.dart';

class InvitationsBloc extends Bloc<InvitationsEvent, InvitationsState> {
  final AppRouterDelegate _appRouter;
  final FetchGroupInvitationsUseCase _fetchGroupInvitationsUseCase;
  final AcceptGroupInvitationUseCase _acceptGroupInvitationUseCase;
  final ObserveGroupInvitationIntentUseCase
      _observeGroupInvitationIntentUseCase;

  late StreamSubscription<WebSocketIntent<GroupInvitation>>
      _groupInvitationIntentSubscription;

  InvitationsBloc({
    required AppRouterDelegate appRouter,
    required FetchGroupInvitationsUseCase fetchGroupInvitationsUseCase,
    required AcceptGroupInvitationUseCase acceptGroupInvitationUseCase,
    required ObserveGroupInvitationIntentUseCase
        observeGroupInvitationIntentUseCase,
  })  : _appRouter = appRouter,
        _fetchGroupInvitationsUseCase = fetchGroupInvitationsUseCase,
        _acceptGroupInvitationUseCase = acceptGroupInvitationUseCase,
        _observeGroupInvitationIntentUseCase =
            observeGroupInvitationIntentUseCase,
        super(
          InvitationsState(
            isLoading: true,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    on<InvitationIntentAction>(_onInvitationIntentAction);

    on<OpenInvitationDetails>(_onOpenInvitationDetails);
    on<JoinGroup>(_onJoinGroup);

    _groupInvitationIntentSubscription = _observeGroupInvitationIntentUseCase
        .execute(NoParams())
        .listen((WebSocketIntent<GroupInvitation> invitationIntent) {
      add(InvitationIntentAction(invitationIntent: invitationIntent));
    });

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<InvitationsState> emit,
  ) async {
    add(const RefreshAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<InvitationsState> emit,
  ) async {
    try {
      final PaginationModel<GroupInvitation> invitationsData =
          await _fetchGroupInvitationsUseCase.execute(
        const FetchGroupInvitationsPayload(),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          invitationsData: invitationsData,
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            invitationsData: PaginationModel.empty(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<InvitationsState> emit,
  ) async {
    try {
      final PaginationModel<GroupInvitation> invitationsData =
          await _fetchGroupInvitationsUseCase.execute(
        FetchGroupInvitationsPayload(
          lastObjectId: state.invitationsData.results.lastOrNull?.id,
          nextPage: state.invitationsData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          invitationsData: state.invitationsData.more(
            newPage: invitationsData,
          ),
        ),
      );
    } catch (_) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onInvitationIntentAction(
    InvitationIntentAction event,
    Emitter<InvitationsState> emit,
  ) async {
    final WebSocketIntent<GroupInvitation> intent = event.invitationIntent;

    final PaginationModel<GroupInvitation> invitationsData;

    switch (intent.action) {
      case WebSocketAction.create:
        invitationsData = state.invitationsData.addItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.update:
        invitationsData = state.invitationsData.updateItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.delete:
        invitationsData = state.invitationsData.removeItem(
          itemId: intent.objectId,
        );
        break;
    }

    emit(
      state.copyWith(invitationsData: invitationsData),
    );
  }

  Future<void> _onOpenInvitationDetails(
    OpenInvitationDetails event,
    Emitter<InvitationsState> emit,
  ) async {
    final GroupDetailsScreenResult? result = await _appRouter.pushForResult(
      GroupDetailsFeature.groupInvitationPage(invitation: event.invitation),
    );

    __onResult(
      result: result,
      groupName: event.invitation.group.name,
    );
  }

  Future<void> _onJoinGroup(
    JoinGroup event,
    Emitter<InvitationsState> emit,
  ) async {
    _appRouter.push(ProgressDialog.page());
    try {
      await _acceptGroupInvitationUseCase.execute(
        AcceptGroupInvitationPayload(
          invitation: event.invitation,
        ),
      );
      _appRouter.pop();
      __onResult(
        result: GroupDetailsScreenResult.joinGroup,
        groupName: event.invitation.group.name,
      );
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

  Future<void> __onResult({
    required GroupDetailsScreenResult? result,
    required String groupName,
  }) async {
    final TranslationParams translationParams =
        <AlertPropertyKey, Map<String, String>>{
      AlertPropertyKey.message: <String, String>{
        'groupName': groupName,
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
      default:
        return;
    }
  }

  @override
  Future<void> close() async {
    _groupInvitationIntentSubscription.cancel();

    return super.close();
  }
}
