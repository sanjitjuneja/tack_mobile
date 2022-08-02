import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:groups/groups.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import 'package:dashboard/src/dashboard_screen/ui/dashboard_form.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        automaticallyImplyLeading: false,
        middle: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (_, GlobalState state) {
            return Align(
              alignment: Alignment.centerLeft,
              child: PageHeaderWidget(
                titleKey: 'dashboardScreen.title',
                subtitleKey: 'dashboardScreen.noGroupSelectedSubtitle',
                group: state.currentGroup,
                onTap: () => _onHeaderTap(context),
              ),
            );
          },
        ),
        actions: <Widget>[
          CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 10),
            onPressed: () => _onMenuTap(context),
            child: AppIconsTheme.menu(
              color: AppTheme.iconPrimaryColor,
            ),
          ),
        ],
      ),
      child: const DashboardForm(),
    );
  }

  void _onHeaderTap(BuildContext context) {
    BlocProvider.of<GlobalBloc>(context).add(const ChangeGroup());
  }

  void _onMenuTap(BuildContext context) {
    AppRouter.of(context).pushForResult(CreateGroup.page());
  }
}
