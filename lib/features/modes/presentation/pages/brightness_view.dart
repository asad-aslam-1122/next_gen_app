import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/set_moonlight_brightness.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../global/constants/heights_widths.dart';
import '../../../global/functions/global_functions.dart';
import '../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/custom_button.dart';
import '../../../global/utils/global_widgets/global_app_bar.dart';
import '../../data/model/channel_model.dart';
import '../../data/model/chart_data.dart';
import '../../data/model/color_label_model.dart';
import '../provider/mode_vm.dart';
import '../widgets/custom_thumb_shape.dart';
import '../widgets/point_moon_silder.dart';

class BrightnessView extends StatefulWidget {
  static String route = "/brightnessView";
  const BrightnessView({Key? key}) : super(key: key);

  @override
  State<BrightnessView> createState() => _BrightnessViewState();
}

class _BrightnessViewState extends State<BrightnessView> {
  List<ChannelModel> brightnessChannels=[];

  @override
  void initState() {
    ModeVM vm=context.read<ModeVM>();
    brightnessChannels = vm.deepCopyChannels(vm.channels);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ModeVM>(
        builder: (context,vm,_) {
          return Scaffold(
            backgroundColor: R.appColors.backgroundColor,
            appBar: GlobalAppBar.customAppBar2(
              backGroundColor: R.appColors.backgroundColor,
              title: "brightness",
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("adjust_the_brightness_level_across_all_light_channels_for_optimal_illumination".L(),style: R.textStyles.poppins().copyWith(
                    fontSize: 14.px,color:R.appColors.subTitleGrey
                  ),),
                  h3,
                  GestureDetector(
                    onTap:(){
                      Get.to(SetMoonlightBrightnessPage());
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:R.appColors.white,borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color:Colors.black.withAlpha(10),blurRadius: 5,spreadRadius: 5)
                        ]
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.5.h),
                      child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(R.appImages.blueMoon,scale: 4,),
                              w2,
                              titles("moon_light".L()),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,size: 18,)
                        ],
                      )
                    ),
                  ),
                  h2,
                  SizedBox(height: 2.h),
                  ...brightnessChannels.map((c) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titles(c.color?.label??""),
                          Text("${c.color?.brightness?.toInt()}%", style: R.textStyles.poppins().copyWith(fontSize: 14.px,color:R.appColors.primaryColor,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      channelSlider(c.color,(v){
                        setState(() {
                          c.color?.brightness = v;
                        });
                      }),
                      SizedBox(height: 2.h),
                    ],
                  )),
                  SizedBox(height: 3.h),

                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding:  EdgeInsets.fromLTRB(5.w,0,5.w,3.h),
              child: CustomButton(
                  onPressed: (){
                    brightnessChannels.forEach((x){
                      vm.channels.forEach((y){
                        if(x.color?.id==y.color?.id)
                          {
                            y.color?.brightness=x.color?.brightness;
                          }
                      });
                    });
                    vm.update();
                    Get.back();
                    ZBotToast.showToastSuccess(title: "brightness_level_updated".L(), message: "brightness_level_has_been_updated_successfully".L());

                  }, title: "save"),
            ),
          );
        }
    );
  }
  Widget titles(String title)
  {
    return Text(title, style: R.textStyles.poppins().copyWith(fontWeight: FontWeight.w600, fontSize: 14.px));
  }


  Widget channelSlider(ColorOption? color, Function onChanged) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 34,
          inactiveTrackColor: color?.color,
          activeTrackColor: color?.color,
          thumbShape: CustomThumbShape(
            channelColor: color?.color ?? R.appColors.secondaryColor,
            thumbSize: 14,
            strokeWidth: 3
          ),
          overlayShape: SliderComponentShape.noOverlay,
          trackShape: const RoundedRectSliderTrackShape(),
        ),
        child: Slider(
          padding: EdgeInsets.zero,
          value: color?.brightness ?? 0,
          min: 0,
          max: 100,
          onChanged: (v) {
            onChanged(v);
          }
        ),
      ),
    );
  }

}

