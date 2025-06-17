import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../global/resources/resources.dart';
import 'custom_thumb_shape.dart';

class PointAndMoonSlider extends StatefulWidget {
  double? intensityValue;
  Function onChanged;
   PointAndMoonSlider({super.key,required this.intensityValue,required this.onChanged});

  @override
  State<PointAndMoonSlider> createState() => _PointAndMoonSliderState();
}

class _PointAndMoonSliderState extends State<PointAndMoonSlider> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(R.appImages.minIntensity,scale: 4,),
            Image.asset(R.appImages.maxIntensity,scale: 4,),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 18,
                  inactiveTrackColor: R.appColors.brownLight,
                  activeTrackColor: R.appColors.secondaryColor,
                  thumbShape: CustomThumbShape(channelColor:widget.intensityValue==0?R.appColors.brownLight: R.appColors.secondaryColor),
                  overlayShape: SliderComponentShape.noOverlay,
                  trackShape: const RoundedRectSliderTrackShape(),
                ),
                child: Slider(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  value: widget.intensityValue??0,
                  min: 0,
                  max: 100,
                  onChanged: (v) => widget.onChanged(v)
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${widget.intensityValue?.toInt()}%",
            style: R.textStyles.poppins().copyWith(fontSize: 10.px,color:R.appColors.separatorColor),
          ),
        ),
      ],
    );
  }
}
