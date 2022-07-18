import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

class DurationUtility {
  static String durationFormatTime(
    Duration duration, {
    bool withHours = true,
  }) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    List<String> values = <String>[twoDigitSeconds, twoDigitMinutes];

    if (withHours) values.add(twoDigits(duration.inHours));

    return values.reversed.join(':');
  }

  static String durationFormatString(
    Duration duration,
    BuildContext context,
  ) {
    final String timeKey;
    final int count;
    // TODO: refactor.
    if (duration.inHours > 0) {
      timeKey = 'time.hourShort';
      count = duration.inHours;
    } else {
      timeKey = 'time.minuteShort';
      count = duration.inMinutes;
    }

    return FlutterI18n.translate(
      context,
      timeKey,
      translationParams: <String, String>{
        'count': count.toString(),
      },
    );
  }
}
