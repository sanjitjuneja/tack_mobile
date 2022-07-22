import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/bloc/ongoing_runner_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/ui/ongoing_runner_tack_screen.dart';

class OngoingRunnerTack {
  static const String routeName = '/ongoingTack';

  static Page<Group> page({
    required Tack tack,
  }) {
    return _OngoingRunnerTackPage(tack: tack);
  }
}

class _OngoingRunnerTackPage extends Page<Group> {
  final Tack tack;

  @override
  String get name => OngoingRunnerTack.routeName;

  const _OngoingRunnerTackPage({
    required this.tack,
  });

  @override
  Route<Group> createRoute(BuildContext context) {
    return CupertinoPageRoute<Group>(
      settings: this,
      builder: (_) => BlocProvider<OngoingRunnerTackBloc>(
        create: (_) {
          return OngoingRunnerTackBloc(
            tack: tack,
            appRouter: AppRouter.of(context),
            tacksRepository: appLocator.get<TacksRepository>(),
          );
        },
        child: const OngoingRunnerTackScreen(),
      ),
    );
  }
}
