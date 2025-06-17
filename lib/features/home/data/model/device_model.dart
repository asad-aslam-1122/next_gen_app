import '../../../global/constants/enums.dart';

class DeviceModel{
  String? name;
  DeviceStatus? deviceStatus;
  bool? genericError,criticalError;
  DeviceModel({this.name,this.deviceStatus,this.genericError,this.criticalError});
}