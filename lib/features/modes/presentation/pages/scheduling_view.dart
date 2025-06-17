import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:daylight/daylight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_app_bar.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/schedule_bottom_sheet.dart';
import 'package:nextgen_reeftech/features/modes/presentation/provider/mode_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../global/utils/logout_bottomsheet_widget.dart';
import '../../../global/utils/timezone_utils.dart';
import '../../data/model/chart_data.dart';
import '../widgets/schedule_chart.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../widgets/vertical_arrow_painter.dart';
import 'accimilation_view.dart';
import 'add_time_view.dart';
import '../widgets/bar_chart.dart';

class SchedulingView extends StatefulWidget {
  static String route = "/schedulingView";

  const SchedulingView({super.key});

  @override
  State<SchedulingView> createState() => _SchedulingViewState();
}

class _SchedulingViewState extends State<SchedulingView>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool acclimate=false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

  }
  double get currentXPosition {

    ModeVM vm=context.read<ModeVM>();
    final double maxX =vm.data.isNotEmpty? (vm.data.lastWhere((e)=>(e.pointIntensity??0)>0).pointIntensity??0):0;
    return _animation.value * maxX;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ModeVM>(
      builder: (context,vm,_) {
        return Scaffold(
          backgroundColor: R.appColors.backgroundColor,
          appBar: GlobalAppBar.customAppBar2(
            backGroundColor: R.appColors.backgroundColor,
            title: "scheduling",
            actions: [
              GestureDetector(
                onTap: (){
                  Get.bottomSheet(StartIntensitySheet(),isScrollControlled: true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: R.appColors.brownLight,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  child: Row(
                    children: [
                      Image.asset(R.appImages.sunBlack, scale: 4),
                      Text(
                        "${vm.scheduleIntensity.toInt()}%",
                        style: R.textStyles.poppins().copyWith(
                          fontSize: 16.px,
                          fontWeight: FontWeight.w500,
                          color: R.appColors.appBarTitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              w3,
            ],
          ),
          body: PageView(
            controller: vm.scheduleController,
            // onPageChanged: (index){
            //   log("ONPAGE CHANGE");
            //   vm.currentChartPoint=null;
            //   vm.update();
            // },
            children: [
              chartView(vm),
              AddTimeView()
            ],
          )
        );
      }
    );
  }
  Widget chartView(ModeVM vm)
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          // Acclimation Toggle
          acclimateToggle(vm),

          SizedBox(height: 3.h),
          // Chart Area (Placeholder)
          // Transform.rotate(
          //   angle: 1.57,
          //   child:
            Stack(
              children: [
                AspectRatio(
                  aspectRatio:0.9,
                  child: BarChartPage(),
                ),
          
                (vm.data.every((e)=>e.pointIntensity==0.0||e.pointIntensity==null)==true || _animation.value==0 || _animation.value==0.1 ||_animation.value==1.0)?
                SizedBox():
                Positioned.fill(
                  left: 70,
                  child: CustomPaint(
                    painter: VerticalArrowPainter(
                      xPosition: currentXPosition,
                      chartData: vm.data,
                      animationValue: _animation.value,
                    ),
                  ),
                ),
              ],
            ),
          // ),
          Spacer(),
          // Bottom Buttons
          bottomButtons(vm),
        ],
      ),
    );
  }
  Widget bottomButtons(ModeVM vm)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap:() async {
             Get.bottomSheet(LogoutBottomsheetWidget(titleText:"all_your_graph_data_will_be_removed_are_you_sure_you_want_to_rest".L(),onRightTab: (){
               ZBotToast.showToastSuccess(title: "graph_reset".L(),message: "the_graph_has_been_reset_successfully".L());
               Get.back();
               vm.data.map((e)=> e.pointIntensity=0.0).toList();
               vm.currentChartPoint=null;
                vm.update();
             },));
          },
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 28,
                child: Icon(Icons.refresh, color: Colors.white, size: 32),
              ),
              SizedBox(height: 8),
              Text('Reset', style: R.textStyles.poppins()),
            ],
          ),
        ),
        GestureDetector(
          onTap:(){
               vm.currentChartPoint=null;
              vm.scheduleController.jumpToPage(1);
              vm.update();
          },
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 32,
                child: Icon(Icons.add, color: Colors.white, size: 36),
              ),
              SizedBox(height: 8),
              Text('Add Time', style: R.textStyles.poppins()),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            _controller.reset();
            _controller.forward();
          },
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 28,
                child: Icon(Icons.play_arrow, color: Colors.white, size: 32),
              ),
              SizedBox(height: 8),
              Text('Preview', style: R.textStyles.poppins()),
            ],
          ),
        ),
      ],
    );
  }
  Widget acclimateToggle(ModeVM vm)
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'acclimation'.L(),
            style: R.textStyles.poppins().copyWith(
              fontSize: 14.px,
              fontWeight: FontWeight.w500,
              color: R.appColors.primaryColor,
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              value: acclimate,
              onChanged: (val) {

                if(vm.data.every((point)=> point.pointIntensity==0)==true) {
                  Get.bottomSheet(LogoutBottomsheetWidget(
                    titleText: "to_enable_acclimation_you_need_to_set_up_a_lighting_schedule_first"
                        .L(),
                    rightBtnText: "schedule_now",
                    leftBtnText: "schedule_later",
                    onLeftTab: () {
                      Get.back();
                      Get.toNamed(AccimilationView.route, arguments: {
                        "acclimate": val
                      })?.then((value) {
                        setState(() {
                          acclimate = val;
                        });
                      });
                    },
                    onRightTab: () {
                      Get.back();
                      vm.scheduleController.jumpToPage(1);
                      vm.update();
                    },));
                }else{
                  Get.toNamed(AccimilationView.route, arguments: {
                    "acclimate": val
                  })?.then((value) {
                    setState(() {
                      acclimate = val;
                    });
                  });
                }

              },
              activeTrackColor: R.appColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}


