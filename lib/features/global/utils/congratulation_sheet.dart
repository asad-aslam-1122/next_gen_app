import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/constants/heights_widths.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';

class CongratulationSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  const CongratulationSheet({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:Get.width,
      padding: EdgeInsets.all(12),
      decoration: R.appDecorations.bottomSheetDec(
        backgroundColor: R.appColors.white,
        radius: 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          h5,
          Image.asset(R.appImages.congratulationIcon, scale: 4),
          h5,
          Text(
            title,
            textAlign: TextAlign.center,
            style: R.textStyles.inter(
              fontWeight: FontWeight.w600,
              fontSize: 21.px,
            ),
          ),
          h1P5,
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: R.textStyles.poppins(
              color: R.appColors.subTitleGrey,
              fontSize: 12.px,
            ),
          ),
          h6,
        ],
      ),
    );
  }
}
