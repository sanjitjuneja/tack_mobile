import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import '../bloc/tack_keyboard_bloc.dart';

class TackKeyboard extends StatelessWidget {
  const TackKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TackKeyboardBloc, TackKeyboardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '1'),
                    symbolAlignment: Alignment.centerLeft,
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '1'),
                    ),
                  ),
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '2'),
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '2'),
                    ),
                  ),
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '3'),
                    symbolAlignment: Alignment.centerRight,
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '3'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '4'),
                    symbolAlignment: Alignment.centerLeft,
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '4'),
                    ),
                  ),
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '5'),
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '5'),
                    ),
                  ),
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '6'),
                    symbolAlignment: Alignment.centerRight,
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '6'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '7'),
                    symbolAlignment: Alignment.centerLeft,
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '7'),
                    ),
                  ),
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '8'),
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '8'),
                    ),
                  ),
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '9'),
                    symbolAlignment: Alignment.centerRight,
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '9'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '.'),
                    symbolAlignment: Alignment.centerLeft,
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '.'),
                    ),
                  ),
                  _customDepositNumber(
                    symbol: _numericSymbol(symbol: '0'),
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '0'),
                    ),
                  ),
                  _customDepositNumber(
                    symbol: const Icon(
                      Icons.keyboard_backspace,
                      size: 30,
                      color: AppColors.shuttleGray,
                    ),
                    symbolAlignment: Alignment.centerRight,
                    onTap: () => BlocProvider.of<TackKeyboardBloc>(context).add(
                      const KeyboardInputEvent(symbol: '<-'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _customDepositNumber({
    required Widget symbol,
    required VoidCallback onTap,
    Alignment symbolAlignment = Alignment.center,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: 77,
        height: 70,
        child: Align(
          alignment: symbolAlignment,
          child: symbol,
        ),
      ),
    );
  }

  Widget _numericSymbol({
    required String symbol,
  }) {
    return Text(
      symbol,
      style: AppTextTheme.manrope36SemiBold,
    );
  }
}
