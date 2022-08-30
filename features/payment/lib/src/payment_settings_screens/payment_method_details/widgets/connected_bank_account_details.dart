import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                bankAccount.bankName,
                style: AppTextTheme.manrope20Regular,
              ),
              AppNetworkImageWidget(
                bankAccount.imageUrl,
                placeholderIcon: AppIconsTheme.bank,
                boxShape: BoxShape.rectangle,
                boxFit: BoxFit.fitWidth,
                isShadowBorder: false,
                imageBackgroundColor: AppTheme.transparentColor,
                diameter: 35,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            bankAccount.bankAccountType,
            style: AppTextTheme.manrope16Regular.copyWith(
              color: AppColors.shuttleGray,
            ),
          ),
          const SizedBox(height: 96),
        ],
      ),
    );
  }
}
