import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'invitation_details_screen.dart';

class InvitationDetails {
  static const String routeName = '/InvitationDetails';

  static Page<void> page() {
    return const _InvitationDetailsPage();
  }
}

class _InvitationDetailsPage extends Page<void> {
  @override
  String get name => InvitationDetails.routeName;

  const _InvitationDetailsPage();

  @override
  Route<Group> createRoute(BuildContext context) {
    return CupertinoPageRoute<Group>(
      settings: this,
      builder: (_) => const InvitationDetailsScreen(),
    );
  }
}
