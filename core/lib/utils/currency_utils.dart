import 'package:intl/intl.dart';

class CurrencyUtility {
  static NumberFormat get dollarFormat => NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static NumberFormat get dollarRoundFormat => NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
  );
}
