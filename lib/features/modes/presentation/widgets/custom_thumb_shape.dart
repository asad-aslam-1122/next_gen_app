import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  final Color channelColor;
  double thumbSize;
  double strokeWidth;
  CustomThumbShape({required this.channelColor,this.thumbSize=16,this.strokeWidth=6,});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(32, 32);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;
    // Draw shadow
      final Paint shadowPaint = Paint()
        ..color = Colors.black.withAlpha(18)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(center, 18, shadowPaint);

    // Draw white circle
    final Paint fillPaint = Paint()
      ..color = channelColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center,thumbSize?? 16, fillPaint);

    // Draw colored border
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth??6;
    canvas.drawCircle(center, thumbSize??16, borderPaint);
  }
}
