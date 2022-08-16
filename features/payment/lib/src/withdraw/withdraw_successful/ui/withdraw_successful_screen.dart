import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:payment/src/withdraw/withdraw_amount/widgets/withdraw_method_type.dart';
import 'withdraw_successful_form.dart';

class WithdrawSuccessfulScreen extends StatelessWidget {
  final WithdrawMethodType withdrawMethodType;

  const WithdrawSuccessfulScreen({
    Key? key,
    required this.withdrawMethodType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: SafeArea(
        child: WithdrawSuccessfulForm(
          withdrawMethodType: withdrawMethodType,
        ),
      ),
    );
  }
}
