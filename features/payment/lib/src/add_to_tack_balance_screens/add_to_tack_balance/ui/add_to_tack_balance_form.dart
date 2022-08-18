import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/add_to_tack_balance_bloc.dart';
import '/src/widgets/payment_method_tile.dart';
import '../../../widgets/tack_keyboard/ui/tack_keyboard.dart';

class AddToTackBalanceForm extends StatelessWidget {
  const AddToTackBalanceForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToTackBalanceBloc, AddToTackBalanceState>(
      builder: (BuildContext context, AddToTackBalanceState state) {
        return Column(
          children: <Widget>[
            Center(
              child: Text(
                FlutterI18n.translate(
                  context,
                  'addToTackBalanceScreen.title',
                ),
                style: AppTextTheme.manrope24SemiBold,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: PaymentMethodTile(
                leadingIcon: AppIconsTheme.masterCard,
                title: 'JP Morgan Chase',
                subtitle: '*****8748',
                isColored: true,
              ),
            ),
            const SizedBox(height: 45),
            TackKeyboard(
              subtitleKey:
              'addToTackBalanceScreen.currentTackBalance',
              amount: 50.00,
              onTap: (double value) {},
            ),
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: AppCircleButton(
                    labelKey: 'addToTackBalanceScreen.deposit',
                    expanded: false,
                    onTap: () => _onDepositTap(context),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 36),
          ],
        );
      },
    );
  }

  void _onDepositTap(BuildContext context) {
    BlocProvider.of<AddToTackBalanceBloc>(context).add(
      const MakeAddToTackBalanceRequest(),
    );
  }
}
