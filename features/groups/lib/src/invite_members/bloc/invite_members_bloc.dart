import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:navigation/navigation.dart';

part 'invite_members_event.dart';
part 'invite_members_state.dart';

class InviteMembersBloc extends Bloc<InviteMembersEvent, InviteMembersState> {
  final AppRouterDelegate appRouter;

  InviteMembersBloc({
    required this.appRouter,
  }) : super(
          const InviteMembersState(inviteLink: 'https://www.tackapp.net'),
        ) {
    on<InviteCopyLink>(_onInviteCopyLink);
    on<InviteShareLink>(_onInviteShareLink);
  }

  Future<void> _onInviteCopyLink(
    InviteCopyLink event,
    Emitter<InviteMembersState> emit,
  ) async {
    await ClipboardManager.copyText(state.inviteLink);
    ToastManager.showToast(
      appRouter.navigatorKey.currentContext!,
      messageKey: 'toast.copiedToClipboard',
      backgroundColor: AppTheme.toastBackgroundColor,
    );
  }

  Future<void> _onInviteShareLink(
    InviteShareLink event,
    Emitter<InviteMembersState> emit,
  ) async {
    ShareManager.shareText(state.inviteLink);
  }
}
