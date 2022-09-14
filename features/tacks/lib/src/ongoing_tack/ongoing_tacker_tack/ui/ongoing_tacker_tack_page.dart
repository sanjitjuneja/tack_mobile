import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/ongoing_tacker_tack_bloc.dart';
import 'ongoing_tacker_tack_screen.dart';

class OngoingTackerTackFeature {
  static const String routeName = '/ongoingTack';

  static Page<void> page({
    required Tack tack,
  }) {
    return _OngoingTackerTackPage(tack: tack);
  }
}

class _OngoingTackerTackPage extends Page<void> {
  final Tack tack;

  @override
  String get name => OngoingTackerTackFeature.routeName;

  const _OngoingTackerTackPage({
    required this.tack,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<OngoingTackerTackBloc>(
        create: (_) {
          return OngoingTackerTackBloc(
            tack: tack,
            appRouter: AppRouter.of(context),
            observeTackerTackIntentUseCase:
                appLocator.get<ObserveTackerTackIntentUseCase>(),
            fetchUserContactsUseCase:
                appLocator.get<FetchUserContactsUseCase>(),
            cancelTackTackerUseCase: appLocator.get<CancelTackTackerUseCase>(),
            completeTackUseCase: appLocator.get<CompleteTackTackerUseCase>(),
          );
        },
        child: const OngoingTackerTackScreen(),
      ),
    );
  }
}
