import 'package:flutter/material.dart';
import '../../../global/services/bluetooth_service.dart';

class HomeVM extends ChangeNotifier{

  BleService bleService = BleService();

  Future<void> startBleService()async{
    await bleService.startScan();
    update();
  }

  update(){
    notifyListeners();
  }
}