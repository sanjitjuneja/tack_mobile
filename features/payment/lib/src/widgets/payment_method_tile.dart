import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final Widget leadingIcon;
  final Widget? trailingIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isPrimary;
  final bool isColored;
  final bool hasTrailingArrow;
  final bool isSelected;
  final bool isSelectable;
  final bool isDisabled;
  final bool isSentenceCase;
  final double? feePercent;

  const PaymentMethodTile({
    Key? key,
    required this.leadingIcon,
    this.trailingIcon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.feePercent,
    this.isPrimary = false,
    this.isColored = false,
    this.hasTrailingArrow = true,
    this.isSelected = false,
    this.isSelectable = false,
    this.isSentenceCase = true,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: isColored
            ? EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: subtitle == null ? 6.0 : 0.0,
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
                SizedBox(
                  height: 40,
                  width: 40,
                  child: leadingIcon,
                ),
                const SizedBox(width: 26.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title == Constants.visa
                          ? title.toUpperCase()
                          : isSentenceCase
                              ? title.toSentenceCase()
                              : title,
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
                if (isPrimary) ...<Widget>[
                  Text(
                    FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.primary',
                    ),
                    style: AppTextTheme.manrope14Regular.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ] else if (feePercent != null) ...<Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      FlutterI18n.translate(
                        context,
                        feePercent! > 0
                            ? 'selectPaymentMethodScreen.fee'
                            : 'selectPaymentMethodScreen.noFee',
                        translationParams: <String, String>{
                          'feePercent': feePercent!.toStringAsFixed(0),
                        },
                      ),
                      style: AppTextTheme.poppins12Medium.copyWith(
                        color: AppColors.shuttleGray,
                      ),
                    ),
                  ),
                ],
                if (isSelectable) ...<Widget>[
                  if (isSelected && !isDisabled) ...<Widget>[
                    AppIconsTheme.checkMarkFilled(size: 30),
                  ] else ...<Widget>[
                    AppIconsTheme.add(
                      size: 30,
                      color: isDisabled ? AppTheme.textDisabledColor30 : null,
                    ),
                  ],
                ] else if (hasTrailingArrow) ...<Widget>[
                  trailingIcon ??
                      AppIconsTheme.chevronRight(
                        color: AppTheme.iconPrimaryColor,
                        size: 20,
                      ),
                ],
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
