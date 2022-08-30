import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/add_payment_method_bloc.dart';
import '../widgets/add_payment_method_tile.dart';
import '../../../widgets/payment_info_label.dart';

class AddPaymentMethodForm extends StatelessWidget {
  const AddPaymentMethodForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPaymentMethodBloc, AddPaymentMethodState>(
      builder: (BuildContext context, AddPaymentMethodState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                FlutterI18n.translate(
                  context,
                  'addPaymentMethodScreen.title',
                ),
                style: AppTextTheme.manrope24SemiBold,
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: AddPaymentMethodTile(
                leadingIcon: AppIconsTheme.bank,
                title: FlutterI18n.translate(
                  context,
                  'addPaymentMethodScreen.addBank',
                ),
                onTap: () => _onAddBankTileTap(context),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: AddPaymentMethodTile(
                leadingIcon: AppIconsTheme.card,
                title: FlutterI18n.translate(
                  context,
                  'addPaymentMethodScreen.addCard',
                ),
                onTap: () => _onAddCreditCardTileTap(context),
              ),
            ),
            const Spacer(),
            const PaymentInfoLabel(),
            const SizedBox(height: 34),
          ],
        );
      },
    );
  }

  void _onAddCreditCardTileTap(BuildContext context) {
    BlocProvider.of<AddPaymentMethodBloc>(context).add(
      const AddCreditCardRequest(),
    );
  }

  void _onAddBankTileTap(BuildContext context) {
    BlocProvider.of<AddPaymentMethodBloc>(context).add(
      const AddBankAccountRequest(),
    );
  }
}
