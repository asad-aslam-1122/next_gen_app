import 'package:flutter/material.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AppDecorations {
  InputDecoration inputDecorationWithHint({
    required String hintText,
    TextStyle? hintTextStyle,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Color? filledColor,
    double? borderRadius,
    double? contentPadding,
    Color? grey,
    bool isReadOnly = false,
    bool isLocalized = true,
    bool? showBorder,
    Color? hintColor,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(contentPadding ?? 12),
      fillColor: filledColor ?? R.appColors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide:
            (showBorder ?? false)
                ? BorderSide(color: R.appColors.borderColor, width: 1.2)
                : BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide(color: R.appColors.red, width: 1.2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide(
          color:
              isReadOnly
                  ? grey ?? R.appColors.transparent
                  : R.appColors.borderColor,
          width: 1.2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide(color: R.appColors.red, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide(
          color: grey ?? R.appColors.borderColor,
          width: 1.2,
        ),
      ),
      errorMaxLines: 2,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: isLocalized ? hintText.L() : hintText,
      isDense: true,
      errorStyle: R.textStyles.poppins(fontSize: 11.px, color: R.appColors.red),
      hintStyle:
          hintTextStyle ??
          R.textStyles.poppins().copyWith(
            color: hintColor ?? R.appColors.darkGreyColor1,
            fontSize: 14.px,
          ),
    );
  }

  BoxDecoration verticalRadiusBoxDec({
    Color? backgroundColor,
    double? radius,
    bool? radiusFromBottom,
    bool? hideShadow,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? R.appColors.primaryColor,
      boxShadow:
          (hideShadow ?? false)
              ? []
              : [
                BoxShadow(
                  color: R.appColors.black.withValues(alpha: .15),
                  blurRadius: 4,
                  spreadRadius: 6,
                ),
              ],
      borderRadius: BorderRadius.vertical(
        bottom:
            (radiusFromBottom ?? false)
                ? Radius.circular(radius ?? 28)
                : Radius.circular(0),
        top:
            (radiusFromBottom ?? false)
                ? Radius.circular(0)
                : Radius.circular(radius ?? 28),
      ),
    );
  }

  BoxDecoration generalDecoration({Color? backgroundColor, double? radius}) {
    return BoxDecoration(
      color: backgroundColor ?? R.appColors.primaryColor,
      // boxShadow: [
      //   BoxShadow(
      //     color: R.appColors.shadowColor,
      //     blurRadius: 2,
      //     spreadRadius: 2,
      //   ),
      // ],
      borderRadius: BorderRadius.circular(radius ?? 8),
    );
  }

  BoxDecoration bottomSheetDec({Color? backgroundColor, double? radius}) {
    return BoxDecoration(
      color: backgroundColor ?? R.appColors.primaryColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius ?? 12)),
    );
  }

  BoxDecoration generalDecorationWithBorder({
    Color? backgroundColor,
    double? radius,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? R.appColors.primaryColor,
      border: Border.all(color: R.appColors.secondaryColor),
      borderRadius: BorderRadius.circular(radius ?? 8),
    );
  }

  BoxDecoration onboardImageDec({required String imagePath}) {
    return BoxDecoration(
      image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
    );
  }

  InputDecoration inputDecoration({
    required String hintText,
    Widget? suffixIcon,
    Color? filledColor,
    Color? grey,
  }) {
    return InputDecoration(
      hintText: hintText == "" ? null : hintText.L(),
      hintStyle: R.textStyles.poppins(fontSize: 14.px, color: R.appColors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: filledColor ?? R.appColors.grey,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      filled: true,
      fillColor: filledColor ?? R.appColors.transparent,
      suffixIcon: suffixIcon,
      errorStyle: R.textStyles.poppins(fontSize: 12.px, color: R.appColors.red),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: filledColor ?? R.appColors.grey,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: R.appColors.grey,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: R.appColors.red,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: R.appColors.red,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
    );
  }

  ButtonStyle iconButtonDec() {
    return ButtonStyle(
      shape: WidgetStatePropertyAll(CircleBorder()),
      backgroundColor: WidgetStatePropertyAll(R.appColors.secondaryColor),
      padding: WidgetStatePropertyAll(EdgeInsets.all(13)),
      elevation: WidgetStatePropertyAll(8),
      shadowColor: WidgetStatePropertyAll(
        R.appColors.black.withValues(alpha: .7),
      ),
    );
  }
}
