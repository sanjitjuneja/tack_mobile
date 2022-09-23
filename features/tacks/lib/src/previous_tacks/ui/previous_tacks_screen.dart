import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'previous_tacks_form.dart';

class PreviousTacksScreen extends StatelessWidget {
  const PreviousTacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.primaryBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
        ),
        child: const SafeArea(
          child: PreviousTacksForm(),
        ),
      ),
    );
  }
}
