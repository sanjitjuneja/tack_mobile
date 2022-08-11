import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final AppIcon leadingIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isPrimary;

  const PaymentMethodTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 60,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 22.0,
              top: 8.0,
              right: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                leadingIcon.svg(size: 35),
                const SizedBox(width: 27.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTextTheme.poppins18Medium,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle ?? '',
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
                AppIconsTheme.chevronRight.call(
                  color: AppTheme.iconPrimaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
          const Spacer(),
          const AppDivider(width: 335),
        ],
      ),
    );
  }
}
