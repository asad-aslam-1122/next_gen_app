class DeviceData {
  DeviceData({
    this.assignedDevice,
    this.customDeviceName,
    this.assignedChild,
    this.assignedChildID,
    this.assignedVehicle,
    this.assignedVehicleID,
    this.id,
    this.uid,
    this.deviceBatteryStatus,
    this.assignedDeviceID,
    this.isConnected = false,
    this.pressure,
    this.temperature,
    this.humidity,
  });
  DeviceData.fromJson(dynamic json) {
    uid = json['uid'];
    id = json['id'];
    assignedDevice = json['assigned_device'];
    assignedDeviceID = json['assigned_device_id'];
    customDeviceName = json['custom_device_name'];
    assignedChild = json['assigned_child'];
    assignedChildID = json['assigned_child_id'];
    assignedVehicle = json['assigned_vehicle'];
    assignedVehicleID = json['assigned_vehicle_id'];
  }
  String? assignedDevice;
  String? assignedDeviceID;
  String? customDeviceName;
  String? assignedChild;
  String? assignedChildID;
  String? assignedVehicle;
  String? assignedVehicleID;
  String? id;
  String? uid;
  int? deviceBatteryStatus;
  bool? isConnected;
  double? pressure;
  double? temperature;
  double? humidity;
  DeviceData copyWith({
    String? assignedDevice,
    String? assignedDeviceID,
    String? customDeviceName,
    String? assignedChild,
    String? assignedChildID,
    String? assignedVehicle,
    String? assignedVehicleID,
    String? id,
    String? uid,
    int? deviceBatteryStatus,
    bool? isConnected,
  }) => DeviceData(
    isConnected: isConnected ?? this.isConnected,
    assignedDevice: assignedDevice ?? this.assignedDevice,
    assignedDeviceID: assignedDeviceID ?? this.assignedDeviceID,
    customDeviceName: customDeviceName ?? this.customDeviceName,
    assignedChild: assignedChild ?? this.assignedChild,
    assignedChildID: assignedChildID ?? this.assignedChildID,
    assignedVehicle: assignedVehicle ?? this.assignedVehicle,
    assignedVehicleID: assignedVehicleID ?? this.assignedVehicleID,
    id: id ?? this.id,
    uid: uid ?? this.uid,
    deviceBatteryStatus: deviceBatteryStatus ?? this.deviceBatteryStatus,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['assigned_device_id'] = assignedDeviceID;
    map['assigned_device'] = assignedDevice;
    map['custom_device_name'] = customDeviceName;
    map['assigned_child'] = assignedChild;
    map['assigned_child_id'] = assignedChildID;
    map['assigned_vehicle'] = assignedVehicle;
    map['assigned_vehicle_id'] = assignedVehicleID;
    map['uid'] = uid;
    map['id'] = id;
    return map;
  }
}
