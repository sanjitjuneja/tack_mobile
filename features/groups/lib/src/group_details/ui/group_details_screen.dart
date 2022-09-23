import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'group_details_form.dart';
import 'widgets/group_details_navigation_bar_action.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.primaryBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: CupertinoPageScaffold(
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
      ),
    );
  }
}
