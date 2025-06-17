import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/core/empty_view.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_app_bar.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/image_picker/image_widget.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/pop_scope_widget.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:nextgen_reeftech/features/home/presentation/pages/device_settings_view.dart';
import 'package:nextgen_reeftech/features/home/presentation/pages/find_devices_view.dart';
import 'package:nextgen_reeftech/features/home/presentation/provider/home_vm.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/modes_view.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_base_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../global/constants/app_user.dart';
import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../data/model/device_data.dart';
import '../widgets/pairing_dialog.dart';
import '../widgets/pairing_sheet.dart';

class HomeView extends StatefulWidget {
  static String route = "/HomeView";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      if(!(await FlutterBluePlus.isOn)){
        await FlutterBluePlus.turnOn();
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return PopScopeWidget.onPop(
      child: SafeAreaWidget(
          backgroundColor: R.appColors.transparent,
          top:true,
          child: Consumer<HomeVM>(
            builder: (context, vm, _) {

              final bool hasConnectedDevice = vm.bleService.connectedDevice != null;
              // final bool hasDisconnectedDevices = vm.bleService
              //     .devicesList
              //     .any((e) => !e.device.isConnected);

              return Scaffold(
                backgroundColor: R.appColors.backgroundColor,
                // appBar: GlobalAppBar.customAppBar2(title: "",backGroundColor: R.appColors.backgroundColor,isTranslate: true,leadingWidth: 200,
                //     leading: Padding(
                //   padding: EdgeInsets.only(top: 1.h),
                //   child: Image.asset(R.appImages.logo,height: 55),
                // ),
                //   actions: [
                //     Padding(
                //       padding: EdgeInsets.only(right: 4.w,top:1.h),
                //       child: GestureDetector(
                //         onTap: (){
                //           Get.toNamed(ProfileBaseView.route);
                //         },
                //         child: ImageWidget(
                //           height: 60,
                //           width: 60,
                //           isAddIcon: false,
                //           isEnable: false,
                //           grey: R.appColors.transparent,
                //           backgroundColor: R.appColors.white,
                //           isFile: AppUser.userData?.image != null && AppUser.userData?.image!=""? true : false,
                //           pickedFile: File(AppUser.userData?.image ?? ""),
                //         ),
                //       ),
                //     ),
                //   ]
                // ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      h2,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(R.appImages.logo,height: 55),
                          Padding(
                            padding: EdgeInsets.only(right: 4.w,top:1.h),
                            child: GestureDetector(
                              onTap: (){
                                Get.toNamed(ProfileBaseView.route);
                              },
                              child: ImageWidget(
                                height: 40,
                                width: 40,
                                isAddIcon: false,
                                isEnable: false,
                                grey: R.appColors.transparent,
                                backgroundColor: R.appColors.white,
                                isFile: AppUser.userData?.image != null && AppUser.userData?.image!=""? true : false,
                                pickedFile: File(AppUser.userData?.image ?? ""),
                              ),
                            ),
                          ),
                        ],
                      ),
                      h2,
                      addDeviceWidget(),
                      h2,
                      if(!hasConnectedDevice && vm.bleService.disconnectedDevicesList.isEmpty)...[
                        Expanded(child: EmptyView(iconPath: R.appImages.bluetooth, title: "no_device_found".L(), subTitle: "please_turn_on_Bluetooth_to_connect".L()))
                      ]
                      else...[
                        if(hasConnectedDevice) connectedDeviceWidget(vm),
                        h2,
                        if(vm.bleService.disconnectedDevicesList.isNotEmpty) disconnectedDeviceWidget(vm),
                      ]
                    ],
                  ),
                ),
              );
            }
          )
      ),
    );
  }

  // widgets

  // add device widget
  Widget addDeviceWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      decoration: BoxDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 20,
              color: R.appColors.shadowColor.withOpacity(0.1)
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("add_device".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w600,color: R.appColors.primaryColor),),
              Text("add_a_Bluetooth_device_to_proceed".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w600,fontSize: 10.px,color: R.appColors.greyLight),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              Get.toNamed(FindDevicesView.route);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.7.w,vertical: 0.8.h),
              decoration: BoxDecoration(
                color: R.appColors.secondaryColor,
                borderRadius: BorderRadius.circular(11)
              ),
              child: Row(
                children: [
                  Icon(Icons.add,color: R.appColors.white,size: 15,),
                  Text("add".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.white,fontSize: 12.px),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // connected device widget
  Widget connectedDeviceWidget(HomeVM vm){
    return Container(
      width: Get.width,
      padding: EdgeInsets.fromLTRB(4.w, 1.5.h, 4.w, 1.h),
      decoration: BoxDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 20,
              color: R.appColors.shadowColor.withOpacity(0.1)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("connected_device".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w600,color: R.appColors.primaryColor),),
         Padding(
              padding: EdgeInsets.symmetric(vertical: 1.3.h),
              child: connectedDevice(model: vm.bleService.connectedDevice!,isConnected: true))
        ],
      )
    );
  }

  // disconnect device widget
  Widget disconnectedDeviceWidget(HomeVM vm){
    return Container(
        width: Get.width,
        padding: EdgeInsets.fromLTRB(4.w, 1.5.h, 4.w, 1.h),
        decoration: BoxDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                color: R.appColors.shadowColor.withOpacity(0.1)
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("disconnected_device".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w600,color: R.appColors.primaryColor),),
            h0P5,
            ...List.generate(vm.bleService.disconnectedDevicesList.length, (index){
              List<BluetoothDevice> list = vm.bleService.disconnectedDevicesList;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 1.3.h),
                child: disConnectedDevice(model: list[index],isConnected: false,vm: vm),
              );
            })
          ],
        )
    );
  }

  // device widget
  Widget connectedDevice({required BluetoothDevice model, required bool isConnected}){
    return Row(
      children: [
        Expanded(
          flex: 13,
          child: GestureDetector(
            onTap: (){
              Get.toNamed(ModesView.route);
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: R.appColors.secondaryColor,
                      shape: BoxShape.circle
                  ),
                  child: Image.asset(R.appImages.device,height: 24,width: 24,),
                ),
                w3,
                Expanded(
                  flex: 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.advName,style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
                      Row(
                        children: [
                          Text("connected".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,fontSize: 12.px,color: R.appColors.greyLight),),
                            w2,
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                              decoration: BoxDecoration(
                                  color: R.appColors.lightRed,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                        color: R.appColors.red2,
                                        shape: BoxShape.circle
                                    ),
                                  ),w2,
                                  Text("error".L(),style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.red2),),
                                ],
                              ),
                            ),
                            w1,
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                              decoration: BoxDecoration(
                                  color: R.appColors.lightGreen,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                        color: R.appColors.green,
                                        shape: BoxShape.circle
                                    ),
                                  ),w2,
                                  Text("error".L(),style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.green),),
                                ],
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        w2,
        Container(
          width: 1,
          height: 24,
          decoration: BoxDecoration(
              color: R.appColors.separatorColor
          ),
        ),
        w2,
        Expanded(flex: 2,child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
              onTap: (){
                Get.toNamed(DeviceSettingsView.route);
              },
              child: Image.asset(R.appImages.setting,height: 24,width: 24,color: R.appColors.secondaryColor,)),
        ))
      ],
    );
  }

  Widget disConnectedDevice({required BluetoothDevice model, required bool isConnected,required HomeVM vm}){
    return Row(
      children: [
        Expanded(
          flex: 13,
          child: GestureDetector(
            onTap: (){
              Get.bottomSheet(
                  PairingSheet(device: model,yesTap: ()async{
                    Get.back();
                    if(vm.bleService.connectedDevice != null){
                      await vm.bleService.disconnect();
                      vm.bleService.connectedDevice = null;
                    }
                    Get.dialog(PairingDialog(device: model));
                    DeviceData deviceData = DeviceData(
                        assignedDeviceID:
                        model
                            .remoteId
                            .str,
                        customDeviceName: model
                            .platformName,
                        assignedDevice: model
                            .platformName);
                    await vm.bleService.connectToDevice(model, deviceData);
                    Get.back();
                  },)
              );
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: R.appColors.disconnectColor,
                      shape: BoxShape.circle
                  ),
                  child: Image.asset(R.appImages.device,height: 24,width: 24,),
                ),
                w3,
                Expanded(
                  flex: 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.advName,style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
                      Text("disconnected".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,fontSize: 12.px,color: R.appColors.greyLight),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        w2,
        Container(
          width: 1,
          height: 24,
          decoration: BoxDecoration(
              color: R.appColors.separatorColor
          ),
        ),
        w2,
        Expanded(flex: 2,child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Image.asset(R.appImages.setting,height: 24,width: 24,color: R.appColors.subTitleGrey),
        ))
      ],
    );
  }
}
