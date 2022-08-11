part of 'invitations_bloc.dart';

abstract class InvitationsEvent {
  const InvitationsEvent();
}

class InitialLoad extends InvitationsEvent {
  const InitialLoad();
}

class RefreshAction extends InvitationsEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshAction({
    this.completer,
  });
}

class LoadMoreAction extends InvitationsEvent {
  final Completer<LoadingStatus> completer;

  const LoadMoreAction({
    required this.completer,
  });
}

class OpenInvitationDetails extends InvitationsEvent {
  final GroupInvitation invitation;

  const OpenInvitationDetails({
    required this.invitation,
  });
}

class JoinGroup extends InvitationsEvent {
  final GroupInvitation invitation;

  const JoinGroup({
    required this.invitation,
  });
}
