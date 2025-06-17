import 'package:flutter/material.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../constants/heights_widths.dart';
import '../../resources/resources.dart';

class ToggleButtonWidget extends StatefulWidget {
  final String rightBtnTxt;
  final String leftBtnTxt;
  final VoidCallback rightBtnTab;
  final VoidCallback leftBtnTab;

  const ToggleButtonWidget({
    super.key,
    required this.rightBtnTxt,
    required this.leftBtnTxt,
    required this.rightBtnTab,
    required this.leftBtnTab,
  });

  @override
  State<ToggleButtonWidget> createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  int selectedBtnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 85.w,
      padding: EdgeInsets.all(5),
      decoration: R.appDecorations.generalDecoration(
        backgroundColor: R.appColors.grey,
        radius: 8,
      ),
      child: Row(
        children: [
          buttonWidget(
            title: widget.leftBtnTxt.L(),
            onTab: widget.leftBtnTab,
            index: 0,
          ),
          w1P5,
          buttonWidget(
            title: widget.rightBtnTxt.L(),
            onTab: widget.rightBtnTab,
            index: 1,
          ),
        ],
      ),
    );
  }

  Widget buttonWidget({
    required String title,
    required VoidCallback onTab,
    required int index,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedBtnIndex = index;
          setState(() {});
          onTab();
        },
        child: Container(
          decoration: R.appDecorations.generalDecoration(
            backgroundColor:
                selectedBtnIndex == index
                    ? R.appColors.white
                    : R.appColors.grey,
            radius: 8,
          ),
          child: Center(
            child: Text(
              title,
              style: R.textStyles.poppins().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.px,
                color:
                    selectedBtnIndex == index
                        ? R.appColors.black
                        : R.appColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
