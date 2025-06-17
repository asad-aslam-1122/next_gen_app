import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'resources.dart';

class AppTextStyles {
  TextStyle inter({
    TextDecoration? textDecoration,
    Color? color,
    double? fontSize,
    bool dontGiveTextHeight = false,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize ?? 14.px,
      color: color ?? R.appColors.primaryColor,
      height: dontGiveTextHeight ? null : 1.5,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0,
      decoration: textDecoration ?? TextDecoration.none,
    );
  }

  TextStyle poppins({
    TextDecoration? textDecoration,
    Color? color,
    double? fontSize,
    bool dontGiveTextHeight = false,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 14.px,
      color: color ?? R.appColors.primaryColor,
      height: dontGiveTextHeight ? null : 1.5,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0,
      decoration: textDecoration ?? TextDecoration.none,
    );
  }

  TextStyle urbanist({
    TextDecoration? textDecoration,
    Color? color,
    double? fontSize,
    bool dontGiveTextHeight = false,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return GoogleFonts.urbanist(
      fontSize: fontSize ?? 14.px,
      color: color ?? R.appColors.primaryColor,
      height: dontGiveTextHeight ? null : 1.5,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0,
      decoration: textDecoration ?? TextDecoration.none,
    );
  }
}
