import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/withdraw_bloc.dart';
import '/src/widgets/payment_method_tile.dart';
import '/src/widgets/tack_keyboard/bloc/tack_keyboard_bloc.dart';
import '../../../widgets/tack_keyboard/ui/tack_keyboard.dart';
import '/src/widgets/tack_button.dart';
import '../widgets/withdraw_method.dart';
import '../widgets/withdraw_method_type.dart';

class WithdrawForm extends StatelessWidget {
  const WithdrawForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, withdrawState) {
        return BlocBuilder<TackKeyboardBloc, TackKeyboardState>(
          builder: (context, keyboardState) {
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
                    leadingIcon: AppIconsTheme.masterCard,
                    title: 'JP Morgan Chase',
                    subtitle: '*****8748',
                    isColored: true,
                  ),
                ),
                const SizedBox(height: 45),
                Text(
                  '\$ ${keyboardState.value.isNotEmpty ? keyboardState.value : '0.00'}',
                  style: AppTextTheme.manrope38Bold.copyWith(
                    color: AppColors.fern,
                  ),
                ),
                const AppDivider(width: 234),
                RichText(
                  text: TextSpan(
                    text: 'Max: ',
                    style: AppTextTheme.manrope14Regular.copyWith(
                      color: AppColors.shuttleGray,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\$ 50.00',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppColors.fern,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 44),
                const TackKeyboard(),
                const SizedBox(height: 24),
                TackButton(
                  title: FlutterI18n.translate(
                    context,
                    'withdrawScreen.withdraw',
                  ),
                  onTap: () => BlocProvider.of<WithdrawBloc>(context).add(
                    const MakeWithdrawRequest(),
                  ),
                ),
                const SizedBox(height: 36),
              ],
            );
          },
        );
      },
    );
  }
}
