import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:account/src/previous_tacks/ui/previous_tacks_screen.dart';

class PreviousTacksFeature {
  static const String routeName = '/previousTacks';

  static Page<void> page() {
    return const PreviousTacksPage();
  }
}

class PreviousTacksPage extends Page<void> {
  const PreviousTacksPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
        ),
        child: const PreviousTacksScreen(),
      ),
    );
  }
}
