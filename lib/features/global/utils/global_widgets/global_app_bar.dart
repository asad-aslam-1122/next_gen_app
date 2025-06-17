import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:sizer/sizer.dart';
import '../../resources/resources.dart';

class GlobalAppBar {
  static customAppBar2({
    required String title,
    bool? isTranslate,
    Widget? leading,
    double? leadingWidth,
    List<Widget>? actions,
    Color? backGroundColor,
  }) {
    return AppBar(
      backgroundColor: backGroundColor ?? R.appColors.white,
      centerTitle: true,
      leading:
          leading ??
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: R.appColors.black),
          ),
      leadingWidth: leadingWidth ?? 56,
      title: Text(
        isTranslate ?? false ? title : title.L(),
        style: R.textStyles.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16.px,
          color: R.appColors.appBarTitle,
        ),
      ),
      actions: actions,
    );
  }
}
