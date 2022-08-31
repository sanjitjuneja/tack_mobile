import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/connected_bank_account_details.dart';
import '../widgets/connected_card_details.dart';
import '../widgets/primary_payment_method_button.dart';
import '../widgets/remove_payment_method_button.dart';
import '../bloc/payment_method_details_bloc.dart';
import '../../widgets/payment_info_label.dart';

class PaymentMethodDetailsForm extends StatelessWidget {
  const PaymentMethodDetailsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodDetailsBloc, PaymentMethodDetailsState>(
      builder: (_, PaymentMethodDetailsState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24),
              state.isBankAccount
                  ? ConnectedBankAccountDetails(bankAccount: state.bankAccount!)
                  : ConnectedCardDetails(card: state.card!),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PrimaryPaymentMethodButton(
                    isPrimary: false,
                    onTap: () => _onSetPrimaryMethodAction(context),
                  ),
                  RemovePaymentMethodButton(
                    onTap: () => _onRemovePaymentMethodAction(context),
                    isBankAccount: state.isBankAccount,
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

  void _onSetPrimaryMethodAction(BuildContext context) {
    //TODO
  }

  void _onRemovePaymentMethodAction(BuildContext context) {
    //TODO
  }
}
