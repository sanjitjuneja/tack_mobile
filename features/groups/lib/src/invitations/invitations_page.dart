import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'invitations_screen.dart';

class InvitationsFeature {
  static const String routeName = '/myInvitations';

  static Page<void> page() {
    return const _InvitationsPage();
  }
}

class _InvitationsPage extends Page<void> {
  @override
  String get name => InvitationsFeature.routeName;

  const _InvitationsPage();

  @override
  Route<Group> createRoute(BuildContext context) {
    return CupertinoPageRoute<Group>(
      settings: this,
      builder: (_) => const InvitationsScreen(),
    );
  }
}
