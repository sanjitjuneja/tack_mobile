import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:navigation/navigation.dart';

import 'rate_tack_user_form.dart';

class RateTackUserScreen extends StatelessWidget {
  const RateTackUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: KeyboardDismissible(
        child: CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundColor,
          navigationBar: AppNavigationBar(
            backgroundColor: AppTheme.ratingBackgroundColor,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              CupertinoButton(
                padding: const EdgeInsets.all(12.0),
                onPressed: () => AppRouter.of(context).popWithResult(null),
                child: AppIconsTheme.cross(color: AppTheme.iconHintColor),
              )
            ],
          ),
          child: const SafeArea(
            child: RateTackUserForm(),
          ),
        ),
      ),
    );
  }
}
