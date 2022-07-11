part of app_dialog;

class _ProgressBarPainter extends CustomPainter {
  final double progressStrokeWidth;
  final double backStrokeWidth;
  final double startAngle;
  final double sweepAngle;
  final double currentLength;
  final SweepGradient frontGradient;
  final Color? backColor;
  final Color fullProgressColor;
  final bool isFullProgress;

  _ProgressBarPainter({
    required this.progressStrokeWidth,
    required this.backStrokeWidth,
    required this.startAngle,
    required this.sweepAngle,
    required this.currentLength,
    required this.frontGradient,
    required this.backColor,
    required this.fullProgressColor,
    required this.isFullProgress,
  });

  /// Draw background circle for progress bar
  void _drawBack(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = backStrokeWidth;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  /// Draw the initial part of the arc (~ 0% - 1%).
  /// (The part that is less than the [progressStrokeWidth])
  void _drawLessArcPart(Canvas canvas, Size size) {
    // [MAIN LOGIC]
    //
    // Copies 'phases of the Moon' while drawing (Last Quarter -> Full Moon).
    // Draw two arcs. One static and one moving, and combine them using XOR.
    //
    // [MAIN LOGIC]

    double angle = 0;
    double height = 0;

    if (currentLength < progressStrokeWidth / 2) {
      angle = 180;
      height = progressStrokeWidth - currentLength * 2;
    } else if (currentLength < progressStrokeWidth) {
      angle = 0;
      height = currentLength * 2 - progressStrokeWidth;
    } else {
      return;
    }

    final Paint pathPaint = Paint()
      ..shader = frontGradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final Offset circleOffset = Offset(
      (size.width / 2) * cos(startAngle) + size.center(Offset.zero).dx,
      (size.width / 2) * sin(startAngle) + size.center(Offset.zero).dy,
    );

    canvas.drawPath(
      Path.combine(
        PathOperation.xor,
        Path()
          ..addArc(
            Rect.fromLTWH(
              circleOffset.dx - progressStrokeWidth / 2,
              circleOffset.dy - progressStrokeWidth / 2,
              progressStrokeWidth,
              progressStrokeWidth,
            ),
            _degToRad(180),
            _degToRad(180),
          ),
        Path()
          ..addArc(
            Rect.fromCenter(
              center: circleOffset,
              width: progressStrokeWidth,
              height: height,
            ),
            _degToRad(angle),
            _degToRad(180),
          ),
      ),
      pathPaint,
    );
  }

  /// Draw main arc (~ 1% - 100%).
  void _drawArcPart(Canvas canvas, Size size) {
    final Rect arcRect = Offset.zero & size;

    final Paint arcPaint = Paint()
      ..shader = frontGradient.createShader(arcRect)
      ..strokeWidth = progressStrokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, arcPaint);
  }

  void _drawFullProgress(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = fullProgressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = progressStrokeWidth;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (isFullProgress && (progressStrokeWidth > 0)) {
      _drawFullProgress(canvas, size);
      return;
    }

    if (backStrokeWidth > 0 && backColor != null) {
      _drawBack(canvas, size);
    }

    if (progressStrokeWidth <= 0) {
      return;
    } else if (progressStrokeWidth >= currentLength) {
      _drawLessArcPart(canvas, size);
    } else {
      _drawArcPart(canvas, size);
    }
  }

  @override
  bool shouldRepaint(_ProgressBarPainter oldDelegate) {
    return oldDelegate.currentLength != currentLength;
  }
}
