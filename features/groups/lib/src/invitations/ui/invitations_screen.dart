import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'invitations_form.dart';

class InvitationsScreen extends StatelessWidget {
  const InvitationsScreen({super.key});

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
          withResult: false,
        ),
        child: const SafeArea(
          child: InvitationsForm(),
        ),
      ),
    );
  }
}
