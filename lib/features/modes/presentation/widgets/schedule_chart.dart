import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

import '../../../global/resources/resources.dart';

class ScheduleChart extends StatefulWidget {
  const ScheduleChart({Key? key}) : super(key: key);

  @override
  State<ScheduleChart> createState() => _ScheduleChartState();
}

class _ScheduleChartState extends State<ScheduleChart>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // Example data points
  final List<FlSpot> spots = [
    FlSpot(0, 2), // 2 AM
    FlSpot(1, 80), // 8 AM
    FlSpot(2, 60), // 12 PM
    FlSpot(3, 90), // 4 PM
    FlSpot(4, 60), // 8 PM
    FlSpot(5, 2), // 12 AM
  ];
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }
  double get currentXPosition {
    // Calculate the current x position based on animation progress
    final double maxX = spots.last.x;
    return _animation.value * maxX;
  }
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        LineChart(
          LineChartData(
            minX: 0,
            maxX: 5,
            minY: 0,
            maxY: 100,
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: false,
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta) {
                    if (value % 20 == 0 && value >= 0 && value <= 100) {
                      return Text(
                        value.toInt().toString(),
                        style:  R.textStyles.poppins().copyWith(color: R.appColors.separatorColor, fontSize: 11.px),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  interval: 20,
                ),
              ),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta) {
                    const labels = ['12 AM', '8 AM', '12 PM', '4 PM', '8 PM', '12 AM'];
                    if (value.toInt() >= 0 && value.toInt() < labels.length) {
                      return Text(labels[value.toInt()], style: R.textStyles.poppins().copyWith(color: R.appColors.separatorColor, fontSize: 11.px),);
                    }
                    return const SizedBox.shrink();
                  },
                  interval: 1,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border:  Border(
                left: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 2,
                color: Colors.blue,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.4),
                      Colors.blue.withOpacity(0.05),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    if (index == 0) {
                      // Sun emoji at start
                      return FlDotEmojiPainter(emoji: '☀️', borderColor: Colors.black);
                    } else if (index == spots.length - 1) {
                      // Moon emoji at end
                      return FlDotEmojiPainter(emoji: '🌙', borderColor: Colors.black);
                    } else {
                      return FlDotCirclePainter(
                        radius: 10,
                        color:Colors.blue,
                      );
                    }
                  },
                ),
              ),
            ],
            extraLinesData: ExtraLinesData(
              verticalLines: [
                VerticalLine(
                  x: 1, // 8 AM
                  color: Colors.red.withOpacity(0.5),
                  strokeWidth: 2,
                  label: VerticalLineLabel(
                    show: false,
                  ),
                  // Custom arrow at the bottom

                ),
              ],
            ),
          ),
        ),
        // Positioned.fill(
        //   child: CustomPaint(
        //     painter: VerticalArrowPainter(
        //       xPosition: currentXPosition,
        //       chartData: spots,
        //       animationValue: _animation.value,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// Helper for custom dot painter with emoji
class FlDotEmojiPainter extends FlDotPainter {
  final String emoji;
  final Color borderColor;
  FlDotEmojiPainter({required this.emoji, required this.borderColor});

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas,
      {Color? color, double? radius, double? strokeWidth, Color? strokeColor}) {
    // Draw white circle with border
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offsetInCanvas, 12, paint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(offsetInCanvas, 12, borderPaint);

    // Draw emoji
    final textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: TextStyle(fontSize: 15),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      offsetInCanvas - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  Size getSize(FlSpot spot) {
    // TODO: implement getSize
    throw UnimplementedError();
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

  @override
  // TODO: implement mainColor
  Color get mainColor => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

