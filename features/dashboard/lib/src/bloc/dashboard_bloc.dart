import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/mocked_data/tacks_data.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AppRouterDelegate appRouter;

  DashboardBloc({
    required this.appRouter,
    required List<Group> groups,
  }) : super(
          DashboardState(
            groups: groups,
            currentGroup: groups.first,
            tacks: tacks,
          ),
        ) {
    on<ChangeGroup>(_onChangeGroup);
  }

  Future<void> _onChangeGroup(
    ChangeGroup event,
    Emitter<DashboardState> emit,
  ) async {
    final Group? newGroup = await appRouter.pushForResult(
      ChangeGroupDrawer.page(
        state.groups,
        state.currentGroup,
      ),
    );

    emit(
      state.copyWith(currentGroup: newGroup ?? state.currentGroup),
    );
  }
}
