import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../provider/home_vm.dart';

class NoDeviceInRangeDialog extends StatefulWidget {
  NoDeviceInRangeDialog({super.key});

  @override
  State<NoDeviceInRangeDialog> createState() => _NoDeviceInRangeDialogState();
}

class _NoDeviceInRangeDialogState extends State<NoDeviceInRangeDialog> {
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
                padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 8.w),
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
                    Text("search_device".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor,fontSize: 16.px),),
                    h1,
                    Text("no_device_in_range".L(),style: R.textStyles.poppins(color: R.appColors.greyLight,fontSize: 12.px),),
                    h1,
                    GestureDetector(
                      onTap: ()async{
                        Get.back();
                        HomeVM vm = Provider.of<HomeVM>(context,listen: false);
                        await vm.startBleService();
                        Future.delayed(Duration(seconds: 11),(){
                          if(!vm.bleService.hasScanning){
                            if(vm.bleService.devicesList.isEmpty){
                              Get.dialog(NoDeviceInRangeDialog());
                            }
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        decoration: BoxDecoration(
                          color: R.appColors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("retry".L(),style: R.textStyles.poppins(color: R.appColors.primaryColor,fontSize: 14.px,fontWeight: FontWeight.w500),),),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
