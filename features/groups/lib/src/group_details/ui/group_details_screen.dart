import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/group_details/ui/group_details_form.dart';
import 'package:groups/src/group_details/ui/widgets/group_details_navigation_bar_action.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        withResult: true,
        actions: const <Widget>[
          GroupDetailsNavigationBarAction(),
        ],
      ),
      child: const SafeArea(
        child: GroupDetailsFrom(),
      ),
    );
  }
}
