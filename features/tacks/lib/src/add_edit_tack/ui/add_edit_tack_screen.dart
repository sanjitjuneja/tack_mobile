import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/add_edit_tack/ui/add_edit_tack_form.dart';

import 'widgets/navigation_bar_action.dart';

class AddEditTackScreen extends StatelessWidget {
  const AddEditTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
        actions: const <Widget>[
          NavigationBarAction(),
        ],
      ),
      child: const SafeArea(
        child: KeyboardDismissible(
          child: AddEditTackForm(),
        ),
      ),
    );
  }
}
