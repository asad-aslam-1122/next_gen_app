
import 'color_label_model.dart';

class ChannelModel
{
  String? title;
  int? id;
  ColorOption? color;

  ChannelModel({this.title, this.color,this.id});
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'color': color,
    };
  }
}