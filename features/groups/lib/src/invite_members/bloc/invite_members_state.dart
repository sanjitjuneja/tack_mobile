part of 'invite_members_bloc.dart';

class InviteMembersState {
  final Group group;
  final bool isLoading;
  final bool hasError;
  final Uri? inviteLink;

  bool get hasData => inviteLink != null;

  const InviteMembersState({
    required this.group,
    this.isLoading = true,
    this.hasError = false,
    this.inviteLink,
  });

  InviteMembersState copyWith({
    bool? isLoading,
    bool? hasError,
    Uri? inviteLink,
  }) {
    return InviteMembersState(
      group: group,
      isLoading: isLoading ?? false,
      hasError: hasError ?? false,
      inviteLink: inviteLink ?? this.inviteLink,
    );
  }
}
