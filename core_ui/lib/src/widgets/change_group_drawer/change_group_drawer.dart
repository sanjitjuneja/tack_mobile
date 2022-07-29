library group_drawer;

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

part 'models/selectable_group.dart';

part 'change_group_drawer_widget.dart';

class ChangeGroupDrawer {
  static const String routeName = '/changeGroup';

  static Page<Group> page(
    List<Group> groups,
    Group currentGroup,
  ) {
    return _ChangeGroupDrawerPage(
      groups: groups,
      currentGroup: currentGroup,
    );
  }
}

class _ChangeGroupDrawerPage extends Page<Group> {
  final List<Group> groups;
  final Group currentGroup;

  @override
  String get name => ChangeGroupDrawer.routeName;

  const _ChangeGroupDrawerPage({
    required this.groups,
    required this.currentGroup,
  });

  @override
  Route<Group> createRoute(BuildContext context) {
    return TopSlideRoute(
      settings: this,
      transitionAnimationDuration: const Duration(milliseconds: 300),
      isDismissible: false,
      builder: (_) {
        return _ChangeGroupDrawerWidget(
          groups,
          currentGroup,
        );
      },
    );
  }
}
