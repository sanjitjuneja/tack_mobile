import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'previous_tacks_form.dart';

class PreviousTacksScreen extends StatelessWidget {
  const PreviousTacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
      ),
      child: const SafeArea(
        child: PreviousTacksForm(),
      ),
    );
  }
}
