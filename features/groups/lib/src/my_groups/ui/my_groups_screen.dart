import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'my_groups_form.dart';
import 'widgets/navigation_bar_action.dart';

class MyGroupsScreen extends StatelessWidget {
  const MyGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        withResult: false,
        actions: const <Widget>[
          NavigationBarAction(),
        ],
      ),
      child: const SafeArea(
        child: MyGroupsForm(),
      ),
    );
  }
}
