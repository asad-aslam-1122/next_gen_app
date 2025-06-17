import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_app_bar.dart';
import 'package:nextgen_reeftech/features/home/presentation/widgets/no_device_range_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/safe_area_widget.dart';
import '../provider/home_vm.dart';
import '../widgets/draggabla_sheet.dart';
import 'package:lottie/lottie.dart';

class FindDevicesView extends StatefulWidget {
  static String route = "/FindDevicesView";
  const FindDevicesView({super.key});

  @override
  State<FindDevicesView> createState() => _FindDevicesViewState();
}

class _FindDevicesViewState extends State<FindDevicesView> {

  @override
  void initState() {
    super.initState();
    HomeVM vm = Provider.of<HomeVM>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await vm.startBleService();
     Future.delayed(Duration(seconds: 11),(){
       if(!vm.bleService.hasScanning){
         if(vm.bleService.devicesList.isEmpty){
           Get.dialog(NoDeviceInRangeDialog());
         }
       }
     });
      setState(() {});
    },);
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
        backgroundColor: R.appColors.transparent,
        child: Consumer<HomeVM>(
            builder: (context, vm, _) {
              return Scaffold(
                appBar: GlobalAppBar.customAppBar2(title: "find_device",backGroundColor: R.appColors.backgroundColor),
                backgroundColor: R.appColors.backgroundColor,
                body: Stack(
                  children: [
                    Center(child: Lottie.asset(R.appImages.bluetooth_search_lottie,height: 500,width: 500)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                            decoration: BoxDecoration(
                                color: R.appColors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: R.appColors.shadowColor.withOpacity(0.1),
                                      blurRadius: 20
                                  )
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(vm.bleService.devicesList.isNotEmpty ? "Finding your devices" : "Searching device in range",style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(child: CircularProgressIndicator(color: vm.bleService.devicesList.isNotEmpty ? R.appColors.secondaryColor : R.appColors.appBarTitle,strokeWidth: 2,),),
                                    )
                                  ],
                                ),
                                if(vm.bleService.devicesList.isNotEmpty)...[
                                  h1,
                                  Text("${vm.bleService.devicesList.length} device found ..",style: R.textStyles.poppins(fontWeight: FontWeight.w500,fontSize: 12.px,color: R.appColors.subTitleGrey),),
                                  h1,
                                  Text("Please be patient we are doing our best for you",style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.subTitleGrey),),
                                  h1,
                                  GestureDetector(
                                    onTap: (){
                                      vm.bleService.hasScanning = false;
                                      Get.forceAppUpdate();
                                      setState(() {

                                      });
                                      Get.back();
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(R.appImages.stop,height: 24,width: 24,),
                                        w2,
                                        Text("Stop Searching",style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                   if(vm.bleService.devicesList.isNotEmpty) DraggableSheet(pairDevicesList: vm.bleService.devicesList),
                  ],
                )
              );
            }
        )
    );
  }
}

