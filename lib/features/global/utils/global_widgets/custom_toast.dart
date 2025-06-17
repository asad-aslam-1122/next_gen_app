import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

class CustomToastWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const CustomToastWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: R.appColors.transparent,
        child: Card(
          color: R.appColors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: R.appColors.white.withAlpha(64)),
          ),
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,

            contentPadding:
           const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
            leading: Image.asset(
              alignment: Alignment.topCenter,
              imagePath,
              scale: 4.2,
            ),
            title: Text(
              title,
              style: R.textStyles.poppins(
                fontSize: 13.px,
                fontWeight: FontWeight.w600,
                color: R.appColors.baseColor,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: R.textStyles.poppins(
                fontSize: 11.px
                ,
                color: R.appColors.greyLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}