import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/tacks_bloc.dart';
import 'tacks_form.dart';

class TacksScreen extends StatelessWidget {
  const TacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TacksBloc>(
      create: (_) => TacksBloc(
        appRouter: appLocator.get<AppRouterDelegate>(),
        fetchRunnerTacksUseCase: appLocator.get<FetchRunnerTacksUseCase>(),
        fetchTackerTacksUseCase: appLocator.get<FetchTackerTacksUseCase>(),
        cancelOfferUseCase: appLocator.get<CancelOfferUseCase>(),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          automaticallyImplyLeading: false,
          withMenu: true,
          middle: Align(
            alignment: Alignment.centerLeft,
            child: PageHeaderWithGroupWidget(
              titleKey: 'tacksScreen.title',
              image: AppIconsTheme.tack,
              subtitleKey: 'tacksScreen.subtitle',
            ),
          ),
        ),
        child: const TacksForm(),
      ),
    );
  }
}
