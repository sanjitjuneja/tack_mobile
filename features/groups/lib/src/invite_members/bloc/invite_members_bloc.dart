import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'invite_members_event.dart';

part 'invite_members_state.dart';

class InviteMembersBloc extends Bloc<InviteMembersEvent, InviteMembersState> {
  final AppRouterDelegate _appRouter;
  final FetchGroupInviteLinkUseCase _fetchGroupInviteLinkUseCase;
  final CreateDeeplinkUseCase _createDeeplinkUseCase;

  InviteMembersBloc({
    required Group group,
    required AppRouterDelegate appRouter,
    required FetchGroupInviteLinkUseCase fetchGroupInviteLinkUseCase,
    required CreateDeeplinkUseCase createDeeplinkUseCase,
  })  : _appRouter = appRouter,
        _fetchGroupInviteLinkUseCase = fetchGroupInviteLinkUseCase,
        _createDeeplinkUseCase = createDeeplinkUseCase,
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
          await _fetchGroupInviteLinkUseCase.execute(
        FetchGroupInviteLinkPayload(
          group: state.group,
        ),
      );

      final Uri deeplink = await _createDeeplinkUseCase.execute(
        CreateDeeplinkPayload(
          url: inviteLink.link,
        ),
      );

      emit(
        state.copyWith(
          inviteLink: deeplink,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          hasError: true,
        ),
      );
    }
  }

  Future<void> _onInviteCopyLink(
    InviteCopyLink event,
    Emitter<InviteMembersState> emit,
  ) async {
    if (!state.hasData) return;

    ClipboardManager.copyText(
      _appRouter.navigatorKey.currentContext!,
      state.inviteLink.toString(),
    );
  }

  Future<void> _onInviteShareLink(
    InviteShareLink event,
    Emitter<InviteMembersState> emit,
  ) async {
    if (!state.hasData) return;

    ShareManager.shareText(
      state.inviteLink.toString(),
    );
  }
}
