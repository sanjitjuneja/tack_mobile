import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/add_to_tack_balance_amount_bloc.dart';
import '/src/widgets/payment_method_tile.dart';
import '/src/widgets/tack_keyboard/bloc/tack_keyboard_bloc.dart';
import '../../../widgets/tack_keyboard/ui/tack_keyboard.dart';

class AddToTackBalanceAmountForm extends StatelessWidget {
  const AddToTackBalanceAmountForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToTackBalanceAmountBloc, AddToTackBalanceAmountState>(
      builder: (context, withdrawState) {
        return BlocBuilder<TackKeyboardBloc, TackKeyboardState>(
          builder: (context, keyboardState) {
            return Column(
              children: <Widget>[
                Center(
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      'addToTackBalanceAmountScreen.title',
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
                Text(
                  '\$ ${keyboardState.value.isNotEmpty ? keyboardState.value : '0.00'}',
                  style: AppTextTheme.manrope38Bold.copyWith(
                    color: AppColors.fern,
                  ),
                ),
                const AppDivider(width: 234),
                RichText(
                  text: TextSpan(
                    text: FlutterI18n.translate(
                      context,
                      'addToTackBalanceAmountScreen.currentTackBalance',
                    ),
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
                Row(
                  children: <Widget>[
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: AppCircleButton(
                        labelKey: 'addToTackBalanceAmountScreen.deposit',
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
      },
    );
  }

  void _onDepositTap(BuildContext context) {
    BlocProvider.of<AddToTackBalanceAmountBloc>(context).add(
      const MakeAddToTackBalanceRequest(),
    );
  }
}
