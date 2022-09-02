part of 'tack_keyboard_bloc.dart';

abstract class TackKeyboardEvent {
  const TackKeyboardEvent();
}

class KeyboardTapInputEvent extends TackKeyboardEvent {
  final String symbol;

  const KeyboardTapInputEvent({
    required this.symbol,
  });
}

class KeyboardLongPressInputEvent extends TackKeyboardEvent {
  final String symbol;

  const KeyboardLongPressInputEvent({
    required this.symbol,
  });
}
