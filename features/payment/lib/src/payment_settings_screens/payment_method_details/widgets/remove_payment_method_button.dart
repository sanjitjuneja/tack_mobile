import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class RemovePaymentMethodButton extends StatelessWidget {
  final bool isBankAccount;
  final VoidCallback onTap;

  const RemovePaymentMethodButton({
    Key? key,
    required this.onTap,
    required this.isBankAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: onTap,
      feedbackType: HapticFeedbackType.heavy,
      withFeedback: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: AppTheme.errorColor,
          border: Border.all(color: AppTheme.errorColor),
          borderRadius: BorderRadius.circular(100),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          children: <Widget>[
            AppIconsTheme.cross(
              size: 15,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(width: 10),
            Text(
              FlutterI18n.translate(
                context,
                isBankAccount
                    ? 'paymentMethodDetailsScreen.removeBank'
                    : 'paymentMethodDetailsScreen.removeCard',
              ),
              style: AppTextTheme.manrope14Regular.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
