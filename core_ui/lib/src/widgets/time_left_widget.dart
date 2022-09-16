import 'package:core/core.dart';
import 'package:core_ui/src/widgets/timer_ticker_widget.dart';
import 'package:flutter/cupertino.dart';

/// [timeLeft] could be negative value.
typedef TimeLeftListener = void Function(BuildContext, int timeLeft);
typedef TimeLeftBuilder = Widget Function(BuildContext, String content);

/// Requires TimeTickerInherited above in widget tree.
class TimeLeftWidget extends StatelessWidget {
  final DateTime tillTime;
  final TimeLeftBuilder builder;
  final void Function(BuildContext)? onExpire;
  final TimeLeftListener? listener;

  const TimeLeftWidget({
    super.key,
    required this.tillTime,
    required this.builder,
    this.onExpire,
    this.listener,
  });

  String _calculateContent(BuildContext context) {
    final DateTime now = DateTime.now();
    Duration left = tillTime.difference(now);
    listener?.call(context, left.inSeconds);

    if (left.inSeconds == 0) onExpire?.call(context);
    if (left.isNegative) {
      left = const Duration(seconds: 0);
    }

    return DurationUtility.durationFormatTime(
      left,
      withHours: false,
    );

  }
  @override
  Widget build(BuildContext context) {
    return TimeTickerWidget(
      builder: (_) {
        final String content = _calculateContent(context);

        return builder(context, content);
      },
    );
  }
}
