import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class GlobalWidgets {
  static Widget bottomHorBar({Color? backgroundColor,double? width}) {
    return Container(
      width: width ?? 60,
      height: 2,
      decoration: R.appDecorations.generalDecoration(
        radius: 2,
        backgroundColor: R.appColors.appBarTitle,
      ),
    );
  }
}
