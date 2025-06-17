import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/heights_widths.dart';
import '../resources/resources.dart';
import 'global_widgets/custom_button.dart';
import 'global_widgets/global_widgets.dart';
import 'global_widgets/safe_area_widget.dart';

class LogoutSheet extends StatelessWidget {
  final VoidCallback onRightTab;
  final String titleText;

  const LogoutSheet({
    super.key,
    required this.onRightTab,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      bottom: true,
      backgroundColor: R.appColors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: R.appDecorations.verticalRadiusBoxDec(
          radius: 20,
          backgroundColor: R.appColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            h0P1,

            GlobalWidgets.bottomHorBar(),

            h1P5,

            Text(
              titleText,
              textAlign: TextAlign.center,
              style: R.textStyles.poppins().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.px,
              ),
            ),

            h5,

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Get.back();
                    },
                    showOutLineBorder: true,
                    textColor: R.appColors.subTitleGrey,
                    textWeight: FontWeight.w600,
                    backgroundColor: R.appColors.white,
                    title: "no",
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: CustomButton(
                    onPressed: () => onRightTab(),
                    textWeight: FontWeight.w600,
                    title: "yes",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
