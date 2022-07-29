import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/rate_tack_user/ui/rate_tack_user_form.dart';

class RateTackUserScreen extends StatelessWidget {
  const RateTackUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.backgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.ratingBackgroundColor,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            CupertinoButton(
              padding: const EdgeInsets.all(12.0),
              onPressed: AppRouter.of(context).pop,
              child: AppIconsTheme.cross(color: AppTheme.iconHintColor),
            )
          ],
        ),
        child: const KeyboardDismissible(
          child: RateTackUserForm(),
        ),
      ),
    );
  }
}
