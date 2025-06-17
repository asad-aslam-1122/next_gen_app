import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import '../../home/data/model/device_data.dart';
import '../resources/bot_toast/zbot_toast.dart';

class BleService {

  BluetoothDevice? connectedDevice;
  bool connectedError = false;
  List<ScanResult> devicesList = [];
  List<BluetoothDevice> disconnectedDevicesList = [];
  bool hasScanning = false;
  bool isBluetoothEnabled = false;
  StreamSubscription? _streamSubscription;

  ValueNotifier<bool> isConnected = ValueNotifier(false);

  Future<void> startScan() async {
    devicesList.clear();

    _streamSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async{
      log("BluetoothAdapterState:${state}");
      if (state == BluetoothAdapterState.on) {
        isBluetoothEnabled = true;
        hasScanning = true;
        await FlutterBluePlus.startScan(
          timeout: Duration(seconds: 10),
        );
        var subscription=  FlutterBluePlus.scanResults.listen((results) async {
          Future.delayed(Duration(seconds: 10), () {
            hasScanning = false;
            Get.forceAppUpdate();
          });

            results
                .toList()
                .asMap()
                .forEach((index, result) {
              log("element.device.platformName:${result.device.advName}");
              if (!devicesList.contains(result)) {
                if(result.device.advName.isNotEmpty){
                  devicesList.add(result);
                }
              }
            });
        });

        // cleanup: cancel subscription when scanning stops
        FlutterBluePlus.cancelWhenScanComplete(subscription);
        _streamSubscription?.cancel();
        _streamSubscription = null;

      } else {
        isBluetoothEnabled = false;
        await FlutterBluePlus.turnOn();
        await startScan();
      }
    });
    // subscription.cancel();

  }

  Future<void> connectToDevice(BluetoothDevice device,DeviceData deviceData,{bool isDiscoverServices=true}) async {
    try {
      await device.connect(autoConnect: false);
      connectedDevice = device;
      connectedDevice?.connectionState.listen((onData){
        log("connectionState:${onData}");
        if(onData==BluetoothConnectionState.connected)
        {
          if(disconnectedDevicesList.contains(connectedDevice)){
            disconnectedDevicesList.removeWhere((element) => element.remoteId == connectedDevice?.remoteId,);
          }
          ZBotToast.showToastSuccess(message: "paired_successfully".L());
          isConnected.value=true;
        }
        else{
          isConnected.value=false;

        }
        Get.forceAppUpdate();

      });


      ZBotToast.loadingClose();
    } on Exception catch (e) {
      connectedError = true;
      ZBotToast.loadingClose();

      log("CONNECTION EXCEPTION:${e.toString()}");
      if(e.toString().contains("bluetooth must be turned on")==true)
      {
        if (Platform.isAndroid) {
          await FlutterBluePlus.turnOn();
          await startScan().whenComplete(() async {
            await Future.delayed(Duration(seconds: 5), () async {
              log("hasScanning:${hasScanning}");
              if(hasScanning==false && isBluetoothEnabled==true)
              {
                log("evice.remoteId:${device.remoteId}");
                if(devicesList.any((e)=>e.device.remoteId==device.remoteId))
                {
                  log("MATCHED DEVICES");
                  await disconnect();
                  await connectToDevice(device,deviceData);
                }
                else{
                  ZBotToast.showToastError(message: "device_not_available".L());
                }
              }
            });

          });

        }
      }
      else{
        ZBotToast.showToastError(message: "${"unable_to_connect".L()}");
      }
    }
  }

  Future<void> disconnect() async {
    await connectedDevice?.disconnect();
    await connectedDevice?.removeBond();
    if(connectedDevice != null && (!disconnectedDevicesList.contains(connectedDevice))){
      disconnectedDevicesList.add(connectedDevice!);
    }
  }
}