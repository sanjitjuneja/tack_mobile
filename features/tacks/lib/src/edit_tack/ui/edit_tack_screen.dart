import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/edit_tack/ui/edit_tack_form.dart';

class EditTackScreen extends StatelessWidget {
  const EditTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        withResult: true,
      ),
      child: const SafeArea(
        child: KeyboardDismissible(
          child: EditTackForm(),
        ),
      ),
    );
  }
}
