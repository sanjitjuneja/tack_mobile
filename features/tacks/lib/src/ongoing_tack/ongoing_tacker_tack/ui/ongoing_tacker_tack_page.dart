import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/ongoing_tacker_tack_bloc.dart';
import 'ongoing_tacker_tack_screen.dart';

class OngoingTackerTackFeature {
  static String routeName({required int id}) => '/ongoingTack/$id';

  static Page<void> page({
    required Tack tack,
  }) {
    return _OngoingTackerTackPage(tack: tack);
  }
}

class _OngoingTackerTackPage extends Page<void> {
  final Tack tack;

  @override
  String get name => OngoingTackerTackFeature.routeName(id: tack.id);

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
            appLifeCycleProvider: appLocator.get<AppLifeCycleProvider>(),
            observeTackerTackIntentUseCase:
                appLocator.get<ObserveTackerTackIntentUseCase>(),
            fetchTackUseCase: appLocator.get<FetchTackUseCase>(),
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
