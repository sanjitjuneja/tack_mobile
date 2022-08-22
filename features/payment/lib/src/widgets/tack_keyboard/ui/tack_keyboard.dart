import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import '../bloc/tack_keyboard_bloc.dart';
import '../utils/keyboard_symbols.dart';

class TackKeyboard extends StatelessWidget {
  final String subtitleKey;
  final double amount;
  final ValueSetter<double> onChanged;

  const TackKeyboard({
    Key? key,
    required this.subtitleKey,
    required this.amount,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TackKeyboardBloc, TackKeyboardState>(
      listener: (BuildContext context, TackKeyboardState state) {
        onChanged(double.tryParse(state.value) ?? 0);
      },
      builder: (BuildContext context, TackKeyboardState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Column(
            children: <Widget>[
              Text(
                '\$ ${state.value.isNotEmpty ? state.value : '0.00'}',
                style: AppTextTheme.manrope38Bold.copyWith(
                  color: AppColors.fern,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const AppDivider(width: 234),
              RichText(
                text: TextSpan(
                  text: FlutterI18n.translate(
                    context,
                    subtitleKey,
                  ),
                  style: AppTextTheme.manrope14Regular.copyWith(
                    color: AppColors.shuttleGray,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: CurrencyUtility.dollarFormat.format(amount),
                      style: AppTextTheme.manrope14Bold.copyWith(
                        color: AppColors.fern,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 44),
              ...List<Widget>.generate(
                4,
                (rowIndex) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List<Widget>.generate(
                      3,
                      (symbolIndex) {
                        final symbol =
                            keyboardSymbols[(rowIndex * 3) + symbolIndex];
                        return Padding(
                          padding: EdgeInsets.only(
                            left: symbol == '0' ? 15 : 0,
                          ),
                          child: _customDepositNumber(
                            symbol: symbol,
                            onTap: () {
                              BlocProvider.of<TackKeyboardBloc>(context).add(
                                KeyboardInputEvent(
                                  symbol: symbol,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _customDepositNumber({
    required String symbol,
    required VoidCallback onTap,
  }) {
    return OpacityOnTapContainer(
      onTap: onTap,
      feedbackType: HapticFeedbackType.heavy,
      withFeedback: true,
      child: symbol != keyboardSymbols[11]
          ? Text(
              symbol,
              style: AppTextTheme.manrope36SemiBold,
            )
          : const Icon(
              Icons.keyboard_backspace,
              size: 30,
              color: AppColors.shuttleGray,
            ),
    );
  }
}
