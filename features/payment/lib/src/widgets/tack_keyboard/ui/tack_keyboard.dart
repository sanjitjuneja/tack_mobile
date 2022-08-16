import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import '../bloc/tack_keyboard_bloc.dart';
import '../utils/keyboard_symbols.dart';

class TackKeyboard extends StatelessWidget {
  const TackKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TackKeyboardBloc, TackKeyboardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Column(
            children: List<Widget>.generate(
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
          ),
        );
      },
    );
  }

  Widget _customDepositNumber({
    required String symbol,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
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
