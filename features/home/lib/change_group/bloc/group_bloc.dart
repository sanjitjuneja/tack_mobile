import 'package:core/core.dart';
import 'package:domain/models/group.dart';
import 'package:home/change_group/mocked_data/groups_data.dart';
import 'package:home/change_group/ui/change_group_drawer.dart';
import 'package:navigation/navigation.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final AppRouterDelegate appRouter;

  GroupBloc({
    required this.appRouter,
  }) : super(
          GroupState(
            groups: shortGroups,
            currentGroup: shortGroups.first,
          ),
        ) {
    on<ChangeGroup>(_onChangeGroup);
  }

  Future<void> _onChangeGroup(
    ChangeGroup event,
    Emitter<GroupState> emit,
  ) async {
    final Group newGroup = await appRouter.pushForResult(
      ChangeGroupDrawer.page(
        state.groups,
        state.currentGroup,
      ),
    );

    emit(
      state.copyWith(currentGroup: newGroup),
    );
  }
}
