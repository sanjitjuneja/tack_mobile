import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../theme/app_theme.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          AppIconsTheme.chevronLeft(
            color: AppTheme.topNavBarInterfaceColor,
          ),
          const SizedBox(width: 10),
          Text(
            FlutterI18n.translate(context, 'general.back'),
            style: AppTextTheme.manrope16Regular.copyWith(
              color: AppTheme.topNavBarInterfaceColor,
            ),
          ),
        ],
      ),
    );
  }
}
