import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/withdraw_bloc.dart';
import '/src/widgets/payment_method_tile.dart';
import '../../../widgets/tack_keyboard/ui/tack_keyboard.dart';
import '../widgets/withdraw_method.dart';
import '../widgets/withdraw_method_type.dart';

class WithdrawForm extends StatelessWidget {
  const WithdrawForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (BuildContext context, WithdrawState state) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                children: <Widget>[
                  WithdrawMethod(
                    withdrawMethodType: WithdrawMethodType.instant,
                    title: FlutterI18n.translate(
                      context,
                      'withdrawScreen.instantPayout',
                    ),
                  ),
                  const SizedBox(width: 8),
                  WithdrawMethod(
                    withdrawMethodType: WithdrawMethodType.regular,
                    title: FlutterI18n.translate(
                      context,
                      'withdrawScreen.regularPayout',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: PaymentMethodTile(
                leadingIcon: AppIconsTheme.masterCard(size: 35),
                title: 'JP Morgan Chase',
                subtitle: '*****8748',
                isColored: true,
              ),
            ),
            const SizedBox(height: 45),
            TackKeyboard(
              subtitleKey: 'withdrawScreen.max',
              amount: 50.0,
              onChanged: (double value) {},
            ),
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: AppCircleButton(
                    labelKey: 'withdrawScreen.withdraw',
                    expanded: false,
                    onTap: () => _onWithdrawPress(context),
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

  void _onWithdrawPress(BuildContext context) {
    BlocProvider.of<WithdrawBloc>(context).add(
      const MakeWithdrawRequest(),
    );
  }
}
