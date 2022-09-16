import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/previous_tacks_bloc.dart';
import 'previous_tacks_screen.dart';

class PreviousTacksFeature {
  static const String routeName = '/previousTacks';

  static Page<void> page() {
    return const _PreviousTacksPage();
  }
}

class _PreviousTacksPage extends Page<void> {
  const _PreviousTacksPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<PreviousTacksBloc>(
        create: (_) => PreviousTacksBloc(
          appRouter: appLocator.get<AppRouterDelegate>(),
          fetchCompletedTacksUseCase:
              appLocator.get<FetchCompletedTacksUseCase>(),
          fetchCreatedTacksUseCase: appLocator.get<FetchCreatedTacksUseCase>(),
          observeCompletedTackRunnerIntentUseCase:
              appLocator.get<ObserveCompletedTackRunnerIntentUseCase>(),
        ),
        child: const PreviousTacksScreen(),
      ),
    );
  }
}
