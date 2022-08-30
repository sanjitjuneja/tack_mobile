import 'package:core/core.dart';
import 'package:domain/payment/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:payment/src/payment_settings_screens/payment_method_details/widgets/connected_bank_account_details.dart';
import 'package:payment/src/payment_settings_screens/payment_method_details/widgets/connected_card_details.dart';
import 'package:payment/src/payment_settings_screens/payment_method_details/widgets/primary_payment_method_button.dart';
import 'package:payment/src/payment_settings_screens/payment_method_details/widgets/remove_payment_method_button.dart';
import '../bloc/payment_method_details_bloc.dart';
import '../../widgets/payment_info_label.dart';

class PaymentMethodDetailsForm extends StatelessWidget {
  final ConnectedCard? card;
  final ConnectedBankAccount? bankAccount;

  const PaymentMethodDetailsForm({
    Key? key,
    required this.card,
    required this.bankAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodDetailsBloc, PaymentMethodDetailsState>(
      builder: (_, PaymentMethodDetailsState state) {
        final bool isBankAccount = bankAccount != null;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24),
              isBankAccount
                  ? ConnectedBankAccountDetails(bankAccount: bankAccount!)
                  : ConnectedCardDetails(card: card!),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PrimaryPaymentMethodButton(
                    isPrimary: false,
                    onTap: () {},
                  ),
                  RemovePaymentMethodButton(
                    onTap: () {},
                    isBankAccount: isBankAccount,
                  ),
                ],
              ),
              const Spacer(),
              const PaymentInfoLabel(),
              const SizedBox(height: 34),
            ],
          ),
        );
      },
    );
  }
}
