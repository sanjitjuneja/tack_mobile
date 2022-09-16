import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/ongoing_runner_tack_bloc.dart';
import 'ongoing_runner_tack_screen.dart';

class OngoingRunnerTackFeature {
  static const String routeName = '/ongoingTack';

  static Page<void> page({
    required RunnerTack runnerTack,
  }) {
    return _OngoingRunnerTackPage(runnerTack: runnerTack);
  }
}

class _OngoingRunnerTackPage extends Page<void> {
  final RunnerTack runnerTack;

  @override
  String get name => OngoingRunnerTackFeature.routeName;

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
            observeRunnerTackIntentUseCase:
                appLocator.get<ObserveRunnerTackIntentUseCase>(),
            fetchUserContactsUseCase:
                appLocator.get<FetchUserContactsUseCase>(),
            cancelTackRunnerUseCase: appLocator.get<CancelTackRunnerUseCase>(),
            completeTackUseCase: appLocator.get<CompleteTackRunnerUseCase>(),
            startTackUseCase: appLocator.get<StartTackRunnerUseCase>(),
            fetchHasRunningTackUseCase:
                appLocator.get<FetchHasRunningTackUseCase>(),
          );
        },
        child: const OngoingRunnerTackScreen(),
      ),
    );
  }
}
