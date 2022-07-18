import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/bloc/dashboard_bloc.dart';
import 'package:dashboard/src/dashboard_screen/ui/dashboard_form.dart';
import 'package:dashboard/src/mocked_data/user_data.dart';
import 'package:flutter/cupertino.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        automaticallyImplyLeading: false,
        middle: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (_, DashboardState state) {
            return Align(
              alignment: Alignment.centerLeft,
              child: GroupUserHeaderWidget(
                user: user,
                group: state.currentGroup,
                onTap: () => _onHeaderTap(context),
              ),
            );
          },
        ),
        actions: <Widget>[
          CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 10),
            onPressed: _onMenuTap,
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
    BlocProvider.of<DashboardBloc>(context).add(
      const ChangeGroup(),
    );
  }

  void _onMenuTap() {
    // TODO: add action on menu icon.
  }
}
