import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/ongoing_runner_tack_bloc.dart';
import 'ongoing_runner_tack_screen.dart';

class OngoingRunnerTackFeature {
  static String routeName({required int id}) => '/ongoingTack/$id';

  static Page<void> page({
    required RunnerTack runnerTack,
  }) {
    return _OngoingRunnerTackPage(runnerTack: runnerTack);
  }
}

class _OngoingRunnerTackPage extends Page<void> {
  final RunnerTack runnerTack;

  @override
  String get name => OngoingRunnerTackFeature.routeName(id: runnerTack.id);

  const _OngoingRunnerTackPage({
    required this.runnerTack,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<OngoingRunnerTackBloc>(
        create: (_) {
          return OngoingRunnerTackBloc(
            runnerTack: runnerTack,
            appRouter: AppRouter.of(context),
            appLifeCycleProvider: appLocator.get<AppLifeCycleProvider>(),
            observeRunnerTackIntentUseCase:
                appLocator.get<ObserveRunnerTackIntentUseCase>(),
            fetchTackUseCase: appLocator.get<FetchTackUseCase>(),
            fetchUserContactsUseCase:
                appLocator.get<FetchUserContactsUseCase>(),
            fetchHasRunningTackUseCase:
                appLocator.get<FetchHasRunningTackUseCase>(),
            cancelTackRunnerUseCase: appLocator.get<CancelTackRunnerUseCase>(),
            completeTackUseCase: appLocator.get<CompleteTackRunnerUseCase>(),
            startTackUseCase: appLocator.get<StartTackRunnerUseCase>(),
          );
        },
        child: const OngoingRunnerTackScreen(),
      ),
    );
  }
}
