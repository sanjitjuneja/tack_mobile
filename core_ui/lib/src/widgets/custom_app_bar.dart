import 'package:flutter/material.dart';

import '../../core_ui.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    required String title,
    required void Function() onLeadingPressed,
    List<Widget>? actions,
    ImageIcon? leadingIcon,
    Key? key,
  }) : super(
          key: key,
          leading: leadingIcon != null
              ? IconButton(
                  icon: leadingIcon,
                  color: AppTheme.accentColor,
                  onPressed: onLeadingPressed,
                )
              : const SizedBox.shrink(),
          centerTitle: true,
          shadowColor: AppColors.transparent,
          backgroundColor: AppColors.transparent,
          titleSpacing: 0,
          title: Row(
            children: [
              Text(
                title,
                style: AppTextTheme.manrope16Light.copyWith(
                  color: AppTheme.accentColor,
                ),
              ),
            ],
          ),
          actions: actions,
        );
}
