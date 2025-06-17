import 'package:flutter/material.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

class CustomButton extends StatefulWidget {
  VoidCallback onPressed;
  String title;
  double? textSize;
  FontWeight? textWeight;
  Color? backgroundColor;
  Color? textColor;
  double? elevation;
  double? radius;
  double? height;
  double? width;
  Widget? iconWidget;
  bool isLocalizedText;
  bool? showOutLineBorder;
  EdgeInsets? contentPadding;

  CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.textSize,
    this.backgroundColor,
    this.textColor,
    this.radius,
    this.height,
    this.width,
    this.elevation,
    this.iconWidget,
    this.contentPadding,
    this.showOutLineBorder,
    this.isLocalizedText = true,
    this.textWeight,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 50,
      width: widget.width ?? 100.w,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side:
                (widget.showOutLineBorder ?? false)
                    ? BorderSide(color: R.appColors.grey)
                    : BorderSide.none,
            borderRadius: BorderRadius.circular(widget.radius ?? 8),
          ),
          padding: widget.contentPadding ?? EdgeInsets.zero,
          elevation: 0,
          // shadowColor:
          //     WidgetStatePropertyAll(R.appColors.black.withOpacity(0.8)),
          backgroundColor: widget.backgroundColor ?? R.appColors.secondaryColor,
        ),
        child:
            widget.iconWidget != null
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.isLocalizedText ? widget.title.L() : widget.title,
                      style: R.textStyles.poppins(
                        color: widget.textColor ?? R.appColors.white,
                        fontSize: widget.textSize ?? 16.px,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    widget.iconWidget ?? const SizedBox(),
                  ],
                )
                : Text(
                  widget.isLocalizedText ? widget.title.L() : widget.title,
                  style: R.textStyles.poppins(
                    color: widget.textColor ?? R.appColors.white,
                    fontSize: widget.textSize ?? 16.px,
                    fontWeight: widget.textWeight ?? FontWeight.w500,
                  ),
                ),
      ),
    );
  }
}
