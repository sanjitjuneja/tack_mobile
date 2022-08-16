part of 'tack_keyboard_bloc.dart';

abstract class TackKeyboardEvent {
  const TackKeyboardEvent();
}

class KeyboardInputEvent extends TackKeyboardEvent {
  final String symbol;

  const KeyboardInputEvent({required this.symbol});
}
