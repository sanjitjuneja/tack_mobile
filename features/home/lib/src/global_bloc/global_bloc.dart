import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final AppRouterDelegate appRouter;

  GlobalBloc({
    required this.appRouter,
    required List<Group> groups,
  }) : super(
          GlobalState(
            user: user,
            groups: groups,
            currentGroup: groups.first,
          ),
        ) {
    on<ChangeGroup>(_onChangeGroup);
  }

  Future<void> _onChangeGroup(
    ChangeGroup event,
    Emitter<GlobalState> emit,
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
