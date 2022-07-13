import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:groups/src/create_group/ui/create_group_form.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.secondaryBackgroundColor,
          withResult: true,
        ),
        child: const SafeArea(
          child: KeyboardDismissible(
            child: CreateGroupForm(),
          ),
        ),
      ),
    );
  }
}
