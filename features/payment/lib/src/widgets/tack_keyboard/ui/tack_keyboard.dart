import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
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
      listener: (_, TackKeyboardState state) {
        onChanged(state.parsedValue);
      },
      builder: (_, TackKeyboardState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              CupertinoTextField(
                readOnly: true,
                textAlign: TextAlign.center,
                controller: TextEditingController(
                  text: CurrencyUtility.dollarFormat.format(
                    state.parsedValue,
                  ),
                ),
                style: AppTextTheme.manrope38Bold.copyWith(
                  color: AppTheme.grassColor,
                ),
                decoration: const BoxDecoration(),
              ),
              const AppDivider(),
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
                (rowIndex) => Row(
                  children: List<Widget>.generate(
                    3,
                    (symbolIndex) {
                      final symbol =
                          keyboardSymbols[(rowIndex * 3) + symbolIndex];
                      return Expanded(
                        child: AspectRatio(
                          aspectRatio: Constants.keyboardSymbolRatio,
                          child: _customDepositNumber(
                            symbol: symbol,
                            onTap: () => _onSymbolTap(context, symbol),
                            onLongPress: () {
                              _onSymbolLongPress(context, symbol);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSymbolTap(
    BuildContext context,
    String symbol,
  ) {
    BlocProvider.of<TackKeyboardBloc>(context).add(
      KeyboardTapInputEvent(
        symbol: symbol,
      ),
    );
  }

  void _onSymbolLongPress(
    BuildContext context,
    String symbol,
  ) {
    BlocProvider.of<TackKeyboardBloc>(context).add(
      KeyboardLongPressInputEvent(
        symbol: symbol,
      ),
    );
  }

  Widget _customDepositNumber({
    required String symbol,
    required VoidCallback onTap,
    required VoidCallback onLongPress,
  }) {
    return OpacityOnTapContainer(
      onTap: onTap,
      onLongPress: onLongPress,
      feedbackType: HapticFeedbackType.heavy,
      withFeedback: true,
      child: symbol != keyboardSymbols[11]
          ? Center(
              child: Text(
                symbol,
                style: AppTextTheme.manrope36SemiBold,
              ),
            )
          : const Center(
              child: Icon(
                Icons.keyboard_backspace,
                size: 30,
                color: AppColors.shuttleGray,
              ),
            ),
    );
  }
}
