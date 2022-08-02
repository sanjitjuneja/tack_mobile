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
          ),
        ) {
    on<ChangeGroup>(_onChangeGroup);
    on<GoToMyInvitations>(_onGoToMyInvitations);
  }

  Future<void> _onChangeGroup(
    ChangeGroup event,
    Emitter<GlobalState> emit,
  ) async {
    HapticFeedbackManager.heavyImpact();
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

  Future<void> _onGoToMyInvitations(
    GoToMyInvitations event,
    Emitter<GlobalState> emit,
  ) async {}
}
