import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:create_tack/bloc/create_tack_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:groups/groups.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import 'create_tack_form.dart';

class CreateTackScreen extends StatelessWidget {
  const CreateTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (_, GlobalState state) {
        return BlocProvider<CreateTackBloc>(
          create: (_) => CreateTackBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          ),
          child: CupertinoPageScaffold(
            backgroundColor: AppTheme.primaryBackgroundColor,
            navigationBar: AppNavigationBar(
              backgroundColor: AppTheme.primaryBackgroundColor,
              automaticallyImplyLeading: false,
              middle: Align(
                alignment: Alignment.centerLeft,
                child: GroupUserHeaderWidget(
                  user: state.user,
                  group: state.currentGroup,
                ),
              ),
              actions: <Widget>[
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    appLocator.get<AppRouterDelegate>().push(MyGroups.page());
                  },
                  child: AppIconsTheme.menu(
                    color: AppTheme.iconPrimaryColor,
                  ),
                ),
              ],
            ),
            child: SafeArea(
              child: KeyboardDismissible(
                child: CreateTackForm(
                  group: state.currentGroup,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
