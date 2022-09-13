import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../models/ongoing_tacker_screen_result.dart';
import '../bloc/ongoing_tacker_tack_bloc.dart';
import 'ongoing_tacker_tack_screen.dart';

class OngoingTackerTack {
  static const String routeName = '/ongoingTack';

  static Page<OngoingTackerScreenResult> page({
    required Tack tack,
  }) {
    return _OngoingTackerTackPage(tack: tack);
  }
}

class _OngoingTackerTackPage extends Page<OngoingTackerScreenResult> {
  final Tack tack;

  @override
  String get name => OngoingTackerTack.routeName;

  const _OngoingTackerTackPage({
    required this.tack,
  });

  @override
  Route<OngoingTackerScreenResult> createRoute(BuildContext context) {
    return CupertinoPageRoute<OngoingTackerScreenResult>(
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
            acceptOfferUseCase: appLocator.get<AcceptOfferUseCase>(),
            completeTackUseCase: appLocator.get<CompleteTackTackerUseCase>(),
          );
        },
        child: const OngoingTackerTackScreen(),
      ),
    );
  }
}
