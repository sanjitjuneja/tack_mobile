import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimeTickerInheritedWidget extends StatefulWidget {
  final Widget child;

  const TimeTickerInheritedWidget({
    super.key,
    required this.child,
  });

  @override
  State<TimeTickerInheritedWidget> createState() =>
      _TimeTickerInheritedWidgetState();
}

class _TimeTickerInheritedWidgetState extends State<TimeTickerInheritedWidget> {
  static const Duration _timerTickDuration = Duration(milliseconds: 250);
  late StreamController<Timer> _controller;

  late Timer _timer;

  @override
  void initState() {
    _controller = StreamController<Timer>.broadcast();
    _timer = Timer.periodic(
      _timerTickDuration,
      _controller.add,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TimeTickerInherited(
      timerTickerStream: _controller.stream,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.close();

    super.dispose();
  }
}

class TimeTickerInherited extends InheritedWidget {
  final Stream<Timer> timerTickerStream;

  const TimeTickerInherited({
    super.key,
    required super.child,
    required this.timerTickerStream,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static TimeTickerInherited ofRequired(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TimeTickerInherited>()!;
  }
}
