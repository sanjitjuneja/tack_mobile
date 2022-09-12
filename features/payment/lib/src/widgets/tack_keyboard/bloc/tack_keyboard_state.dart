part of 'tack_keyboard_bloc.dart';

class TackKeyboardState {
  final String value;

  double get parsedValue => double.tryParse(value) ?? 0.0;

  bool isInLimitsRange(double min, double max) {
    return parsedValue >= min && parsedValue <= max;
  }

  double amountWithFee({
    required double feePercent,
    required double feeMinAmount,
    required double feeMaxAmount,
  }) {
    double feeAmount = (feePercent / 100) * parsedValue;
    if (feeAmount > feeMaxAmount && feeMaxAmount > 0) {
      feeAmount = feeMaxAmount;
    } else if (feeAmount < feeMinAmount && feeMinAmount > 0) {
      feeAmount = feeMinAmount;
    }

    return parsedValue + feeAmount;
  }

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
