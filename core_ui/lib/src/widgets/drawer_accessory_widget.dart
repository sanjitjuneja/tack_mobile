import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DrawerAccessoryWidget extends StatelessWidget {
  const DrawerAccessoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 6,
      decoration: BoxDecoration(
        color: AppTheme.drawerAccessoryColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
