import 'package:flutter/cupertino.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/landing/data/model/onboard_model.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';

class OnboardWidget extends StatelessWidget {
  final OnboardModel onboardModel;

  const OnboardWidget({super.key, required this.onboardModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          onboardModel.title.L(),
          textAlign: TextAlign.center,
          style: R.textStyles.inter(
            fontWeight: FontWeight.w600,
            fontSize: 24.px,
            color: R.appColors.primaryColor
          ),
        ),
        h1,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            onboardModel.subTitle.L(),
            textAlign: TextAlign.center,
            style: R.textStyles.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14.px,
              color: R.appColors.subTitleGrey
            ),
          ),
        ),
      ],
    );
  }
}
