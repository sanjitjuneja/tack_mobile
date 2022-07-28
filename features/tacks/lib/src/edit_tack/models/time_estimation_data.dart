enum TimeEstimationIn {
  min,
  hour;

  static const int _hourInSeconds = 60 * 60;
  static const int _minuteInSeconds = 60;

  factory TimeEstimationIn.fromTime(int timeInSeconds) {
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
  final int maxValue;
  final bool isRequired;
  final TimeEstimationIn timeEstimationIn;
  final String timeEstimation;

  bool get isValid => isRequired ? timeEstimation.isNotEmpty : true;

  bool isDataChanged(int oldTime) {
    return timeInSeconds != oldTime;
  }

  int? get timeInSeconds => isValid
      ? timeEstimationIn.valueToTimeInSeconds(int.parse(timeEstimation))
      : null;

  const TimeEstimationData({
    required this.maxValue,
    required this.isRequired,
    this.timeEstimationIn = TimeEstimationIn.min,
    this.timeEstimation = '',
  });

  factory TimeEstimationData.fromTime({
    required int maxValue,
    required bool isRequired,
    required int timeInSeconds,
  }) {
    final TimeEstimationIn estimationIn =
        TimeEstimationIn.fromTime(timeInSeconds);

    return TimeEstimationData(
      maxValue: maxValue,
      isRequired: isRequired,
      timeEstimationIn: estimationIn,
      timeEstimation:
          estimationIn.timeInSecondsToValue(timeInSeconds).toString(),
    );
  }

  TimeEstimationData copyWith({
    String? timeEstimation,
    TimeEstimationIn? timeEstimationIn,
  }) {
    return TimeEstimationData(
      maxValue: maxValue,
      isRequired: isRequired,
      timeEstimation: timeEstimation ?? this.timeEstimation,
      timeEstimationIn: timeEstimationIn ?? this.timeEstimationIn,
    );
  }
}
