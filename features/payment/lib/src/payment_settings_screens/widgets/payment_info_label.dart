import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class PaymentInfoLabel extends StatelessWidget {
  const PaymentInfoLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(),
        AppIconsTheme.lock.svg(size: 15),
        const SizedBox(width: 5),
        Text(
          FlutterI18n.translate(
            context,
            'paymentSettingsScreen.privacyInfo',
          ),
          style: AppTextTheme.manrope13Medium.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
