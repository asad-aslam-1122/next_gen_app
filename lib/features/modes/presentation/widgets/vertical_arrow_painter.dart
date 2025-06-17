
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../data/model/chart_data.dart';

class VerticalArrowPainter extends CustomPainter {
  final double xPosition;
  final List<ChartData> chartData;
  final double animationValue;

  VerticalArrowPainter({
    required this.xPosition,
    required this.chartData,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double chartWidth = size.width;
    final double chartHeight = size.height;

    // Calculate x position in pixels
    final double maxX = (chartData.lastWhere((e)=>(e.pointIntensity??0)>0).pointIntensity??0);
    final double xPixel = (xPosition / maxX) * chartWidth;

    // Create paint for the vertical line
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw vertical line
    canvas.drawLine(
      Offset(xPixel, 0),
      Offset(xPixel, chartHeight),
      linePaint,
    );

    // Draw arrow head at top
    final arrowPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final arrowPath = Path();
    arrowPath.moveTo(xPixel, 0);
    arrowPath.lineTo(xPixel - 8, 12);
    arrowPath.lineTo(xPixel + 8, 12);
    arrowPath.close();
    canvas.drawPath(arrowPath, arrowPaint);

    // Highlight current point
    final currentPointIndex = (animationValue * (chartData.length - 1)).round();
    if (currentPointIndex < chartData.length) {
      final currentPoint = chartData[currentPointIndex];
      final yPixel = chartHeight - ((currentPoint.pointIntensity??0 )/ _getMaxY()) * chartHeight;

      final dotPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(xPixel, yPixel), 6, dotPaint);

      // Draw value label
      final textPainter = TextPainter(
        text: TextSpan(
          text: currentPoint.pointIntensity?.toStringAsFixed(1),
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(xPixel - textPainter.width / 2, yPixel - 20),
      );
    }
  }

  double _getMaxY() {
    return chartData.map((spot) => (spot.pointIntensity??0)).reduce((a, b) => (a??0) > (b??0) ? a : b) * 1.1;
  }

  @override
  bool shouldRepaint(covariant VerticalArrowPainter oldDelegate) {
    return oldDelegate.xPosition != xPosition ||
        oldDelegate.animationValue != animationValue;
  }
}