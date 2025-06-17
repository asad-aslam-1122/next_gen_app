import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/confirmation_bottom_sheet.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_widgets.dart';
import 'package:nextgen_reeftech/features/home/presentation/provider/home_vm.dart';
import 'package:nextgen_reeftech/features/home/presentation/widgets/pairing_dialog.dart';
import 'package:nextgen_reeftech/features/home/presentation/widgets/pairing_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../data/model/device_data.dart';

class DraggableSheet extends StatefulWidget {
  List<ScanResult>? pairDevicesList;
  DraggableSheet({super.key,this.pairDevicesList});

  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double initialChildSize = 0.5;
  double calculateSheetSize(int itemCount) {
    double baseHeight = 100.0;
    double itemHeight = 70.0;
    double totalHeight = baseHeight + (itemCount * itemHeight);
    double screenHeight = MediaQuery.of(context).size.height;
    return (totalHeight / screenHeight).clamp(0.2, 0.7);
  }

  @override
  Widget build(BuildContext context) {
    HomeVM vm = Provider.of<HomeVM>(context,listen: false);
    double calculatedSize = calculateSheetSize(widget.pairDevicesList?.length ?? 0);
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: calculatedSize,
      minChildSize: (calculatedSize - 0.1).clamp(0.1, 1.0),
      maxChildSize: calculatedSize,
      builder: (context, scrollController) {
        return GestureDetector(
          onVerticalDragUpdate: (detail){
            _sheetController.animateTo(
              0.3,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          onVerticalDragEnd: (detail){
            _sheetController.animateTo(
              0.7,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: R.appColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: R.appColors.shadowColor.withOpacity(0.1),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              children: [
                h1,
                GlobalWidgets.bottomHorBar(backgroundColor: R.appColors.appBarTitle,width: 47),
                h1,
                Text("available_devices".L(),style: R.textStyles.poppins(fontSize: 16.px,fontWeight: FontWeight.w600,color: R.appColors.primaryColor),),
                h2,
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.pairDevicesList?.length??0,
                      separatorBuilder: (context,index){
                      return Container(
                        height: 1,
                        color: R.appColors.disconnectColor,
                      );
                      },
                      itemBuilder: (context,index){
                        String advName = widget.pairDevicesList?[index].device.advName ?? "";
                        bool isConnected = widget.pairDevicesList?[index].device.isConnected ?? false;
                        return
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: R.appColors.secondaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Image.asset(R.appImages.device,height: 16,width: 16,),
                                  ),
                                  w3,
                                  Text(advName,style: R.textStyles.poppins(fontWeight: FontWeight.w600,color: R.appColors.appBarTitle),),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: ()async{
                                      if(widget.pairDevicesList != null){
                                        if(isConnected){
                                          Get.bottomSheet(ConfirmationBottomSheet(title: "are_you_sure_you_want_to_remove_this_device", yesTap: ()async{
                                            Get.back();
                                            await vm.bleService.disconnect();
                                            vm.bleService.connectedDevice = null;
                                            setState(() {

                                            });
                                          }));
                                        }else{
                                          Get.bottomSheet(
                                              PairingSheet(device: widget.pairDevicesList?[index].device,yesTap: ()async{
                                                Get.back();
                                                if(vm.bleService.connectedDevice != null){
                                                  await vm.bleService.disconnect();
                                                  vm.bleService.connectedDevice = null;
                                                }
                                                vm.bleService.connectedError = false;
                                                Get.dialog(PairingDialog(device: widget.pairDevicesList?[index].device));
                                                DeviceData deviceData = DeviceData(
                                                    assignedDeviceID:
                                                    widget.pairDevicesList?[index]
                                                        .device
                                                        .remoteId
                                                        .str,
                                                    customDeviceName: widget.pairDevicesList?[index]
                                                        .device
                                                        .platformName,
                                                    assignedDevice: widget.pairDevicesList?[index]
                                                        .device
                                                        .platformName);
                                                await vm.bleService.connectToDevice(widget.pairDevicesList![index].device, deviceData);
                                                if(!vm.bleService.connectedError){
                                                  Get.back();
                                                }
                                                Get.back();
                                              },)
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 0.8.h),
                                      decoration: BoxDecoration(
                                          color: R.appColors.secondaryColor,
                                          borderRadius: BorderRadius.circular(11)
                                      ),
                                      child: Text(isConnected ? "disconnect".L() : "pair".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.white,fontSize: 12.px),),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ;
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
