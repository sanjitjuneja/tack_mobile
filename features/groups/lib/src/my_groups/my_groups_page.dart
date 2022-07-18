import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'my_groups_screen.dart';

class MyGroups {
  static const String routeName = '/myGroups';

  static Page<Group> page() {
    return const _MyGroupsPage();
  }
}

class _MyGroupsPage extends Page<Group> {
  @override
  String get name => MyGroups.routeName;

  const _MyGroupsPage();

  @override
  Route<Group> createRoute(BuildContext context) {
    return CupertinoPageRoute<Group>(
      settings: this,
      builder: (_) => const MyGroupsScreen(),
    );
  }
}
