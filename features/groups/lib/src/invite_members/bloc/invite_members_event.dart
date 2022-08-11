part of 'invite_members_bloc.dart';

abstract class InviteMembersEvent {
  const InviteMembersEvent();
}

class LoadLink extends InviteMembersEvent {
  const LoadLink();
}

class InviteCopyLink extends InviteMembersEvent {
  const InviteCopyLink();
}

class InviteShareLink extends InviteMembersEvent {
  const InviteShareLink();
}
