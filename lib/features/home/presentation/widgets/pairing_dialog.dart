import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';

class PairingDialog extends StatefulWidget {
  BluetoothDevice? device;
  PairingDialog({super.key,required this.device});

  @override
  State<PairingDialog> createState() => _PairingDialogState();
}

class _PairingDialogState extends State<PairingDialog> {
  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
        backgroundColor: R.appColors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: R.appColors.brownLight,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: R.appColors.shadowColor.withOpacity(0.1),
                      blurRadius: 20
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: R.appColors.secondaryColor,
                          shape: BoxShape.circle
                      ),
                      child: Image.asset(R.appImages.device,height: 24,width: 24,),
                    ),
                    h1,
                    Text(widget.device?.advName??"",style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
                    h1,
                    Text("pairing".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.greyLight,fontSize: 12.px),),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
