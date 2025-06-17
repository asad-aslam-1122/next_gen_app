import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/core/empty_view.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/bot_toast/zbot_toast.dart';
import 'package:nextgen_reeftech/features/home/presentation/pages/qr_code_view.dart';
import 'package:nextgen_reeftech/features/home/presentation/widgets/wifi_animated_signals.dart';
import 'package:sizer/sizer.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';
import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/global_app_bar.dart';
import '../../../global/utils/global_widgets/safe_area_widget.dart';
import '../widgets/wifi_password_sheet.dart';

class ConnectWifiView extends StatefulWidget {
  static String route = "/ConnectWifiView";
  const ConnectWifiView({super.key});

  @override
  State<ConnectWifiView> createState() => _ConnectWifiViewState();
}

class _ConnectWifiViewState extends State<ConnectWifiView> {

  final Connectivity _connectivity = Connectivity();
  bool isWifiConnected = false;
  bool shouldCheckCan = true;
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  String? ssId;
  int? level;
  String? bssId;

  @override
  void initState() {
    super.initState();
    ZBotToast.loadingShow();
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
          appBar: GlobalAppBar.customAppBar2(title: "connect_wifi",
              backGroundColor: R.appColors.backgroundColor,
            actions: [
              GestureDetector(
                  onTap: (){
                    Get.toNamed(QRCodeView.route);
                  },
                  child: Image.asset(R.appImages.scan,height: 24,width: 24,)),
              w4,
            ]
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              children: [
                if(!isWifiConnected)...[
                  Expanded(child: EmptyView(iconPath: R.appImages.wifi,
                      title: "wifi_turned_off".L(),
                      subTitle: "please_turn_on_wifi_to_connect".L()))
                ] else
                  ...[
                   if(ssId != null && bssId != null) Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: R.appColors.white.withOpacity(0.7),
                        border: Border.all(color: R.appColors.secondaryColor)
                      ),
                      child: connectedWifiWidget(),
                    ),
                    h2,
                    if(accessPoints.isNotEmpty) Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            color: R.appColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: R.appColors.shadowColor.withOpacity(
                                      0.1),
                                  blurRadius: 20
                              )
                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('available_networks'.L(),style: R.textStyles.poppins(fontWeight: FontWeight.w600,color: R.appColors.primaryColor),),
                            h1,
                            Flexible(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                      accessPoints.length, (index) {
                                    WiFiAccessPoint wifi = accessPoints[index];
                                    return wifiTileWidget(wifi: wifi);
                                  })
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
              ],
            ),
          ),
        ));
  }


  // wifi tile widget
  Widget wifiTileWidget({required WiFiAccessPoint wifi}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Row(
        children: [
          SizedBox(height: 28,width: 28,child: WifiSignalIcon(strength: calculateBars(wifi.level))),
          w3,
          Column(
            crossAxisAlignment: CrossAxisAlignment
                .start,
            children: [
              Text(wifi.ssid,
                style: R.textStyles.poppins(
                    fontWeight: FontWeight.w500,
                    color: R.appColors
                        .primaryColor),),
              Row(
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                mainAxisAlignment: MainAxisAlignment
                    .start,
                children: [
                  Text("Secured",
                    style: R.textStyles.poppins(
                        fontSize: 12.px,
                        fontWeight: FontWeight.w500,
                        color: R.appColors
                            .greyLight),),
                  w2,
                  Container(
                    height: 3,
                    width: 3,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: R.appColors.greyLight
                    ),
                  ),
                  w2,
                  Text(getBand(wifi.frequency),
                    style: R.textStyles.poppins(
                        fontSize: 12.px,
                        fontWeight: FontWeight.w500,
                        color: R.appColors
                            .greyLight),),
                ],
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              Get.bottomSheet(WifiPasswordSheet(wifi: wifi));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.7.w, vertical: 1.h),
              decoration: BoxDecoration(
                  color: R.appColors.secondaryColor,
                  borderRadius: BorderRadius.circular(
                      10)
              ),
              child: Text("connect".L(),
                style: R.textStyles.poppins(
                    fontWeight: FontWeight.w500,
                    color: R.appColors.white,
                    fontSize: 12.px),),
            ),
          ),
        ],
      ),
    );
  }

  Widget connectedWifiWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          SizedBox(height: 28,width: 28,child: WifiSignalIcon(strength: calculateBars(accessPoints.isNotEmpty ? accessPoints.firstWhere(
                (wifi) =>
            wifi.bssid.toLowerCase() == bssId?.toLowerCase(),
            orElse: () => accessPoints.first,
          ).level : 0))),
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
          GestureDetector(
            onTap: ()async{
              try{
                ZBotToast.loadingShow();
                bool result = await WiFiForIoTPlugin.disconnect();
                ZBotToast.loadingClose();
                if(result){
                  ZBotToast.showToastSuccess(message: "Disconnected successfully");
                }else{
                  ZBotToast.showToastError(message: "Failed to Disconnect");
                }
              }catch(e){
                ZBotToast.showToastError(message: "error: ${e.toString()}");
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.7.w, vertical: 1.h),
              decoration: BoxDecoration(
                  color: R.appColors.transparent,
                  border: Border.all(color: R.appColors.secondaryColor),
                  borderRadius: BorderRadius.circular(
                      10)
              ),
              child: Text("disconnect".L(),
                style: R.textStyles.poppins(
                    fontWeight: FontWeight.w500,
                    color: R.appColors.secondaryColor,
                    fontSize: 12.px),),
            ),
          ),
        ],
      ),
    );
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

  Future<void> _getScannedResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      // get scanned results
      List<WiFiAccessPoint> results = await WiFiScan.instance
          .getScannedResults();
      List<WiFiAccessPoint> notEmptyResult = results
          .where((wifi) => wifi.ssid.isNotEmpty && wifi.ssid.trim().isNotEmpty)
          .toList();
      setState(() => accessPoints = notEmptyResult);
    }
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

  String getBand(int frequency) {
    if (frequency >= 2400 && frequency <= 2500) {
      return "2.4 GHz";
    } else if (frequency >= 4900 && frequency <= 5900) {
      return "5 GHz";
    } else if (frequency >= 5925 && frequency <= 7125) {
      return "6 GHz";
    } else {
      return '${frequency} MHz';
    }
  }

}