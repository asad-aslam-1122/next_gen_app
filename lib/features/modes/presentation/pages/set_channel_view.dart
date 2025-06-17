import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/bot_toast/zbot_toast.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:nextgen_reeftech/features/modes/data/model/channel_model.dart';
import 'package:nextgen_reeftech/features/modes/presentation/provider/mode_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/global_app_bar.dart';
import '../widgets/set_colors_sheet.dart';

class SetChannelView extends StatefulWidget {
  static String route="/setChannelView";

  const SetChannelView({super.key});

  @override
  State<SetChannelView> createState() => _SetChannelViewState();
}

class _SetChannelViewState extends State<SetChannelView> {

  @override
  Widget build(BuildContext context) {
    return  SafeAreaWidget(
      top: true,
      child: Consumer<ModeVM>(
        builder: (context,vm,_) {
          return Scaffold(
            backgroundColor: R.appColors.backgroundColor,
            appBar: GlobalAppBar.customAppBar2(title: "set_channels",backGroundColor: R.appColors.transparent),
            body: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h1,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Text("customize_each_channel_by_selecting_colors_to_create_a_perfect_balance_for_your_aquarium".L(),style:
                R.textStyles.poppins().copyWith(
                  fontSize: 14.px,color: R.appColors.subTitleGrey,
                ),),
              ),
              h3,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Text("channels".L(),style:
                R.textStyles.poppins().copyWith(
                  fontSize: 14.px,color: R.appColors.primaryColor,fontWeight: FontWeight.w600
                ),),
              ),
                h1,
                Column(
                  children: List.generate(vm.channels.length, (index)=>cardsWidget(index,vm.channels[index])),
                ),

            ],),
            bottomNavigationBar: Padding(
              padding:  EdgeInsets.fromLTRB(5.w,0,5.w,3.h),
              child: CustomButton(
                  onPressed: (){
                    if(vm.channels.any((e)=>e.color==null)==true)
                      {
                        ZBotToast.showToastError(message: "Please select color for each channel");
                      }
                    else{
                      Get.back();
                    ZBotToast.showToastSuccess(title: "channel_set".L(),message: "channels_have_been_set_successfully".L());
                    }
                  }, title: "save"),
            ),
          );
        }
      ),
    );
  }
  Widget cardsWidget(int index,ChannelModel channel,)
  {
    return GestureDetector(
      onTap: (){
        Get.bottomSheet(SetColorsSheet(index:index ,selectedColorID: channel.color?.id??-1,),isScrollControlled: true);
      },
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            channel.color!=null?
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: channel.color?.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Text(
                  channel.color?.label??"",
                  style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    color: R.appColors.primaryColor,
                  ),
                ),
              ],
            ):
            Text(channel.title??"",style:
            R.textStyles.poppins().copyWith(
                fontSize: 14.px,color: R.appColors.primaryColor,fontWeight: FontWeight.w500
            ),),
            Image.asset(R.appImages.arrowForward,scale: 4,)
          ],
        ),
      ),
    );
  }
}
