import 'channel_model.dart';

class ChartData {
   String? time;
   double? pointIntensity;
   double? moonIntensity;
  int? moonChannel;
  List<ChannelModel>? allChannels;

  ChartData({this.time, this.pointIntensity, this.moonIntensity,
    this.moonChannel, this.allChannels});
   Map<String, dynamic> toJson() {
     return {
       'time': time,
       'pointIntensity': pointIntensity,
       'moonIntensity': moonIntensity,
       'moonChannel': moonChannel,
       'allChannels': allChannels?.map((channel) => channel.toJson()).toList(),
     };
   }
}