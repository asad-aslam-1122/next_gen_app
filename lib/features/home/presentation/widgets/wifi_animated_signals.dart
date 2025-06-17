import 'package:flutter/material.dart';
import '../../../global/resources/resources.dart';

class WifiSignalIcon extends StatelessWidget {
  /// Signal strength from 0 to 4
  /// 0 = No signal
  /// 1 = Poor signal
  /// 2 = Fair signal
  /// 3 = Good signal
  /// 4 = Excellent signal
  final int strength;

  /// Size of the icon, defaults to 60px
  final double size;

  const WifiSignalIcon({
    Key? key,
    required this.strength,
    this.size = 60,
  }) : assert(strength >= 0 && strength <= 4, 'Strength must be between 0 and 4'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _WifiSignalPainter(strength),
    );
  }
}

class _WifiSignalPainter extends CustomPainter {
  final int strength;

  _WifiSignalPainter(this.strength);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 1.3);
    final radius1 = size.width * 0.2 + 1.5;
    final radius2 = size.width * 0.35 + 3;
    final radius3 = size.width * 0.5 + 5;
    // final radius4 = size.width * 0.65 + 3;

    // Draw center dot - always active
    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = R.appColors.subTitleGrey;

    canvas.drawCircle(center, radius1 * 0.4, dotPaint);

    // First arc (inner)
    paint.color = strength >= 2
        ? R.appColors.subTitleGrey
        : R.appColors.disconnectColor;
    drawArc(canvas, center, radius1, paint);

    // Second arc
    paint.color = strength >= 3
        ? R.appColors.subTitleGrey
        : R.appColors.disconnectColor;
    drawArc(canvas, center, radius2, paint);

    // Third arc
    paint.color = strength >= 4
        ? R.appColors.subTitleGrey
        : R.appColors.disconnectColor;
    drawArc(canvas, center, radius3, paint);

    // Fourth arc (outer)
    // paint.color = strength >= 4
    //     ? R.appColors.subTitleGrey
    //     : R.appColors.disconnectColor;
    // drawArc(canvas, center, radius4, paint);
  }

  void drawArc(Canvas canvas, Offset center, double radius, Paint paint) {
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      // Start from top-center, going counterclockwise
      -135 * (3.14159 / 180), // Convert to radians
      90 * (3.14159 / 180),   // 90 degree arc
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_WifiSignalPainter oldDelegate) {
    return oldDelegate.strength != strength;
  }
}

