import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '/src/widgets/payment_method_tile.dart';
import '/src/payment_settings/widgets/tack_balance.dart';
import '../bloc/payment_settings_bloc.dart';

class PaymentSettingsForm extends StatelessWidget {
  const PaymentSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentSettingsBloc, PaymentSettingsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.title',
                  ),
                  style: AppTextTheme.manrope24SemiBold,
                ),
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 13),
                child: TackBalance(
                  tackBalance: 0.00,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.banks',
                  ),
                  style: AppTextTheme.manrope20Bold,
                ),
              ),
              const SizedBox(height: 14),
              PaymentMethodTile(
                leadingIcon: AppIconsTheme.masterCard,
                title: 'JP Morgan Chase',
                subtitle: '*****8748',
                isPrimary: true,
              ),
              PaymentMethodTile(
                leadingIcon: AppIconsTheme.masterCard,
                title: 'JP Morgan Chase',
                subtitle: '*****8748',
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.cards',
                  ),
                  style: AppTextTheme.manrope20Bold,
                ),
              ),
              const SizedBox(height: 14),
              PaymentMethodTile(
                leadingIcon: AppIconsTheme.masterCard,
                title: 'Mastercard',
                subtitle: '*****4685',
              ),
              PaymentMethodTile(
                leadingIcon: AppIconsTheme.masterCard,
                title: 'JP Morgan Chase',
                subtitle: '*****6448',
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.digitalWallets',
                  ),
                  style: AppTextTheme.manrope20Bold,
                ),
              ),
              const SizedBox(height: 14),
              PaymentMethodTile(
                leadingIcon: AppIconsTheme.applePay,
                title: 'Apple Pay',
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Text(
                  FlutterI18n.translate(
                    context,
                    'paymentSettingsScreen.add',
                  ),
                  style: AppTextTheme.manrope20Bold,
                ),
              ),
              const SizedBox(height: 14),
              PaymentMethodTile(
                leadingIcon: AppIconsTheme.bank,
                title: FlutterI18n.translate(
                  context,
                  'paymentSettingsScreen.addPaymentMethod',
                ),
                onTap: () => _onAddPaymentMethod(context),
              ),
              const SizedBox(height: 28),
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
          ),
        );
      },
    );
  }

  void _onAddPaymentMethod(BuildContext context) {
    BlocProvider.of<PaymentSettingsBloc>(context).add(
      const AddPaymentMethodRequest(),
    );
  }
}
