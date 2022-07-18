import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/bloc/tacks_bloc.dart';

import 'package:tacks/src/tacks_screen/ui/tacks_form.dart';

class TacksScreen extends StatelessWidget {
  const TacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TacksBloc>(
      create: (_) => TacksBloc(
        appRouter: appLocator.get<AppRouterDelegate>(),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          automaticallyImplyLeading: false,
          middle: BlocBuilder<GlobalBloc, GlobalState>(
            builder: (_, GlobalState state) {
              return Align(
                alignment: Alignment.centerLeft,
                child: GroupUserHeaderWidget(
                  user: state.user,
                  group: state.currentGroup,
                ),
              );
            },
          ),
          actions: <Widget>[
            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 10),
              onPressed: _onMenuTap,
              child: AppIconsTheme.menu(color: AppTheme.iconPrimaryColor),
            ),
          ],
        ),
        child: const TacksForm(),
      ),
    );
  }

  Future<void> _onMenuTap() async {
    // TODO: implement functionality.
  }
}
