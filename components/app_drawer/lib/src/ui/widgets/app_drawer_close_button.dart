import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

class AppDrawerCloseButton extends StatelessWidget {
  const AppDrawerCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OpacityOnTapContainer(
        onTap: AppRouter.of(context).pop,
        pressedOpacity: 0.85,
        child: Container(
          height: 36,
          margin: const EdgeInsets.only(
            left: 20.0,
            top: 10.0,
            right: 12.0,
          ),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
          child: AppIconsTheme.cross(),
        ),
      ),
    );
  }
}
