part of 'invitations_bloc.dart';

class InvitationsState {
  final PaginationModel<GroupInvitation> invitationsData;
  final bool isLoading;

  InvitationsState({
    PaginationModel<GroupInvitation>? invitationsData,
    this.isLoading = false,
  }) : invitationsData =
            invitationsData ?? PaginationModel<GroupInvitation>.empty();

  InvitationsState copyWith({
    PaginationModel<GroupInvitation>? invitationsData,
    bool? isLoading,
  }) {
    return InvitationsState(
      invitationsData: invitationsData ?? this.invitationsData,
      isLoading: isLoading ?? false,
    );
  }
}
