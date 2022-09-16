import 'dart:async';
import 'package:core_ui/src/widgets/time_ticker_inherited.dart';
import 'package:flutter/cupertino.dart';

typedef TickBuilder = Widget Function(BuildContext);

class TimeTickerWidget extends StatefulWidget {
  final TickBuilder builder;

  const TimeTickerWidget({
    super.key,
    required this.builder,
  });

  @override
  State<TimeTickerWidget> createState() => _TimeTickerWidgetState();
}

class _TimeTickerWidgetState extends State<TimeTickerWidget> {
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

  @override
  void dispose() {

    super.dispose();
  }
}
