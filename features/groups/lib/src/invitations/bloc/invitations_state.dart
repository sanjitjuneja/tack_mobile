part of 'invitations_bloc.dart';

class InvitationsState {
  final List<GroupInvitation> invitations;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => invitations.isNotEmpty;

  const InvitationsState({
    List<GroupInvitation>? invitations,
    this.isLoading = false,
    this.canLoadMore = true,
  }) : invitations = invitations ?? const <GroupInvitation>[];

  InvitationsState copyWith({
    List<GroupInvitation>? invitations,
    bool? isLoading,
    bool? canLoadMore,
  }) {
    return InvitationsState(
      invitations: invitations ?? this.invitations,
      isLoading: isLoading ?? false,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
