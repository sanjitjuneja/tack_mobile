enum TimeEstimationIn {
  min,
  hour;

  static const int _hourInSeconds = 60 * 60;
  static const int _minuteInSeconds = 60;

  factory TimeEstimationIn.fromTime(int? timeInSeconds) {
    if (timeInSeconds == null) return TimeEstimationIn.min;

    final bool isHours = timeInSeconds % _hourInSeconds == 0;
    return isHours ? TimeEstimationIn.hour : TimeEstimationIn.min;
  }

  int timeInSecondsToValue(int timeInSeconds) {
    switch (this) {
      case TimeEstimationIn.min:
        return timeInSeconds ~/ _minuteInSeconds;
      case TimeEstimationIn.hour:
        return timeInSeconds ~/ _hourInSeconds;
    }
  }

  int valueToTimeInSeconds(int value) {
    switch (this) {
      case TimeEstimationIn.min:
        return value * _minuteInSeconds;
      case TimeEstimationIn.hour:
        return value * _hourInSeconds;
    }
  }
}

class TimeEstimationData {
  final Map<TimeEstimationIn, num> maxValues;
  final bool isRequired;
  final TimeEstimationIn timeEstimationIn;
  final String timeEstimation;

  num get maxValue => maxValues[timeEstimationIn] ?? 0;

  bool get isValid => isRequired ? timeEstimation.isNotEmpty : true;

  bool isDataChanged(int? oldTime) {
    final TimeEstimationIn oldTimeEstimationIn =
        TimeEstimationIn.fromTime(oldTime);

    return timeInSeconds != oldTime || timeEstimationIn != oldTimeEstimationIn;
  }

  int? get timeInSeconds => timeEstimation.isNotEmpty
      ? timeEstimationIn.valueToTimeInSeconds(int.parse(timeEstimation))
      : null;

  const TimeEstimationData({
    required this.maxValues,
    required this.isRequired,
    this.timeEstimationIn = TimeEstimationIn.min,
    String? timeEstimation,
  }) : timeEstimation = timeEstimation ?? '';

  factory TimeEstimationData.fromTime({
    required Map<TimeEstimationIn, num> maxValues,
    required bool isRequired,
    required int? timeInSeconds,
  }) {
    final TimeEstimationIn estimationIn =
        TimeEstimationIn.fromTime(timeInSeconds);

    return TimeEstimationData(
      maxValues: maxValues,
      isRequired: isRequired,
      timeEstimationIn: estimationIn,
      timeEstimation: timeInSeconds == null
          ? null
          : estimationIn.timeInSecondsToValue(timeInSeconds).toString(),
    );
  }

  TimeEstimationData copyWith({
    String? timeEstimation,
    TimeEstimationIn? timeEstimationIn,
  }) {
    return TimeEstimationData(
      maxValues: maxValues,
      isRequired: isRequired,
      timeEstimation: timeEstimation ?? this.timeEstimation,
      timeEstimationIn: timeEstimationIn ?? this.timeEstimationIn,
    );
  }

  TimeEstimationData empty() {
    return TimeEstimationData(
      maxValues: maxValues,
      isRequired: isRequired,
      timeEstimation: '',
      timeEstimationIn: TimeEstimationIn.min,
    );
  }
}
