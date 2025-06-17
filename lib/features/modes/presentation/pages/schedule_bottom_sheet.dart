import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_widgets.dart';
import 'package:nextgen_reeftech/features/modes/presentation/provider/mode_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/vertical_slider_widget.dart';

class StartIntensitySheet extends StatefulWidget {
  StartIntensitySheet({super.key});

  @override
  State<StartIntensitySheet> createState() => _StartIntensitySheetState();
}

class _StartIntensitySheetState extends State<StartIntensitySheet> {
  double scheduleIntensity=0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ModeVM>(
      builder: (context,modeVM,_) {
        return Container(
          padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 5.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlobalWidgets.bottomHorBar(),
              h2,
              Row(
                children: [
                  GestureDetector(
                    onTap: (){Get.back();},
                      child: Icon(Icons.close, color: R.appColors.cancelColor)),
                  const SizedBox(width: 60),
                  Text(
                    'schedule_intensity'.L(),
                    style: R.textStyles.poppins(
                      fontSize: 16.px,
                      fontWeight: FontWeight.w600,
                      color: R.appColors.cancelColor,
                    ),
                  ),
                ],
              ),
              h3,
              Row(
                children: [
                  Text(
                    'set_overall_intensity_of_the_schedule'.L(),
                    style: R.textStyles.poppins(
                      fontSize: 14.px,

                      color: R.appColors.subTitleGrey,
                    )
                  ),
                ],
              ),
              h5,
              VerticalIntensitySlider(
                height: 313,
                width: 123,
                imageSize: 3.5,
                value:modeVM.scheduleIntensity,
                color: R.appColors.secondaryColor.withAlpha(150),
                onChange: (value) {
                  setState(() {
                    scheduleIntensity=value;
                  });
                },
              ),
              h10,
              CustomButton(
                title: 'save'.L(),
                onPressed: () {
                  modeVM.scheduleIntensity=scheduleIntensity;
                  modeVM.update();
                  Get.back();
                },
                isLocalizedText: false,
              ),
              h2
            ],
          ),
        );
      }
    );
  }
}
