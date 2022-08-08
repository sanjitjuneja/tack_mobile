import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/tacks_screen/bloc/tacks_bloc.dart';
import 'package:tacks/src/tacks_screen/ui/tacks_form.dart';

class TacksScreen extends StatelessWidget {
  const TacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TacksBloc>(
      create: (_) => TacksBloc(
        appRouter: appLocator.get<AppRouterDelegate>(),
        getRunnerTacksUseCase: appLocator.get<GetRunnerTacksUseCase>(),
        getTackerTacksUseCase: appLocator.get<GetTackerTacksUseCase>(),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          automaticallyImplyLeading: false,
          withMenu: true,
          middle: Align(
            alignment: Alignment.centerLeft,
            child: PageHeaderWidget(
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
