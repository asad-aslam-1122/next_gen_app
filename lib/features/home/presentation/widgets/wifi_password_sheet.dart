import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/bot_toast/zbot_toast.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';
import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/app_validator.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/safe_area_widget.dart';

class WifiPasswordSheet extends StatefulWidget {
  WiFiAccessPoint wifi;
  WifiPasswordSheet({super.key, required  this.wifi});

  @override
  State<WifiPasswordSheet> createState() => _WifiPasswordSheetState();
}

class _WifiPasswordSheetState extends State<WifiPasswordSheet> {

  TextEditingController passwordTC = TextEditingController();
  FocusNode passwordFN = FocusNode();
  bool isVisible = false;

  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      backgroundColor: R.appColors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              h2,
              Text("android_wifi".L(),style: R.textStyles.poppins(fontSize: 16.px,fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
              h2,
              passwordField(),
              h2,
              CustomButton(onPressed: ()async{
                if(_key.currentState?.validate() ?? false){
                  try{
                    ZBotToast.loadingShow();
                    bool result = await WiFiForIoTPlugin.connect(
                        widget.wifi.ssid,
                        password: passwordTC.text.trim(),
                      bssid: widget.wifi.bssid,
                      security: _getSecurityType(widget.wifi.capabilities)
                    );
                    ZBotToast.loadingClose();
                    if(result){
                      await Future.delayed(Duration(seconds: 3));
                      await WiFiForIoTPlugin.forceWifiUsage(true);
                      Get.back();
                      ZBotToast.showToastSuccess(message: "Connected to ${widget.wifi.ssid} successfully");
                    }else{
                      ZBotToast.showToastError(message: "Failed to connect to ${widget.wifi.ssid}");
                    }
                  }catch(e){
                    ZBotToast.showToastError(message: "error: ${e.toString()}");
                  }
                }
              }, title: "connect"),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordTC,
      focusNode: passwordFN,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscuringCharacter: "*",
      obscureText: !isVisible,
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_password",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
        suffixIcon: IconButton(
          onPressed: () {
            isVisible = !isVisible;
            setState(() {});
          },
          icon: Image.asset(
            isVisible ? R.appImages.visibilityOff : R.appImages.visibilityOn,
            scale: 4.5,
            color:
            passwordFN.hasFocus
                ? R.appColors.secondaryColor
                : R.appColors.grey,
          ),
        ),
      ),
      onTapOutside: (v) {
        passwordFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(passwordFN);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: AppValidator.validateWifiPassword,
    );
  }

  NetworkSecurity _getSecurityType(String capabilities) {
    if (capabilities.contains("WPA2")) return NetworkSecurity.WPA;
    if (capabilities.contains("WPA")) return NetworkSecurity.WPA;
    if (capabilities.contains("WEP")) return NetworkSecurity.WEP;
    return NetworkSecurity.NONE;
  }

}

class WifiNative {
  static const MethodChannel _channel =
  MethodChannel('channelname/wifiworks');

  /// Connects to Wi‑Fi with the given SSID; returns the Int from getTest()
  static Future<String> connectNative(String ssid,String password) async {
    try {
      final String result =
      await _channel.invokeMethod('getTest', {'SSID': ssid,'password': password});
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to connect: ${e.message}';
    }
  }

  /// Disconnects from Wi‑Fi; returns the Int from disconnect()
  static Future<int> disconnectNative() async {
    try {
      final int result = await _channel.invokeMethod('dc');
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to disconnect: ${e.message}';
    }
  }
}
