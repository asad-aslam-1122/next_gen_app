import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/heights_widths.dart';
import '../resources/resources.dart';
import '../utils/global_widgets/custom_button.dart';

class EmptyView extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subTitle;
  final String? btnTitle;
  final VoidCallback? onPressed;
  final bool? showButton;

  const EmptyView({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subTitle,
    this.showButton,
    this.btnTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 100,
            width: 100,
            fit: BoxFit.fill,
          ),
          h1P5,
          Text(
            title,
            textAlign: TextAlign.center,
            style: R.textStyles.poppins().copyWith(
              fontSize: 18.px,
              fontWeight: FontWeight.w600,
              color: R.appColors.primaryColor
            ),
          ),
          h0P5,
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: R.textStyles.poppins().copyWith(
              fontSize: 15.px,
              fontWeight: FontWeight.w500,
              color: R.appColors.greyLight
            ),
          ),
          h2,
          if (showButton ?? false)
            CustomButton(
              onPressed: onPressed ?? () {},
              title: btnTitle ?? "",
            ),
        ],
      ),
    );
  }
}
