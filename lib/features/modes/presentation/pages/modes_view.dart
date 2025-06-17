import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/bot_toast/zbot_toast.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_app_bar.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/brightness_view.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/scheduling_view.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/set_channel_view.dart';
import 'package:nextgen_reeftech/features/modes/presentation/provider/mode_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/timezone_utils.dart';

class ModesView extends StatefulWidget {
  static String route="/modesView";
  const ModesView({super.key});

  @override
  State<ModesView> createState() => _ModesViewState();
}

class _ModesViewState extends State<ModesView> {
  @override
  Widget build(BuildContext context) {
    ModeVM vm=context.read<ModeVM>();

    return  SafeAreaWidget(
      top: true,
      child: Scaffold(
        backgroundColor: R.appColors.transparent,
        extendBodyBehindAppBar:true,
        appBar: GlobalAppBar.customAppBar2(title: "modes",backGroundColor: R.appColors.transparent),
        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(R.appImages.modesBack),fit: BoxFit.fill)
          ),
          child: Column(
            children: [
              h10,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Text("adjust_channels_schedules_control_brightness_and_enable_acclimation_for_perfect_lighting".L(),style:
                R.textStyles.poppins().copyWith(
                  fontSize: 14.px,color: R.appColors.subTitleGrey,
                ),),
              ),
              h2,
              cardsWidget(R.appImages.setChannel, "set_channels", "customize_six_light_channels_to_match_your_aquarium_needs",(){
                Get.toNamed(SetChannelView.route);
              }),
              cardsWidget(R.appImages.scheduling, "scheduling", "create_a_lighting_schedule_to_automate_your_aquariums_day_and_night_cycle",(){
                if(vm.channels.any((e)=>e.color==null))
                  {
                    ZBotToast.showToastError(message: "Please set channels first to schedule");
                  }
                else{
                if(TimezoneUtils.sunrise==null || TimezoneUtils.sunset==null)
                  {
                    TimezoneUtils.setDefaultTimezoneSunTimes();
                  }
                  Get.toNamed(SchedulingView.route);

                }
              }),
              cardsWidget(R.appImages.brightness, "brightness_control", "adjust_the_brightness_level_across_all_light_channels_for_optimal_illumination",(){
                if(vm.channels.any((e)=>e.color==null))
                {
                  ZBotToast.showToastError(message: "Please set channels first to schedule");
                }
                else{
                  Get.toNamed(BrightnessView.route);

                }

              }),
            ],
          ),
        ),
      ),
    );
  }
  Widget cardsWidget(String icon,String title,String subTitle,VoidCallback onTap)
  {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
        margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: R.appColors.white,
            boxShadow: [
              BoxShadow(color: R.appColors.black.withAlpha(10),
                  blurRadius: 5,spreadRadius: 5)
            ]
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon,scale: 4,),
            w3,
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title.L(),style:
                  R.textStyles.poppins().copyWith(
                      fontSize: 14.px,color: R.appColors.primaryColor,fontWeight: FontWeight.w500
                  ),),
                  Text(subTitle.L(),style:
                  R.textStyles.poppins().copyWith(
                      fontSize: 10.px,color: R.appColors.greyLight,fontWeight: FontWeight.w500
                  ),),
                ],
              ),
            ),
            Image.asset(R.appImages.arrowForward,scale: 4,)
          ],
        ),
      ),
    );
  }
}
