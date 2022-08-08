part of 'create_tack_bloc.dart';

class CreateTackState {
  final Group? group;
  final NearbyTacksState nearbyTacksState;
  final GroupTacksState groupTacksState;

  const CreateTackState({
    required this.group,
    NearbyTacksState? nearbyTacksState,
    GroupTacksState? groupTacksState,
  })  : nearbyTacksState = nearbyTacksState ?? const NearbyTacksState(),
        groupTacksState = groupTacksState ?? const GroupTacksState();

  CreateTackState copyWith({
    Group? group,
    NearbyTacksState? nearbyTacksState,
    GroupTacksState? groupTacksState,
  }) {
    return CreateTackState(
      group: group ?? this.group,
      nearbyTacksState: nearbyTacksState ?? this.nearbyTacksState,
      groupTacksState: groupTacksState ?? this.groupTacksState,
    );
  }
}
