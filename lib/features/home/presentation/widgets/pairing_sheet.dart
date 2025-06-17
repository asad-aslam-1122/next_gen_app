import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/custom_button.dart';
import '../../../global/utils/global_widgets/global_widgets.dart';
import '../../../global/utils/global_widgets/safe_area_widget.dart';

class PairingSheet extends StatefulWidget {
  BluetoothDevice? device;
  void Function() yesTap;
  PairingSheet({super.key,required this.device,required this.yesTap});

  @override
  State<PairingSheet> createState() => _PairingSheetState();
}

class _PairingSheetState extends State<PairingSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      backgroundColor: R.appColors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlobalWidgets.bottomHorBar(backgroundColor: R.appColors.primaryColor),
            h2,
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: R.appColors.secondaryColor,
                  shape: BoxShape.circle
              ),
              child: Image.asset(R.appImages.device,height: 24,width: 24,),
            ),
            h1,
            Text("bluetooth_pairing_request".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
            h1,
            Text("${widget.device?.advName??""} ${"wants_to_pair_with_your_phone".L()}",style: R.textStyles.poppins(color: R.appColors.subTitleGrey,fontSize: 12.px),),
            h2,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      decoration: BoxDecoration(
                        color: R.appColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: R.appColors.subTitleGrey),
                      ),
                      child: Center(
                        child: Text(
                          "cancel".L(),
                          textAlign: TextAlign.center,
                          style: R.textStyles.poppins(
                            fontSize: 15.px,
                            fontWeight: FontWeight.w600,
                            color: R.appColors.subTitleGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                w2,
                Expanded(
                  child: CustomButton(onPressed: widget.yesTap, title: "pair"),
                ),
              ],
            ),
            h2,
          ],
        ),
      ),
    );
  }
}
