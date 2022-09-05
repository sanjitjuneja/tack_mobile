import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final Widget leadingIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isPrimary;
  final bool isColored;
  final bool hasTrailingArrow;

  const PaymentMethodTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isPrimary = false,
    this.isColored = false,
    this.hasTrailingArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: isColored
            ? const EdgeInsets.symmetric(
                horizontal: 16.0,
              )
            : null,
        decoration: isColored
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppTheme.textFieldSecondaryBackgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.black25,
                    offset: Offset(0.0, 4.0),
                    spreadRadius: 0,
                    blurRadius: 4.0,
                  ),
                ],
              )
            : null,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                leadingIcon,
                const SizedBox(width: 26.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hasTrailingArrow ? title.toSentenceCase() : title,
                      style: AppTextTheme.poppins18Medium,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle?.toSentenceCase() ?? '',
                        style: AppTextTheme.poppins12Medium.copyWith(
                          color: AppColors.shuttleGray,
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                if (isPrimary)
                  Text(
                    FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.primary',
                    ),
                    style: AppTextTheme.manrope14Regular.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                const SizedBox(width: 18),
                if (hasTrailingArrow)
                  AppIconsTheme.chevronRight(
                    color: AppTheme.iconPrimaryColor,
                    size: 20,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (!isColored) const AppDivider(),
          ],
        ),
      ),
    );
  }
}
