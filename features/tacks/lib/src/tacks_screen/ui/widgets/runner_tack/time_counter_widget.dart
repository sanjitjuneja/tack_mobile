import 'dart:async';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

typedef TimerBuilder = Widget Function(BuildContext);

class TimeCounterWidget extends StatefulWidget {
  final TimerBuilder builder;

  const TimeCounterWidget({
    super.key,
    required this.builder,
  });

  @override
  State<TimeCounterWidget> createState() => _TimeCounterWidgetState();
}

class _TimeCounterWidgetState extends State<TimeCounterWidget> {
  late Stream<Timer> _timeTickerStream;

  @override
  void didChangeDependencies() {
    _timeTickerStream =
        TimeTickerInherited.ofRequired(context).timerTickerStream;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: _timeTickerStream,
      builder: (BuildContext context, _) {
        return widget.builder(context);
      },
    );
  }
}
