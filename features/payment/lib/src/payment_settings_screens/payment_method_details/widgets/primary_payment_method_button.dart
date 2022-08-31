import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class PrimaryPaymentMethodButton extends StatelessWidget {
  final bool isPrimary;
  final VoidCallback onTap;

  const PrimaryPaymentMethodButton({
    Key? key,
    required this.isPrimary,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: onTap,
      feedbackType: HapticFeedbackType.heavy,
      withFeedback: true,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isPrimary ? 34 : 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color:
              isPrimary ? AppTheme.primaryColor : AppTheme.buttonPrimaryColor,
          border: Border.all(color: AppTheme.buttonPrimaryColor),
          borderRadius: BorderRadius.circular(100),
          shape: BoxShape.rectangle,
        ),
        child: Text(
          FlutterI18n.translate(
            context,
            isPrimary
                ? 'paymentMethodDetailsScreen.defaultMethod'
                : 'paymentMethodDetailsScreen.makeDefaultMethod',
          ),
          style: AppTextTheme.manrope14Regular.copyWith(
            color:
                isPrimary ? AppTheme.buttonPrimaryColor : AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
