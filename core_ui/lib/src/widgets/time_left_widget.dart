import 'package:core/core.dart';
import 'package:core_ui/src/widgets/timer_ticker_widget.dart';
import 'package:flutter/cupertino.dart';

typedef TimeLeftBuilder = Widget Function(BuildContext, String);

/// Requires TimeTickerInherited above in widget tree.
class TimeLeftWidget extends StatelessWidget {
  final DateTime tillTime;
  final TimeLeftBuilder builder;

  const TimeLeftWidget({
    super.key,
    required this.tillTime,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return TimeTickerWidget(
      builder: (_) {
        final DateTime now = DateTime.now();
        Duration left = tillTime.difference(now);
        if (left.isNegative) {
          left = const Duration(seconds: 0);
        }
        final String content = DurationUtility.durationFormatTime(
          left,
          withHours: false,
        );

        return builder(context, content);
      },
    );
  }
}
