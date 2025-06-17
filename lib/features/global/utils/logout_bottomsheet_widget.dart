import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/heights_widths.dart';
import '../resources/resources.dart';
import 'global_widgets/custom_button.dart';
import 'global_widgets/global_widgets.dart';
import 'global_widgets/safe_area_widget.dart';

class LogoutBottomsheetWidget extends StatelessWidget {
  final VoidCallback onRightTab;
  final VoidCallback? onLeftTab;
  final String titleText;
  final String? rightBtnText;
  final String? leftBtnText;

  const LogoutBottomsheetWidget({
    super.key,
    required this.onRightTab,
     this.onLeftTab,
    required this.titleText,
     this.rightBtnText,
     this.leftBtnText,
  });

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
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
                fontWeight: FontWeight.w700,
                fontSize: 18.px,
              ),
            ),

            h5,

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed:onLeftTab??() {
                      Get.back();
                    },
                    showOutLineBorder: true,
                    textColor: R.appColors.grey,
                    textWeight: FontWeight.w600,
                    backgroundColor: R.appColors.white,
                    title:leftBtnText?? "no",
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: CustomButton(
                    onPressed: () => onRightTab(),
                    textWeight: FontWeight.w600,
                    title:rightBtnText?? "yes",
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
