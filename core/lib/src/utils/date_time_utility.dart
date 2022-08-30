import 'package:intl/intl.dart';

class DateTimeUtility {
  static const String _dateFormatPattern = 'dd/MM/yy';

  static DateFormat get dateFormatter => DateFormat(_dateFormatPattern);
}