import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:groups/src/invite_members/ui/invite_members_form.dart';

class InviteMembersScreen extends StatelessWidget {
  const InviteMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: const SafeArea(
        child: InviteMembersForm(),
      ),
    );
  }
}
