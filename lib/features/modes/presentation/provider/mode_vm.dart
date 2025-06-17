import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextgen_reeftech/features/modes/data/model/channel_model.dart';

import '../../../global/resources/resources.dart';
import '../../data/model/chart_data.dart';
import '../../data/model/color_label_model.dart';

class ModeVM extends ChangeNotifier {
  double scheduleIntensity=0;
  double moonLightBrightness=0;
  int day = 0;
  PageController scheduleController=PageController();
  ChartData? currentChartPoint;
   List<ChartData> data = [
    ChartData(time:'00:00', pointIntensity: null),
    ChartData(time:'08:00', pointIntensity:null),
    ChartData(time:'10:00', pointIntensity:null),
    ChartData(time:'14:00', pointIntensity:null),
    ChartData(time:'18:00', pointIntensity:null),
    ChartData(time:'22:00', pointIntensity:null),
  ];
  List<ChannelModel> channels=[
    ChannelModel(title: "Channel 1",id: 0),
    ChannelModel(title: "Channel 2",id: 1),
    ChannelModel(title: "Channel 3",id: 2),
    ChannelModel(title: "Channel 4",id: 3),
    ChannelModel(title: "Channel 5",id: 4),
    ChannelModel(title: "Channel 6",id: 5),
  ];
  final List<ColorOption> colorOptions = [
    ColorOption(label:'Royal Blue',color: R.appColors.royalBlue,id:0),
    ColorOption(label:'Full Spec',color: R.appColors.fullSpec,id:1),
    ColorOption(label:'White', color:Colors.white,id:2),
    ColorOption(label:'Cyan', color:R.appColors.cyan,id:3),
    ColorOption(label:'UV', color:R.appColors.uv,id:4),
  ];
  // List<ChannelModel>  savedChannels=[
  //   ChannelModel(title: "Channel 1",color:  ColorOption(label:'Royal Blue',color: R.appColors.royalBlue,id:0),),
  //   ChannelModel(title: "Channel 2",color:ColorOption(label:'Full Spec',color: R.appColors.fullSpec,id:1),),
  //   ChannelModel(title: "Channel 3",color:ColorOption(label:'White', color:Colors.white,id:2),),
  //   ChannelModel(title: "Channel 4",color: ColorOption(label:'Cyan', color:R.appColors.cyan,id:3),),
  //   ChannelModel(title: "Channel 5",color: ColorOption(label:'UV', color:R.appColors.uv,id:4),),
  //   ChannelModel(title: "Channel 6",color:ColorOption(label:'Full Spec',color: R.appColors.fullSpec,id:5),),
  // ];

  void update() {
    notifyListeners();
  }
  void increment() {
    day++;
    notifyListeners();
  }

  void decrement() {
    if (day > 0) {
      day--;
      notifyListeners();
    }
  }
  List<ChannelModel> deepCopyChannels(List<ChannelModel> channels) {
    return channels.map((channel) {
      return ChannelModel(
        title: channel.title,
        color: channel.color != null
            ? ColorOption(
                label: channel.color!.label,
                color: channel.color!.color,
                id: channel.color!.id,
                intensity: channel.color!.intensity,
                brightness: channel.color!.brightness,
              )
            : null,
      );
    }).toList();
  }
  
  void addOrUpdateTimePoint(String time, double intensity, double moonIntensity, ChannelModel? moonChannel) {
    int existingIndex = data.indexWhere((item) => item.time == time);
    List<ChannelModel> allChannels = deepCopyChannels(channels);
    
    if (existingIndex != -1) {
      data[existingIndex].pointIntensity = intensity;
      data[existingIndex].moonIntensity = moonIntensity;
      data[existingIndex].moonChannel = moonChannel?.color?.id;
      data[existingIndex].allChannels = allChannels;
    }
    else {
      int newTimeMinutes = _parseTimeToMinutes(time);
      int insertPosition = 0;
      for (int i = 0; i < data.length; i++) {
        int currentTimeMinutes = _parseTimeToMinutes(data[i].time??"00:00");
        if (newTimeMinutes > currentTimeMinutes) {
          insertPosition = i + 1;
        } else if (newTimeMinutes < currentTimeMinutes) {
          insertPosition = i;
          break;
        }
      }

      data.insert(insertPosition, ChartData(
        time: time, 
        pointIntensity: intensity,
        moonChannel: moonChannel?.color?.id,
        moonIntensity: moonIntensity,
        allChannels: allChannels
      ));
    }

    notifyListeners();
  }
  
  /// Helper to convert time string to minutes for comparison
  int _parseTimeToMinutes(String time) {
    List<String> parts = time.split(':');
    if (parts.length == 2) {
      int hours = int.tryParse(parts[0]) ?? 0;
      int minutes = int.tryParse(parts[1]) ?? 0;
      return hours * 60 + minutes;
    }
    return 0;
  }
}
