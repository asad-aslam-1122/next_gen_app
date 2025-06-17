import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../global/functions/global_functions.dart';
import '../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/custom_button.dart';
import '../../data/model/channel_model.dart';
import '../../data/model/chart_data.dart';
import '../../data/model/color_label_model.dart';
import '../provider/mode_vm.dart';
import '../widgets/custom_thumb_shape.dart';
import '../widgets/point_moon_silder.dart';

class AddTimeView extends StatefulWidget {
  static String route = "/addTimeView";
  const AddTimeView({Key? key}) : super(key: key);

  @override
  State<AddTimeView> createState() => _AddTimeViewState();
}

class _AddTimeViewState extends State<AddTimeView> {
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  double pointIntensity = 0;
  double moonlightIntensity = 0;
  ChannelModel? selectedChannel;
  List<ChannelModel> moonLightChannels=[];



  @override
  void initState() {
    ModeVM vm=context.read<ModeVM>();
    vm.channels.map((e)=>e.color?.intensity=0).toList();
    vm.channels = vm.deepCopyChannels(vm.channels);
    moonLightChannels = vm.deepCopyChannels(vm.channels);
    moonLightChannels.add(ChannelModel(
      title: "Channel 7",
      color: ColorOption(
        label: 'Moonlight/Shimmer',
        color: R.appColors.moonlightColor,
        id: 6
      ),
    ));
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setEditData(vm);
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ModeVM>(
      builder: (context,vm,_) {
        return Scaffold(
          backgroundColor: R.appColors.backgroundColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titles("Set New Time"),
                SizedBox(height: 1.5.h),
                setTimePicker(),
                SizedBox(height: 3.h),
                titles("Point Intensity"),
                SizedBox(height: 1.5.h),
                PointAndMoonSlider(intensityValue: pointIntensity,onChanged: (v){setState(() {
                  pointIntensity=v;
                });},),
                SizedBox(height: 3.h),
                titles("Moonlight"),
                SizedBox(height: 1.5.h),
                moonlightDropdown(),
                SizedBox(height: 2.h),
                PointAndMoonSlider(intensityValue:moonlightIntensity,onChanged: (v){
                  setState(() {
                  moonlightIntensity=v;
                });},),
                SizedBox(height: 3.h),
                titles("Channels"),
                SizedBox(height: 2.h),
                ...vm.channels.map((c) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titles(c.color?.label??""),
                          Text("${c.color?.intensity?.toInt()}%", style: R.textStyles.poppins().copyWith(fontSize: 14.px,color:R.appColors.primaryColor,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      channelSlider(c.color,(v){
                        setState(() {
                          c.color?.intensity = v;
                        });

                      }),
                      SizedBox(height: 2.h),
                    ],
                  );
                }),
                SizedBox(height: 3.h),

              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding:  EdgeInsets.fromLTRB(5.w,0,5.w,3.h),
            child: CustomButton(
                onPressed: (){
                  if(pointIntensity==0)
                  {
                    ZBotToast.showToastError(message: "Please select point intensity");
                    return;
                  }
                  if(selectedChannel==null)
                  {
                    ZBotToast.showToastError(message: "Please select moonlight channel");
                    return;
                  }
                  if(moonlightIntensity==0)
                  {
                    ZBotToast.showToastError(message: "Please select moonlight intensity");
                    return;
                  }
                  
                  String time = GlobalFunctions().formatTimeOfDay(selectedTime,twentyFourHourFormat:true);
                  vm.addOrUpdateTimePoint(time, pointIntensity,moonlightIntensity,selectedChannel);
                  vm.scheduleController.jumpToPage(0);
                  ZBotToast.showToastSuccess(title: "new_time_added".L(), message: "the_time_has_been_added_successfully".L());
                }, title:vm.currentChartPoint!=null?"update": "save"),
          ),
        );
      }
    );
  }
  Widget titles(String title)
  {
    return Text(title, style: R.textStyles.poppins().copyWith(fontWeight: FontWeight.w600, fontSize: 14.px));
  }
  Widget setTimePicker()
  {
    return GestureDetector(
      onTap: _selectTime,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            selectedTime.format(context),
            style: R.textStyles.poppins().copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18.px,
              color: R.appColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
Widget moonlightDropdown()
{
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.7.h),
    decoration: BoxDecoration(
      color: R.appColors.fillColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[200]!),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<ChannelModel>(
        value: selectedChannel,
        hint: Text("Select Channel", style: R.textStyles.poppins().copyWith(color: Colors.grey, fontSize: 13.px)),
        isExpanded: true,
        icon: Image.asset(R.appImages.dropDown,scale: 4,),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
        items: moonLightChannels.map((c) => DropdownMenuItem(
          value: c,
          child: Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: c.color?.color ?? Colors.grey[300],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  c.color?.label ?? '',
                  style: R.textStyles.poppins().copyWith(
                    color: Colors.black,
                    fontSize: 13.px,
                  ),
                ),
              ),
              Icon(
                selectedChannel == c
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selectedChannel == c
                    ? R.appColors.secondaryColor
                    : Colors.grey[400],
              ),
            ],
          ),
        )).toList(),
        selectedItemBuilder: (context){
          return moonLightChannels.map((c) => DropdownMenuItem(
            value: c,
            child: Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: c.color?.color ?? Colors.grey[300],
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      c.color?.label ?? '',
                      style: R.textStyles.poppins().copyWith(
                        color: Colors.black,
                        fontSize: 13.px,
                      ),
                    ),
                  ),]
            ),
          )).toList();
        },
        onChanged: (v) => setState(() => selectedChannel = v),
      ),
    ),
  );
}
Widget channelSlider(ColorOption? color,Function onChanged)
{
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(10),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 34,
        inactiveTrackColor: color?.color,
        activeTrackColor:color?.color,
        thumbShape: CustomThumbShape(channelColor:color?.color??R.appColors.secondaryColor,
            thumbSize: 14,strokeWidth: 3),
        overlayShape: SliderComponentShape.noOverlay,
        trackShape: const RoundedRectSliderTrackShape(),
      ),
      child: Slider(
        padding: EdgeInsets.zero,
        value: color?.intensity??0,
        min: 0,
        max: 100,
        onChanged: (v){
          onChanged(v);
        }
      ),
    ),
  );
}
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: R.appColors.secondaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
              surface: Colors.white, // background color
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: R.appColors.secondaryColor, // button text color
                textStyle: R.textStyles.poppins().copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteTextColor: Colors.black,
              hourMinuteColor: Colors.grey[200],
              dayPeriodTextColor: R.appColors.secondaryColor,
              dayPeriodColor: Colors.grey[200],
              dialHandColor: R.appColors.secondaryColor,
              dialBackgroundColor: Colors.grey[100],
              entryModeIconColor: R.appColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
  void setEditData(ModeVM vm)
  {
    if(vm.currentChartPoint!=null) {
      setState(() {
        selectedTime=GlobalFunctions().stringToTimeOfDay(vm.currentChartPoint?.time??"00:00");
        pointIntensity=vm.currentChartPoint?.pointIntensity??0;
        moonlightIntensity=vm.currentChartPoint?.moonIntensity??0;

        if(vm.currentChartPoint?.moonChannel!=null && vm.currentChartPoint?.moonChannel!=-1) {
          selectedChannel = moonLightChannels[vm.currentChartPoint?.moonChannel??-1];
        }

        if(vm.currentChartPoint?.allChannels != null && vm.currentChartPoint!.allChannels!.isNotEmpty) {
          List<ChannelModel> updatedChannels = vm.currentChartPoint!.allChannels!.map((channel) {
            return ChannelModel(
              title: channel.title,
              color: channel.color != null
                  ? ColorOption(
                label: channel.color!.label,
                color: channel.color!.color,
                id: channel.color!.id,
                intensity: channel.color!.intensity,
              )
                  : null,
            );
          }).toList();

          vm.channels = updatedChannels;
          vm.update();
        }
      });
    }
  }
}

