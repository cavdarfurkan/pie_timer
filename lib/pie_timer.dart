library pie_timer;

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Main widget to build `PieTimer`
class PieTimer extends StatefulWidget {
  const PieTimer({
    Key? key,
    this.pieAnimationController,
    required this.duration,
    required this.radius,
    required this.pieColor,
    required this.fillColor,
    this.borderColor,
    this.borderWidth,
    this.shadowColor = Colors.black,
    this.shadowElevation = 0.0,
    this.textStyle,
    this.isReverse = false,
    this.onCompleted,
    this.onDismissed,
    this.enableTouchControls = false,
  }) : super(key: key);

  /// To use start, stop, etc. functions of controller for external buttons.
  /// If not initialized, `enableTouchControls = true` is highly recommended for control inputs.
  ///
  /// No need for `Duration`
  final PieAnimationController? pieAnimationController;

  /// Countdown duration.
  final Duration duration;

  /// To determine the size of the pie.
  final double radius;

  /// Background (fill) color of the pie.
  final Color pieColor;

  /// Pie progress color.
  final Color fillColor;

  /// Sets `borderColor`.
  /// If null then there will be no border
  final Color? borderColor;

  /// Sets `borderWidth`.
  /// If null then there will be no border
  final double? borderWidth;

  /// The shadow color.
  final Color shadowColor;

  /// Shadow elevation. The value is non-negative.
  final double shadowElevation;

  /// Sets the direction of pie progress.
  /// False is Clockwise, True is Anti-Clockwise.
  final bool isReverse;

  /// `TextStyle` of timer text.
  final TextStyle? textStyle;

  /// Enable start, stop, etc. on touch of Pie Widget.
  ///
  /// Single Tap : Alternate between Start and Pause
  /// Long Press : Reset Timer
  ///
  /// Using with your own `PieAnimationController` is not supported.
  /// Unexpected results may occur.
  final bool? enableTouchControls;

  /// Function to run when animation status is completed.
  final VoidCallback? onCompleted;

  /// Function to run when animation status is dismissed.
  final VoidCallback? onDismissed;

  @override
  State<PieTimer> createState() => _PieTimerState();
}

class _PieTimerState extends State<PieTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _pieAnimation;
  late Animation<Duration> _timerAnimation;

  late VoidCallback? onCompleted = () => widget.onCompleted!();
  late VoidCallback? onDismissed = () => widget.onDismissed!();

  @override
  void initState() {
    super.initState();

    _initAnimationController();
    _initAnims();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initAnimationController() {
    // If animation controller is null, set AnimationController,
    // If not, initialize pieAnimationController as AnimationController.
    if (widget.pieAnimationController != null) {
      _controller = widget.pieAnimationController as AnimationController
        ..duration = widget.duration;
    } else {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      );
    }
  }

  void _initAnims() {
    // Tween(begin: -1.57, end: 4.71);
    _pieAnimation = Tween<double>(begin: -math.pi / 2, end: (3 * math.pi) / 2)
        .animate(_controller)
      ..addListener(() {})
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          onCompleted!();
        } else if (status == AnimationStatus.dismissed) {
          onDismissed!();
        }
      });

    _timerAnimation =
        Tween<Duration>(begin: _controller.duration, end: Duration.zero)
            .animate(_controller)
          ..addListener(() {
            setState(() {});
          });
  }

  void _startAnim() {
    _controller.forward();
  }

  void _stopAnim() {
    _controller.stop();
  }

  void _resetAnim() {
    _controller.reset();
    _startAnim();
  }

  double _opacityVal = 0.0;
  void _onTap() {
    if (_controller.isAnimating) {
      _stopAnim();
      setState(() => _opacityVal = 1.0);
    } else {
      _startAnim();
      setState(() => _opacityVal = 0.0);
    }
  }

  void _onLongPress() {
    _resetAnim();
    setState(() => _opacityVal = 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.enableTouchControls == true ? _onTap() : {},
      onLongPress: () =>
          widget.enableTouchControls == true ? _onLongPress() : {},
      child: Stack(
        children: [
          PhysicalModel(
            color: Colors.black,
            shape: BoxShape.circle,
            shadowColor: widget.shadowColor,
            elevation: widget.shadowElevation,
            child: SizedBox(
              width: widget.radius * 2,
              height: widget.radius * 2,
              child: CustomPaint(
                foregroundPainter: TimePainter(
                  duration: _timerAnimation.value,
                  textStyle: widget.textStyle,
                ),
                painter: PiePainter(
                  radian: _pieAnimation.value,
                  radius: widget.radius,
                  fillColor: widget.fillColor,
                  pieColor: widget.pieColor,
                  isReverse: widget.isReverse,
                  borderColor: widget.borderColor,
                  borderWidth: widget.borderWidth,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _opacityVal,
              duration: const Duration(milliseconds: 300),
              child: ClipOval(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.color),
                  child: Icon(
                    Icons.pause_circle_outline,
                    color: Colors.white,
                    size: widget.radius,
                    shadows: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints Pie properties
class PiePainter extends CustomPainter {
  PiePainter({
    required this.radian,
    required this.radius,
    required this.pieColor,
    required this.fillColor,
    required this.isReverse,
    this.borderColor,
    this.borderWidth,
  });

  // To calculate angle. // Gets _pieAnimation.value
  final double radian;
  final double radius;
  final Color pieColor;
  final Color fillColor;
  final bool isReverse;
  final Color? borderColor;
  final double? borderWidth;

  Path backgroundPath = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    var paint = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.fill;

    backgroundPath
      ..moveTo(center.dx, center.dy)
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    drawBackgroundCirlce(canvas, center, paint);

    drawPieProgress(canvas, center, paint);

    if (borderColor != null && borderWidth != null) {
      drawBorder(canvas, center, paint);
    }
  }

  /// Draw background circle
  void drawBackgroundCirlce(Canvas canvas, Offset center, Paint paint) {
    paint.color = fillColor;

    canvas.drawPath(backgroundPath, paint);
  }

  /// Draw pie progress
  void drawPieProgress(Canvas canvas, Offset center, Paint paint) {
    paint.color = pieColor;
    var piePath = Path();
    // Clockwise
    if (!isReverse) {
      piePath.moveTo(center.dx, center.dy);
      piePath.arcTo(Rect.fromCircle(center: center, radius: radius), -1.57,
          (radian + 1.57), false);
    }
    // Anti-Clockwise
    else if (isReverse) {
      piePath.moveTo(center.dx, center.dy);
      piePath.arcTo(Rect.fromCircle(center: center, radius: radius), -1.57,
          (-radian - 1.57), false);
    }
    piePath.close();
    canvas.drawPath(piePath, paint);
  }

  /// Draw border, it is inner border
  void drawBorder(Canvas canvas, Offset center, Paint paint) {
    paint.color = borderColor!;
    paint.strokeWidth = borderWidth!;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - (borderWidth! / 2), paint);
  }

  @override
  bool hitTest(Offset position) {
    return backgroundPath.contains(position);
  }

  @override
  bool shouldRepaint(covariant PiePainter oldDelegate) => this != oldDelegate;
}

/// Paints Timer inside the Pie
class TimePainter extends CustomPainter {
  TimePainter({
    required this.duration,
    this.textStyle,
  });

  // Gets _timerAnimation.value
  final Duration duration;

  final TextStyle? textStyle;

  @override
  void paint(Canvas canvas, Size size) {
    TextStyle textStyle = this.textStyle ??
        const TextStyle(
          color: Colors.black,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        );
    final textSpan = TextSpan(
      text: _parseTimeFormat(duration),
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  String _parseTimeFormat(Duration duration) {
    /// Gives 999ms duration offset for multiple anim synchronization.
    /// None of the durations does not perform extra 999ms (Elapsed tiem is equal),
    /// it is only for better visual feedback.
    /// `Duration(minutes:10)` goes as 10:00.000 -> 09:59.999 -> 00:00.000
    /// This offset is to prevent that. Now it goes as 10:00.999 -> 10:00.000  -> 00:00.999
    duration += const Duration(milliseconds: 999);

    List<String> splitted = duration.toString().split(":");
    String hh = splitted[0].padLeft(2, '0');
    String mm = splitted[1];
    String ss = splitted[2];
    ss = ss.substring(0, 2);

    return hh.contains("00") ? "$mm:$ss" : "$hh:$mm:$ss";
    // return "$mm:$ss";
  }

  @override
  bool shouldRepaint(covariant TimePainter oldDelegate) => this != oldDelegate;
}

/// If you want to use PieAnimationController, do it inside the state of a statful widget with Ticker.
class PieAnimationController extends AnimationController {
  PieAnimationController({required super.vsync});
}
