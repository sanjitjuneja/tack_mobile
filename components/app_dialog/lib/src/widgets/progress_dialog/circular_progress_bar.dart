part of app_dialog;

/// Double pi.
const double _doublePi = 2 * pi;

/// Coefficient to convert degrees to radians.
const double _piDiv180 = pi / 180;

/// Convert degrees to radians
///
/// Accept [degree] and returns radians
double _degToRad(double degree) {
  return degree * _piDiv180;
}

/// The callback type to get a new text value centered in the progress bar.
typedef OnGetCenterText = Text Function(double);

class CircularProgressBar extends StatefulWidget {
  /// Widget size. Equals the height and width of the widget.
  final double size;

  /// The maximum value of the progress bar.
  final double maxValue;

  /// Start angle. In this position there will be a zero value.
  final double startAngle;

  /// Progress line thickness.
  final double progressStrokeWidth;

  /// Background circle line thickness.
  final double backStrokeWidth;

  /// Color of the progress line.
  final Color progressColor;

  /// The color of the circle at 100% value.
  /// It only works when [mergeMode] equal to true.
  final Color? fullProgressColor;

  /// The color of the background circle.
  final Color? backColor;

  /// Animation speed.
  final Duration animationDuration;

  /// When this mode is enabled the progress bar with a 100% value forms a full
  /// circle.
  final bool mergeMode;

  /// The object designed to update the value of the progress bar.
  final ValueNotifier<double>? valueNotifier;

  /// Callback to generate a new Text widget located in the center of the
  /// progress bar. The callback input is the current value of the bar progress.
  final OnGetCenterText? onGetText;

  /// Create simple circular progress bar.
  ///
  /// Main params. Create simple circular progress bar with size equal to [size]
  /// ([size] = height = width). You can set the thickness of the progress line
  /// with [progressStrokeWidth] and the thickness of the background circle line
  /// with [backStrokeWidth]. If you don't want a background circle specify
  /// [backStrokeWidth] = 0. You can also set the starting angle [startAngle].
  /// Progress bar have a value from 0 to [maxValue].
  ///
  ///
  /// Color params. Progress bar can be either with or without a gradient. For a
  /// gradient, specify more than one color in the [progressColors] field and if
  /// a gradient is not needed specify only one color.You can also set the color
  /// of the circle on the background with [backColor]. The background circle
  /// does not support a gradient. About [fullProgressColor] read below.
  ///
  /// Animation param. You can adjust the speed of the animation with the
  /// [animationDuration] second. The higher the value, the slower the
  /// animation. If you do not need animation, specify zero [animationDuration].
  ///
  /// Value param. Set your ValueNotifier with the [valueNotifier] parameter.
  /// The values are updated with ValueNotifier which helps to avoid unnecessary
  /// redrawing of the widget and also allows you to put animation inside the
  /// widget.
  ///
  /// Full progress type. If [mergeMode] is true then at 100% the progress of
  /// the bar will be in the form of a closed ring and the color will be changed
  /// to [fullProgressColor]. If no [fullProgressColor] is specified, the last
  /// color from [progressColors] is taken.
  ///
  /// Center text. If you want the text with its value to be displayed in the
  /// center of the progress bar, define the [onGetText] method. In this method
  /// you should return the Text widget for the current progress bar value.
  const CircularProgressBar({
    Key? key,
    this.size = 100,
    this.maxValue = 100,
    this.startAngle = 0,
    this.progressStrokeWidth = 15,
    this.backStrokeWidth = 15,
    required this.progressColor,
    this.fullProgressColor,
    this.backColor,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.mergeMode = false,
    this.valueNotifier,
    this.onGetText,
  }) : super(key: key);

  @override
  State<CircularProgressBar> createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar>
    with SingleTickerProviderStateMixin {
  final double minSweepAngle = 0.015;

  late double circleLength;
  late double maxValue;
  late double widgetSize;

  late double startAngle;
  late double correctAngle;
  late SweepGradient sweepGradient;

  late AnimationController animationController;

  late Color fullProgressColor;

  @override
  void initState() {
    super.initState();

    // Check zero size.
    widgetSize = (widget.size <= 0) ? 100.0 : widget.size;
    maxValue = (widget.maxValue <= 0) ? 100.0 : widget.maxValue;

    // Calculate the real starting angle and correction angle.
    // Correction angle - the angle to which the main line should be
    // shifted in order for the SweepGradient to be displayed correctly.
    circleLength = pi * widgetSize;
    final k = _doublePi / circleLength;

    correctAngle = widget.progressStrokeWidth * k;
    startAngle = (correctAngle / 2);

    // Adjusting the colors.
    final List<Color> progressColors = <Color>[];
    final Color progressColor = widget.progressColor;
    progressColors.add(progressColor.withOpacity(0.2));
    progressColors.add(progressColor.withOpacity(0.3));
    progressColors.add(progressColor.withOpacity(0.8));
    progressColors.add(progressColor);

    sweepGradient = SweepGradient(
      tileMode: TileMode.decal,
      colors: progressColors,
    );

    fullProgressColor = (widget.fullProgressColor == null)
        ? progressColors.last
        : widget.fullProgressColor!;

    // Create animation.
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: 0.0,
      lowerBound: 0.0,
      upperBound: maxValue,
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController..repeat(min: 0.1),
      builder: (context, snapshot) {
        double sweepAngle;

        // Reduce the value to a range of 0.0 to 1.0.
        final reducedValue = animationController.value / maxValue;

        if (animationController.value == 0) {
          sweepAngle = minSweepAngle;
        } else {
          sweepAngle = (_doublePi * reducedValue) - correctAngle;
        }

        // Repaint progress bar.
        return Transform.rotate(
          angle: sweepAngle,
          child: CustomPaint(
            size: Size(widgetSize, widgetSize),
            painter: _ProgressBarPainter(
              progressStrokeWidth: widget.progressStrokeWidth,
              backStrokeWidth: widget.backStrokeWidth,
              startAngle: startAngle,
              sweepAngle: _degToRad(250),
              currentLength: circleLength,
              frontGradient: sweepGradient,
              backColor: widget.backColor,
              fullProgressColor: fullProgressColor,
              isFullProgress: false,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
}
