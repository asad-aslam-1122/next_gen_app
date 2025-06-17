import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_app_bar.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:nextgen_reeftech/features/home/presentation/pages/connect_wifi_view.dart';
import 'package:nextgen_reeftech/features/home/presentation/pages/import_properties_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../global/resources/resources.dart';
import '../widgets/wifi_animated_signals.dart';
import '../../../global/utils/timezone_utils.dart';
import '../../data/model/timezone_model.dart';

class DeviceSettingsView extends StatefulWidget {
  static String route = "/DeviceSettingsView";
  const DeviceSettingsView({super.key});

  @override
  State<DeviceSettingsView> createState() => _DeviceSettingsViewState();
}

class _DeviceSettingsViewState extends State<DeviceSettingsView> {
  // final List<TimezoneModel> result = TimezonesList().getTimezonesList();
  TimezoneModel? selectedTimeZone;
  String? ssId;
  final Connectivity _connectivity = Connectivity();
  bool isWifiConnected = false;
  bool shouldCheckCan = true;
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  int level = 0;
  String? bssId;

  @override
  void initState() {
    super.initState();
    ZBotToast.loadingShow();
    TimezoneUtils.getAllTimezones();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      try{
        ssId = await WiFiForIoTPlugin.getSSID();
        bssId = await WiFiForIoTPlugin.getBSSID();
        await initConnectivity();
        ZBotToast.loadingClose();
      }catch(e){
        ZBotToast.loadingClose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      backgroundColor: R.appColors.transparent,
        child: Scaffold(
          backgroundColor: R.appColors.backgroundColor,
          appBar: GlobalAppBar.customAppBar2(title: "device_settings",backGroundColor: R.appColors.backgroundColor),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
            child: Column(
              children: [
             isWifiConnected && bssId != null && ssId != null && accessPoints.isNotEmpty
                ? GestureDetector(
                  onTap: (){
                    Get.toNamed(ConnectWifiView.route);
                  },
                  child: wifiTileWidget(wifi: accessPoints.firstWhere(
                        (wifi) =>
                    wifi.bssid.toLowerCase() == bssId?.toLowerCase(),
                    orElse: () => accessPoints.first,
                  )))
              : GestureDetector(
                    onTap: (){
                      Get.toNamed(ConnectWifiView.route);
                    },
                    child: tileWidget(title: "connect_wifi")),
                h2,
                GestureDetector(
                    onTap: (){
                      Get.toNamed(ImportPropertiesView.route);
                    },
                    child: tileWidget(title: "import_properties")),
                h2,
                GestureDetector(
                    onTap: (){
                      SharePlus.instance.share(
                          ShareParams(
                              title: "Export Code",
                              text: "Export Code")
                      );
                    },
                    child: tileWidget(title: "export_properties")),
                h2,
                timeZoneTileWidget(title: "time_zone"),
                Spacer(),
                deviceConnectedError(),
                h2,
                deviceConnectedRedError(),
                h2,
              ],
            ),
          ),
        ));
  }

  // widgets

  // tile widget
  Widget tileWidget({required String title}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      decoration: BoxDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: R.appColors.shadowColor.withOpacity(0.1),blurRadius: 20)
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
          Icon(Icons.arrow_forward_ios_rounded,color: R.appColors.black,size: 17,),
        ],
      ),
    );
  }

  // time zone tile
  Widget timeZoneTileWidget({required String title}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      decoration: BoxDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: R.appColors.shadowColor.withOpacity(0.1),blurRadius: 20)
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.L(),style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
          w15,
          Expanded(child: timeZoneDropDown())
        ],
      ),
    );
  }

  // time zone dropdown
  Widget timeZoneDropDown(){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<TimezoneModel>(
        hint: Text("TimeZone",style: R.textStyles.poppins(color: R.appColors.grey,fontSize: 12.px),),
        isExpanded: true,
        value: selectedTimeZone,
          items: TimezoneUtils.allTimezones.map((e)
          => DropdownMenuItem<TimezoneModel>(value: e,child: Text(e.timezone ?? "",style: R.textStyles.poppins(color: R.appColors.primaryColor,fontSize: 12.px))),
          ).toList(),
        onChanged: (val) async{
          setState(() {
            selectedTimeZone = val;
          });
          TimezoneModel? timezone= await TimezoneUtils.getLatLngForTimezone(selectedTimeZone?.timezone??"");
         if(timezone!=null)
           {
             TimezoneUtils.getLocalSunTimes(timezone.timezone??"Asia/Karachi",timezone.lat??24.8607,timezone.lng??67.0011);
           }
        },
        selectedItemBuilder: (context){
          return TimezoneUtils.allTimezones.map((e)
          => DropdownMenuItem<TimezoneModel>(value: e,child: Container(width: Get.width/2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(e.timezone ?? "",
                    style: R.textStyles.poppins(color: R.appColors.primaryColor,fontSize: 12.px)),
              ))),
          ).toList();
        },
        buttonStyleData: ButtonStyleData(
          height: 30,
          padding: EdgeInsets.fromLTRB(0, 1.h, 2.w, 1.h),
          decoration: BoxDecoration(
            color: R.appColors.fillColor2,
            borderRadius: BorderRadius.circular(7)
          )
        ),
        iconStyleData: IconStyleData(
          iconSize: 20,
          openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded),
          icon: Icon(Icons.keyboard_arrow_down_rounded),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: R.appColors.black.withOpacity(0.08),
              ),
              BoxShadow(
                blurRadius: 6,
                color: R.appColors.black.withOpacity(0.02),
              ),
            ]
        )
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
        ),
      ),
    );
  }

  // device error
  Widget deviceConnectedError(){
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 4.w),
      decoration: BoxDecoration(
        color: R.appColors.lightGreen2,
        border: Border.all(color: R.appColors.green2),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("device_error".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w600,color: R.appColors.primaryColor),),
          h0P5,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("wifi_connected".L(),style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.primaryColor),),
              Icon(Icons.close,color: R.appColors.closeColor,size: 21,)
            ],
          ),
        ],
      ),
    );
  }

  // device error
  Widget deviceConnectedRedError(){
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 4.w),
      decoration: BoxDecoration(
          color: R.appColors.lightRed2,
          border: Border.all(color: R.appColors.red3),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("device_error".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w600,color: R.appColors.primaryColor),),
          h0P5,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("temp_probe".L(),style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.primaryColor),),
              Icon(Icons.close,color: R.appColors.closeColor,size: 21,)
            ],
          ),
          h1,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ntp".L(),style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.primaryColor),),
              Icon(Icons.close,color: R.appColors.closeColor,size: 21,)
            ],
          ),
          h1,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("led_temp".L(),style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.primaryColor),),
              Icon(Icons.check,color: R.appColors.closeColor,size: 21,)
            ],
          ),
          h1,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("servers_connection".L(),style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.primaryColor),),
              Icon(Icons.close,color: R.appColors.closeColor,size: 21,)
            ],
          ),
        ],
      ),
    );
  }

  Widget wifiTileWidget({required WiFiAccessPoint wifi}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      decoration: BoxDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: R.appColors.shadowColor.withOpacity(0.1),blurRadius: 20)
          ]
      ),
      child: Row(
        children: [
          SizedBox(height: 28,width: 28,child: WifiSignalIcon(strength: calculateBars(wifi.level))),
          w3,
          Column(
            crossAxisAlignment: CrossAxisAlignment
                .start,
            children: [
              Text(ssId??"",
                style: R.textStyles.poppins(
                    fontWeight: FontWeight.w500,
                    color: R.appColors
                        .primaryColor),),
              Text("connected".L(),
                style: R.textStyles.poppins(
                    fontSize: 12.px,
                    fontWeight: FontWeight.w500,
                    color: R.appColors
                        .greyLight),),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded,color: R.appColors.black,size: 17,),
        ],
      ),
    );
  }

  int calculateBars(int level) {
    // level is RSSI in dBm (e.g. results[i].level)
    if (level >= -55) return 4; // Excellent
    if (level >= -65) return 3; // Good
    if (level >= -75) return 2; // Fair
    if (level >= -85) return 1; // Weak
    return 0; // Very weak / no signal
  }

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result = [ConnectivityResult.none];
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      ZBotToast.showToastError(message: e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    switch (result.first) {
      case ConnectivityResult.wifi:
        {
          isWifiConnected = true;
          _getScannedResults(context);
          setState(() {

          });
        }
        break;
      case ConnectivityResult.none:
        {
          isWifiConnected = false;
          setState(() {

          });
        }
        break;
      default:
        break;
    }
  }

  Future<void> _getScannedResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      // get scanned results
      List<WiFiAccessPoint> results = await WiFiScan.instance
          .getScannedResults();
      setState(() => accessPoints = results);
    }
  }

  Future<bool> _canGetScannedResults(BuildContext context) async {
    if (shouldCheckCan) {
      // check if can-getScannedResults
      final can = await WiFiScan.instance.canGetScannedResults();
      // if can-not, then show error
      if (can != CanGetScannedResults.yes) {
        if (context.mounted) {
          ZBotToast.showToastError(message: "Cannot get scanned results: $can");
        }
        accessPoints = <WiFiAccessPoint>[];
        return false;
      }
    }
    return true;
  }

}
