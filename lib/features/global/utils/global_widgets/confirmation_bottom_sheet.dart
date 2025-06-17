import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_widgets.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:sizer/sizer.dart';
import '../../constants/heights_widths.dart';
import '../../resources/resources.dart';

class ConfirmationBottomSheet extends StatefulWidget {
  String title;
  void Function() yesTap;
  ConfirmationBottomSheet({super.key,required this.title,required this.yesTap});

  @override
  State<ConfirmationBottomSheet> createState() => _ConfirmationBottomSheetState();
}

class _ConfirmationBottomSheetState extends State<ConfirmationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
        backgroundColor: R.appColors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35))
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlobalWidgets.bottomHorBar(backgroundColor: R.appColors.primaryColor),
              h2,
              Text(widget.title.L(),textAlign: TextAlign.center,style: R.textStyles.poppins(fontSize: 16.px,fontWeight: FontWeight.w600,color: R.appColors.primaryColor),),
              h2,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        decoration: BoxDecoration(
                          color: R.appColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: R.appColors.subTitleGrey),
                        ),
                        child: Center(
                          child: Text(
                            "no".L(),
                            textAlign: TextAlign.center,
                            style: R.textStyles.poppins(
                              fontSize: 15.px,
                              fontWeight: FontWeight.w600,
                              color: R.appColors.subTitleGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  w2,
                  Expanded(
                    child: CustomButton(onPressed: widget.yesTap, title: "yes"),
                  ),
                ],
              ),
              h2,
            ],
          ),
        ),
    );
  }
}

