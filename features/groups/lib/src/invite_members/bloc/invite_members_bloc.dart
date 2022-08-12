import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'invite_members_event.dart';

part 'invite_members_state.dart';

class InviteMembersBloc extends Bloc<InviteMembersEvent, InviteMembersState> {
  final AppRouterDelegate _appRouter;
  final LoadGroupInviteLinkUseCase _loadGroupInviteLinkUseCase;

  InviteMembersBloc({
    required Group group,
    required AppRouterDelegate appRouter,
    required LoadGroupInviteLinkUseCase loadGroupInviteLinkUseCase,
  })  : _appRouter = appRouter,
        _loadGroupInviteLinkUseCase = loadGroupInviteLinkUseCase,
        super(
          InviteMembersState(
            group: group,
            isLoading: true,
          ),
        ) {
    on<LoadLink>(_onLoadLink);

    on<InviteCopyLink>(_onInviteCopyLink);
    on<InviteShareLink>(_onInviteShareLink);

    add(const LoadLink());
  }

  Future<void> _onLoadLink(
    LoadLink event,
    Emitter<InviteMembersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final GroupInviteLink inviteLink =
          await _loadGroupInviteLinkUseCase.execute(
        GetGroupInviteLinkPayload(group: state.group),
      );

      emit(state.copyWith(inviteLink: inviteLink));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }

  Future<void> _onInviteCopyLink(
    InviteCopyLink event,
    Emitter<InviteMembersState> emit,
  ) async {
    if (!state.hasData) return;

    ClipboardManager.copyText(
      _appRouter.navigatorKey.currentContext!,
      state.inviteLink!.link,
    );
  }

  Future<void> _onInviteShareLink(
    InviteShareLink event,
    Emitter<InviteMembersState> emit,
  ) async {
    if (!state.hasData) return;

    ShareManager.shareText(state.inviteLink!.link);
  }
}
