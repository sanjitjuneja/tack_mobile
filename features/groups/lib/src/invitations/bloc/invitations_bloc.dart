import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:groups/src/group_details/models/group_details_screen_result.dart';
import 'package:groups/src/group_details/ui/group_details_page.dart';
import 'package:navigation/navigation.dart';

part 'invitations_event.dart';

part 'invitations_state.dart';

class InvitationsBloc extends Bloc<InvitationsEvent, InvitationsState> {
  final AppRouterDelegate _appRouter;
  final LoadGroupInvitationsUseCase _loadGroupInvitationsUseCase;
  final AcceptGroupInvitationUseCase _acceptGroupInvitationUseCase;

  InvitationsBloc({
    required AppRouterDelegate appRouter,
    required LoadGroupInvitationsUseCase loadGroupInvitationsUseCase,
    required AcceptGroupInvitationUseCase acceptGroupInvitationUseCase,
  })  : _appRouter = appRouter,
        _loadGroupInvitationsUseCase = loadGroupInvitationsUseCase,
        _acceptGroupInvitationUseCase = acceptGroupInvitationUseCase,
        super(
          const InvitationsState(),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    on<OpenInvitationDetails>(_onOpenInvitationDetails);
    on<JoinGroup>(_onJoinGroup);

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<InvitationsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    add(const RefreshAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<InvitationsState> emit,
  ) async {
    try {
      final List<GroupInvitation> invitations =
          await _loadGroupInvitationsUseCase.execute(
        const GetGroupInvitationsPayload(),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(state.copyWith(invitations: invitations));
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(state.copyWith(invitations: <GroupInvitation>[]));
      }
    }
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<InvitationsState> emit,
  ) async {
    try {
      final List<GroupInvitation> invitations =
          await _loadGroupInvitationsUseCase.execute(
        const GetGroupInvitationsPayload(),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(state.copyWith(invitations: invitations));
    } catch (_) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onOpenInvitationDetails(
    OpenInvitationDetails event,
    Emitter<InvitationsState> emit,
  ) async {
    final GroupDetailsScreenResult? result = await _appRouter.pushForResult(
      GroupDetailsFeature.groupInvitationPage(invitation: event.invitation),
    );

    __onResult(result: result);
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
      __onResult(result: GroupDetailsScreenResult.joinGroup);
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

  Future<void> __onResult({required GroupDetailsScreenResult? result}) async {
    switch (result) {
      case GroupDetailsScreenResult.joinGroup:
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(contentKey: 'otherAlerts.inGroupNow'),
          ),
        );
        break;
      case GroupDetailsScreenResult.declineInvitation:
        // TODO: Handle this case.
        break;
      default:
        return;
    }
  }
}
