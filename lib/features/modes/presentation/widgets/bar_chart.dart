import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/timezone_utils.dart';
import '../../data/model/chart_data.dart';
import '../provider/mode_vm.dart';
import '../pages/add_time_view.dart';

class BarChartPage extends StatefulWidget {
  const BarChartPage({Key? key,}) : super(key: key);

  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_){
     _addSunriseSunsetPoints(context.read<ModeVM>());
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ModeVM>(
        builder: (context,vm,_) {

          return SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(

            title: AxisTitle(text: 'Time',textStyle: R.textStyles.poppins()),
            interval:vm.data.length>16?2: 1,
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Intensity(%)',textStyle: R.textStyles.poppins()),
            majorGridLines: const MajorGridLines(width: 0.5),
            minimum: 0,
            maximum: 100,
            interval: 20,
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
          ),
          series: <CartesianSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
              dataSource: vm.data,
              xValueMapper: (ChartData data, _) => data.time,
              yValueMapper: (ChartData data, _) => data.pointIntensity,
              width: 0.7,
              color: R.appColors.secondaryColor,
              onPointTap: (ChartPointDetails detail){_onMarkerTapped(detail);},
            ),
            SplineSeries<ChartData, String>(
              dataSource: vm.data,
              xValueMapper: (ChartData data, _) => data.time,
              yValueMapper: (ChartData data, _) => data.pointIntensity,
              color: R.appColors.red,
              width: 3,
              dashArray: [5,5],
              enableTooltip: true,
              markerSettings: MarkerSettings(
                isVisible: true,
                color: R.appColors.secondaryColor,
                shape: DataMarkerType.circle,
                borderColor: R.appColors.secondaryColor,
                width: 10,
                height: 10,
              ),
              splineType: SplineType.clamped,
            ),
          ],
          annotations: <CartesianChartAnnotation>[
            CartesianChartAnnotation(
              widget: Image.asset(R.appImages.sun,scale:4),
              coordinateUnit: CoordinateUnit.point,
              x: DateFormat("HH:mm").format(TimezoneUtils.sunrise??DateTime.now()),
              y: 0,
            ),
            CartesianChartAnnotation(
              widget: Image.asset(R.appImages.moon,scale:4),
              coordinateUnit: CoordinateUnit.point,
              x: DateFormat("HH:mm").format(TimezoneUtils.sunset??DateTime.now()),
              y: 0,
            ),
          ],
        );
      }
    );
  }


  void _onMarkerTapped(ChartPointDetails details) {
    if (details.pointIndex != null && details.dataPoints != null && details.dataPoints!.isNotEmpty) {
      ModeVM vm=context.read<ModeVM>();
      vm.currentChartPoint=vm.data[details.pointIndex??0];
      vm.scheduleController.jumpToPage(1);
      vm.update();
    }
  }

  void _addSunriseSunsetPoints(ModeVM vm) {
    if (TimezoneUtils.sunrise != null && TimezoneUtils.sunset != null) {
      final sunriseTime = DateFormat("HH:mm").format(TimezoneUtils.sunrise!);
      final sunsetTime = DateFormat("HH:mm").format(TimezoneUtils.sunset!);

      // Check if sunrise point exists
      bool hasSunrise = vm.data.any((point) => point.time == sunriseTime);
      if (!hasSunrise) {
        vm.addOrUpdateTimePoint(sunriseTime, 0, 0, null);
      }

      // Check if sunset point exists
      bool hasSunset = vm.data.any((point) => point.time == sunsetTime);
      if (!hasSunset) {
        vm.addOrUpdateTimePoint(sunsetTime, 0, 0, null);
      }
    }
  }
}


