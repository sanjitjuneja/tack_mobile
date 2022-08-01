import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/mocked_data/runner_tacks_data.dart';
import 'package:tacks/src/mocked_data/tacker_tacks.dart';

part 'tacks_event.dart';

part 'tacks_state.dart';

class TacksBloc extends Bloc<TacksEvent, TacksState> {
  final AppRouterDelegate appRouter;

  TacksBloc({
    required this.appRouter,
  }) : super(const TacksState()) {
    on<MoveToAddTab>(_onMoveToAddTab);
    on<MoveToHomeTab>(_onMoveToHomeTab);

    on<LoadTacks>(_onLoadTacks);
    on<CancelTackOffer>(_onCancelTackOffer);
  }

  Future<void> _onMoveToAddTab(
    MoveToAddTab event,
    Emitter<TacksState> emit,
  ) async {
    appRouter.navigationTabState.changeTabIndex(HomeScreenTab.add);
  }

  Future<void> _onMoveToHomeTab(
    MoveToHomeTab event,
    Emitter<TacksState> emit,
  ) async {
    appRouter.navigationTabState.changeTabIndex(HomeScreenTab.dashboard);
  }

  Future<void> _onLoadTacks(
    LoadTacks event,
    Emitter<TacksState> emit,
  ) async {
    // TODO: refactor;
    if (state.tackerTacks.isNotEmpty) {
      emit(
        state.copyWith(
          tackerTacks: const <Tack>[],
          runnerTacks: const <RunnerTack>[],
        ),
      );
    } else {
      emit(
        state.copyWith(
          tackerTacks: tackerTacks,
          runnerTacks: runnerTacks,
        ),
      );
    }
  }

  Future<void> _onCancelTackOffer(
    CancelTackOffer event,
    Emitter<TacksState> emit,
  ) async {
    appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.cancelTackRunner',
          titleKey: '',
          translationParams: {
            AlertPropertyKey.message: {
              'tackName': event.tack.title,
            },
          },
        ),
      ),
    );
  }
}
