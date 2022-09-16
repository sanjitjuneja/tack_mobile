import 'package:intl/intl.dart';

class DateTimeUtility {
  static const String _dateFormatPattern = 'MM/dd/yy';

  static DateFormat get dateFormatter => DateFormat(_dateFormatPattern);
}