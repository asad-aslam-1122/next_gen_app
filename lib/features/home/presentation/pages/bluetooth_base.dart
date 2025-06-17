// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:get/get.dart';
// import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../global/resources/resources.dart';
// import '../../../global/utils/global_widgets/safe_area_widget.dart';
//
// class BluetoothBasePage extends StatefulWidget {
//   static String route = "/BluetoothBasePage";
//   const BluetoothBasePage({super.key});
//
//   @override
//   State<BluetoothBasePage> createState() => _BluetoothBasePageState();
// }
//
// class _BluetoothBasePageState extends State<BluetoothBasePage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       context.read<BasePagesSectionProvider>().bleService.startScan();
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BasePagesSectionProvider>(
//       builder: (context, themeColor, child) {
//         return SafeAreaWidget(
//           child: Scaffold(
//             backgroundColor: themeColor.themeModel.themeColor,
//             appBar: AppBar(
//               backgroundColor: themeColor.themeModel.themeColor,
//               surfaceTintColor: themeColor.themeModel.themeColor,
//               centerTitle: true,
//               leading: IconButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: R.appColors.white,
//                   )),
//               title: Text(
//                 "add_device".L(),
//                 style: R.textStyles.poppins(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w500,
//                     color: R.appColors.white),
//               ),
//             ),
//             body: Container(
//               height: 100.h,
//               width: 100.w,
//               padding: const EdgeInsets.all(20),
//               decoration: R.decoration
//                   .topRadius(radius: 30, backgroundColor: R.appColors.white),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     if (themeColor.bleService.isBluetoothEnabled == false)
//                       bluetoothWidget(
//                           themeColor: themeColor,
//                           title: "bluetooth_turned_off",
//                           subtitle: "please_turn_on_bluetooth_to_connect"),
//                     if (themeColor.bleService.hasScanning == true &&
//                         themeColor.bleService.isBluetoothEnabled == true)
//                       bluetoothAnimationWidget(
//                           title: "searching",
//                           subtitle:
//                           "scanning_for_nearby_devices_make_sure_your_device_is_powered_on_and_in_pairing_mode_to_connect"),
//                     if (themeColor.bleService.devicesList.isNotEmpty &&
//                         themeColor.bleService.hasScanning == false &&
//                         themeColor.bleService.isBluetoothEnabled == true) ...[
//                       Image.asset(
//                         R.appImages.bluetoothConnectionIcon,
//                         height: 160,
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           child: Text(
//                             "available_devices".L(),
//                             style: R.textStyles.poppins(
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: R.appColors.textGreyColor),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListView.separated(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           shrinkWrap: true,
//                           itemCount: themeColor.bleService.devicesList.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 3),
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     themeColor.bleService.devicesList[index]
//                                         .device.platformName ??
//                                         "",
//                                     textAlign: TextAlign.center,
//                                     style: R.textStyles.poppins(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 14.sp),
//                                   ),
//                                   GlobalWidgets.smallCustomButton(
//                                       horizontalPad: 15,
//                                       verticalPad: 5,
//                                       textColor:
//                                       themeColor.themeModel.themeColor,
//                                       backGroundColor: themeColor
//                                           .themeModel.themeColor
//                                           .withOpacity(0.3),
//                                       title: "pair",
//                                       onPressed: () async {
//                                         ZBotToast.loadingShow();
//                                         DeviceData deviceData = DeviceData(
//                                             assignedDeviceID: themeColor
//                                                 .bleService
//                                                 .devicesList[index]
//                                                 .device
//                                                 .remoteId
//                                                 .str,
//                                             customDeviceName: themeColor
//                                                 .bleService
//                                                 .devicesList[index]
//                                                 .device
//                                                 .platformName,
//                                             assignedDevice: themeColor
//                                                 .bleService
//                                                 .devicesList[index]
//                                                 .device
//                                                 .platformName);
//                                         await themeColor.bleService
//                                             .connectToDevice(
//                                             themeColor.bleService
//                                                 .devicesList[index].device,
//                                             deviceData,
//                                             isDiscoverServices: false);
//                                         ZBotToast.loadingClose();
//
//                                         if (themeColor.bleService
//                                             .connectedDevice?.isConnected ??
//                                             false) {
//                                           Get.offAndToNamed(
//                                               CompleteSetupDevice.route,
//                                               arguments: {
//                                                 "isEditAble": false,
//                                                 "deviceModel": deviceData
//                                               });
//                                         }
//                                       })
//                                 ],
//                               ),
//                             );
//                           },
//                           separatorBuilder: (BuildContext context, int index) =>
//                               Divider(
//                                 color: R.appColors.black.withOpacity(0.2),
//                               ),
//                         ),
//                       )
//                     ],
//                     if (themeColor.bleService.devicesList.isEmpty &&
//                         themeColor.bleService.hasScanning == false &&
//                         themeColor.bleService.isBluetoothEnabled == true)
//                       bluetoothWidget(
//                           themeColor: themeColor,
//                           title: "no_device_found",
//                           subtitle: "please_turn_on_bluetooth_to_connect")
//                   ],
//                 ),
//               ),
//             ),
//             bottomNavigationBar: themeColor.bleService.isBluetoothEnabled &&
//                 !themeColor.bleService.hasScanning
//                 ? Container(
//               color: R.appColors.white,
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20, vertical: 15),
//               child: CustomButton(
//                   onPressed: () {
//                     themeColor.bleService.startScan();
//                   },
//                   title: "try_again"),
//             )
//                 : null,
//           ),
//         );
//       },
//     );
//   }
//
//   Widget bluetoothWidget(
//       {required BasePagesSectionProvider themeColor,
//         required String title,
//         required String subtitle}) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () async {
//             if (Platform.isAndroid) {
//               await FlutterBluePlus.turnOn();
//             }
//             themeColor.bleService.startScan();
//           },
//           child: Image.asset(
//             R.appImages.bluetoothConnectionIcon,
//             height: 160,
//             color: (!themeColor.bleService.isBluetoothEnabled ||
//                 themeColor.bleService.devicesList.isEmpty)
//                 ? R.appColors.iconsGreyColor
//                 : null,
//           ),
//         ),
//         Text(
//           title.L(),
//           style: R.textStyles
//               .poppins(fontSize: 20.sp, fontWeight: FontWeight.w600),
//         ),
//         Text(
//           subtitle.L(),
//           textAlign: TextAlign.center,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           style: R.textStyles.poppins(
//             color: R.appColors.textGreyColor,
//             fontSize: 15.sp,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget bluetoothAnimationWidget(
//       {required String title, required String subtitle}) {
//     return Column(
//       children: [
//         Lottie.asset(R.appImages.bluetoothAnimation, height: 185),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title.L(),
//               style: R.textStyles
//                   .poppins(fontSize: 20.sp, fontWeight: FontWeight.w600),
//             ),
//             Image.asset(
//               R.appImages.loadingDots,
//               color: R.appColors.black,
//               height: 50,
//               width: 30,
//             ),
//           ],
//         ),
//         Text(
//           subtitle.L(),
//           textAlign: TextAlign.center,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           style: R.textStyles.poppins(
//             color: R.appColors.textGreyColor,
//             fontSize: 15.sp,
//           ),
//         ),
//       ],
//     );
//   }
// }
