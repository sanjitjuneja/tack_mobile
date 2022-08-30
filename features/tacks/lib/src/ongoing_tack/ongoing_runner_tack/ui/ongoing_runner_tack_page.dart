import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../models/ongoing_runner_screen_result.dart';
import '../bloc/ongoing_runner_tack_bloc.dart';
import 'ongoing_runner_tack_screen.dart';

class OngoingRunnerTack {
  static const String routeName = '/ongoingTack';

  static Page<OngoingRunnerScreenResult> page({
    required Tack tack,
  }) {
    return _OngoingRunnerTackPage(tack: tack);
  }
}

class _OngoingRunnerTackPage extends Page<OngoingRunnerScreenResult> {
  final Tack tack;

  @override
  String get name => OngoingRunnerTack.routeName;

  const _OngoingRunnerTackPage({
    required this.tack,
  });

  @override
  Route<OngoingRunnerScreenResult> createRoute(BuildContext context) {
    return CupertinoPageRoute<OngoingRunnerScreenResult>(
      settings: this,
      builder: (_) => BlocProvider<OngoingRunnerTackBloc>(
        create: (_) {
          return OngoingRunnerTackBloc(
            tack: tack,
            appRouter: AppRouter.of(context),
            fetchUserContactsUseCase:
                appLocator.get<FetchUserContactsUseCase>(),
            cancelTackRunnerUseCase: appLocator.get<CancelTackRunnerUseCase>(),
            completeTackUseCase: appLocator.get<CompleteTackRunnerUseCase>(),
            startTackUseCase: appLocator.get<StartTackRunnerUseCase>(),
            tacksRepository: appLocator.get<TacksRepository>(),
          );
        },
        child: const OngoingRunnerTackScreen(),
      ),
    );
  }
}
