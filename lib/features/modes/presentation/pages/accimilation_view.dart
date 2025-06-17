import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../global/resources/resources.dart';
import '../provider/mode_vm.dart';
import '../widgets/point_moon_silder.dart';

class AccimilationView extends StatefulWidget {
  static final String route = '/accimilationView';

  @override
  State<AccimilationView> createState() => _AccimilationViewState();
}

class _AccimilationViewState extends State<AccimilationView> {
  bool isAcclimationEnabled = false;
  double value = 0;
  @override
  void initState() {
   if(Get.arguments!=null)
     {
       isAcclimationEnabled=Get.arguments["acclimate"];
     }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<ModeVM>(
        builder: (context, vm, child) {
          return Scaffold(
          backgroundColor: R.appColors.backgroundColor,
          appBar: GlobalAppBar.customAppBar2(
            title: 'acclimation_view'.L(),
            isTranslate: true,
            backGroundColor: R.appColors.backgroundColor,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'acclimation'.L(),
                      style: R.textStyles.poppins(
                        color: R.appColors.baseColor,
                        fontSize: 14.px,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.9,
                      child: CupertinoSwitch(
                        value: isAcclimationEnabled,
                        onChanged: (val) {
                          setState(() {
                            isAcclimationEnabled=val;
                          });
                        },
                        activeTrackColor: R.appColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                if (isAcclimationEnabled) ...[
                  buildNumberOfDays(vm),
                  const SizedBox(height: 25),

                  Text(
                    'start_intensity'.L(),
                    style: R.textStyles.poppins(
                      color: R.appColors.baseColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),
                  PointAndMoonSlider(intensityValue: value,onChanged: (v){setState(() {
                    value=v;
                  });},),
                ],

                // Flutter XSlider
              ],
            ),
          ),

          bottomNavigationBar: BottomAppBar(
            color: R.appColors.transparent,
            elevation: 0,
            child: CustomButton(
              backgroundColor: isAcclimationEnabled==false?R.appColors.inactiveColor:R.appColors.secondaryColor,
              textColor: isAcclimationEnabled==false?R.appColors.separatorColor:R.appColors.white,
              title: 'save'.L(),
              onPressed: () {
                if(vm.day==0)
                  {
                    ZBotToast.showToastError( message: "kindly_select_number_of_days_for_acclimation".L());

                  }
                else{
                  ZBotToast.showToastSuccess(title: "acclimation_added".L(), message: "acclimation_has_been_set_successfully".L());
                  Get.back(result: isAcclimationEnabled);
                }
              },
              isLocalizedText: false,
            ),
          ),
        );
      }
    );
  }


  Widget buildNumberOfDays(ModeVM vm) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 15, left: 30, right: 30),
      decoration: BoxDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Color(0x1A000000), blurRadius: 12, spreadRadius: 1),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Number of days',
            style: R.textStyles.poppins(
              fontWeight: FontWeight.w600,
              color: R.appColors.baseColor,
            ),
          ),
          const SizedBox(height: 20),
           Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCircleButton(Icons.remove, vm.decrement),
                  Column(
                    children: [
                      Text(
                        '${vm.day}',
                        style: R.textStyles.poppins(
                          fontSize: 24.px,

                          fontWeight: FontWeight.w500,
                          color: R.appColors.baseColor,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 35,
                        color: R.appColors.greyColor,
                        margin: EdgeInsets.only(top: 3),
                      ),
                    ],
                  ),
                  buildCircleButton(Icons.add, vm.increment),
                ],
              )

        ],
      ),
    );
  }

  Widget buildCircleButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: R.appColors.secondaryColor,
        child: Icon(icon, color: Colors.white, size: 32),
      ),
    );
  }


}
