part of 'tack_keyboard_bloc.dart';

class TackKeyboardState {
  final String value;

  const TackKeyboardState({
    required this.value,
  });

  TackKeyboardState copyWith({
    String? value,
  }) {
    return TackKeyboardState(
      value: value ?? this.value,
    );
  }
}
