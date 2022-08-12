import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/add_payment_method_bloc.dart';
import '../widgets/add_payment_method_tile.dart';

class AddPaymentMethodForm extends StatelessWidget {
  const AddPaymentMethodForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPaymentMethodBloc, AddPaymentMethodState>(
      builder: (context, state) {
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
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: <Widget>[
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
                ],
              ),
            ),
            const SizedBox(height: 34),
          ],
        );
      },
    );
  }
}
