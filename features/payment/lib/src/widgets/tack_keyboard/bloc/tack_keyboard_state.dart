part of 'tack_keyboard_bloc.dart';

class TackKeyboardState {
  final String value;

  double get parsedValue => double.tryParse(value) ?? 0.0;

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
