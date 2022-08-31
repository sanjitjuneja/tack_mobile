import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectedBankAccountDetails extends StatelessWidget {
  final ConnectedBankAccount bankAccount;

  const ConnectedBankAccountDetails({
    Key? key,
    required this.bankAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.textFieldSecondaryBackgroundColor,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.black25,
            offset: Offset(0.0, 4.0),
            spreadRadius: 0.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: Constants.paymentMethodCardRatio,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    bankAccount.bankName,
                    style: AppTextTheme.manrope20Regular,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppNetworkImageWidget(
                  bankAccount.imageUrl,
                  placeholderIcon: AppIconsTheme.bank,
                  boxShape: BoxShape.rectangle,
                  boxFit: BoxFit.fitWidth,
                  isShadowBorder: false,
                  diameter: 35,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              bankAccount.bankAccountType,
              style: AppTextTheme.manrope16Regular.copyWith(
                color: AppTheme.textHeavyHintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
