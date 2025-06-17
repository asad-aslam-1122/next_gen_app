import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/bot_toast/zbot_toast.dart';
import 'package:nextgen_reeftech/features/modes/presentation/provider/mode_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/custom_button.dart';
import '../../../global/utils/global_widgets/global_app_bar.dart';
import '../../../global/utils/global_widgets/vertical_slider_widget.dart';

class SetMoonlightBrightnessPage extends StatefulWidget {
  const SetMoonlightBrightnessPage({Key? key}) : super(key: key);

  @override
  State<SetMoonlightBrightnessPage> createState() =>
      _SetMoonlightBrightnessPageState();
}

class _SetMoonlightBrightnessPageState
    extends State<SetMoonlightBrightnessPage> {
  double _brightness = 0.7; // 70%

  @override
  Widget build(BuildContext context) {
    return Consumer<ModeVM>(
      builder: (context,vm,_) {
        return Scaffold(
          backgroundColor: R.appColors.backgroundColor,
          appBar: GlobalAppBar.customAppBar2(
            title: "moon_light",
            backGroundColor: R.appColors.backgroundColor,
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 2.h),
                Text(
                  "set_moonlight_to_create_a_natural_moonlight_effect_for_your_aquarium"
                      .L(),
                  style: R.textStyles.poppins().copyWith(
                    fontSize: 14.px,
                    color: R.appColors.subTitleGrey,
                  ),
                ),
                const Spacer(),
                Center(
                  child: VerticalIntensitySlider(
                    height: 313,
                    width: 123,
                    image: R.appImages.blueMoon,
                    imageSize: 2.5,
                    value:vm.moonLightBrightness,
                    color: R.appColors.moonlightColor,
                    onChange: (value){
                      _brightness=value;
                      setState(() {});
                    },
                  ),
                ),
                const Spacer(),
                CustomButton(onPressed: () {
                 vm.moonLightBrightness=_brightness;
                 vm.update();
                 ZBotToast.showToastSuccess(title: "moon_light_updated".L(),message: "moon_light_has_been_updated_successfully".L());
                 Get.back();
                }, title: "update"),
                SizedBox(height: 2.5.h),
              ],
            ),
          ),
        );
      }
    );
  }
}
