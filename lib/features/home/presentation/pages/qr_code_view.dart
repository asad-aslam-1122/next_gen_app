import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../global/resources/bot_toast/zbot_toast.dart';

class QRCodeView extends StatefulWidget {
  static String route = "/QRCodeView";
  const QRCodeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCodeViewState();
}

class _QRCodeViewState extends State<QRCodeView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  StreamSubscription? _scanSubscription;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
    (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    _scanSubscription = controller.scannedDataStream.listen((scanData) async{
        result = scanData;
        Map<String,dynamic> str = wifiCode(result?.code??"");
        await connectWifi(str['password'], str['ssid']);
        setState(() {

        });
    });
  }

  Future<void> connectWifi(String password,String ssid)async{
    Get.back();
    try{
      ZBotToast.loadingShow();
      print(">>> CHECK ${ssid} and ${password}");
      bool result = await WiFiForIoTPlugin.connect(
        ssid,
        password: password,
      );
      ZBotToast.loadingClose();
      if(result){
        ZBotToast.showToastSuccess(message: "Connected to ${ssid} successfully");
      }else{
        ZBotToast.showToastError(message: "Failed to connect to ${ssid}");
      }
    }catch(e){
      ZBotToast.showToastError(message: "error: ${e.toString()}");
    }
  }

  Map<String,dynamic> wifiCode(String qr) {
    final regex = RegExp(r'WIFI:S:(.*?);T:(.*?);P:(.*?);(?:H:(.*?);;|;;)');
    RegExpMatch? match = regex.firstMatch(qr);
    return match != null ? {
      "ssid": Uri.decodeFull(match.group(1)??""),
      "type": match.group(2)??"",
      "password": Uri.decodeFull(match.group(3)??""),
      "hidden": match.groupCount >= 4 && match.group(4) == 'true',
    } : {};
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }
}
