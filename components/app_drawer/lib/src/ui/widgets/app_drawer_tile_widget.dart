import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SideBarTileWidget extends StatelessWidget {
  final String titleKey;
  final AppIcon? leadingIcon;
  final Color? interfaceColor;
  final bool isNeedChevron;
  final void Function()? onPressed;

  const SideBarTileWidget({
    super.key,
    required this.titleKey,
    this.interfaceColor,
    this.onPressed,
    this.leadingIcon,
    this.isNeedChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color interfaceColor =
        this.interfaceColor ?? AppTheme.textPrimaryColor;

    return OpacityOnTapContainer(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            if (leadingIcon != null) ...<Widget>[
              const SizedBox(width: 4),
              leadingIcon!.call(
                color: interfaceColor,
                size: 16,
              ),
            ],
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, titleKey),
                style: AppTextTheme.manrope16Medium.copyWith(
                  color: interfaceColor,
                ),
              ),
            ),
            if (isNeedChevron)
              AppIconsTheme.chevronRight(
                color: AppTheme.iconPrimaryColor,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
