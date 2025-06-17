import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

class VerticalIntensitySlider extends StatefulWidget {
  final double height;
  final double width;
   double? value;
   String? image;
   double? imageSize;
  Color? color;
  Function onChange;

   VerticalIntensitySlider({
    super.key,

    this.height = 300,
    this.width = 80,
    this.image,
    this.value,
    this.imageSize,
    this.color,
    required this.onChange,
  });

  @override
  State<VerticalIntensitySlider> createState() => _VerticalIntensitySliderState();
}

class _VerticalIntensitySliderState extends State<VerticalIntensitySlider> {
  double value = 0;
@override
  void initState() {
   value=widget.value??0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double fillHeight = (widget.height * value) / 100;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          value -= details.delta.dy*0.2;
          if (value < 0) value = 0;
          if (value > 100) value = 100;
        });
        widget.onChange(value);
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: R.appColors.fullGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge, // Overflow fix here
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated blue fill from bottom
            Positioned(
              bottom: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: widget.width,
                height: fillHeight,
                decoration: BoxDecoration(
                  color:widget.color?? R.appColors.secondaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                    top: Radius.circular(value == 100 ? 20 : 0),
                  ),
                ),
              ),
            ),

            // Percentage text centered
            Text(
              '${value.toInt()}%',
              style: R.textStyles.poppins(
                fontSize: 16.px,
                fontWeight: FontWeight.w600,
                color: R.appColors.baseColor


              )
            ),

            // Sun icon bottom center
             Positioned(
              bottom: 30,
              child:   Image.asset(widget.image??R.appImages.sunBlack, scale:widget.imageSize?? 4,color:Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

