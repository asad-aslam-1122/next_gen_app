import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/logout_sheet.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_sub_pages/delete_account_view.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_sub_pages/edit_profile_view.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_sub_pages/support_view.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_sub_pages/update_password_view.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/pages/terms_and_policy_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/app_user.dart';
import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/image_picker/image_widget.dart';
import '../../../user/presentation/pages/auth/login_view.dart';
import '../../data/model/base_profile_model.dart';


class ProfileBaseView extends StatelessWidget {
  static String route = "/ProfileBaseView";
  ProfileBaseView({super.key});

  final List<BaseProfileModel> baseProfileModel = [
    BaseProfileModel(iconImg: R.appImages.supportIcon, title: 'support'),
    BaseProfileModel(iconImg: R.appImages.lockIcon, title: 'change_password'),
    BaseProfileModel(
      iconImg: R.appImages.docIcon,
      title: 'terms_and_conditions',
    ),
    BaseProfileModel(
      iconImg: R.appImages.privacyPolicyIcon,
      title: 'privacy_policy',
    ),
    BaseProfileModel(iconImg: R.appImages.deleteIcon, title: 'delete_account'),
    BaseProfileModel(iconImg: R.appImages.logoutIcon, title: 'logout'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: R.appColors.white,
      appBar: profileAppBar(),
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 16),
        itemBuilder: (context, index) {
          return menusWidget(model: baseProfileModel[index], indexValue: index);
        },

        itemCount: baseProfileModel.length,
      ),
    );
  }

  PreferredSize profileAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 30.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: R.appColors.secondaryColor,
            surfaceTintColor: R.appColors.secondaryColor,
            iconTheme: IconThemeData(color: R.appColors.white),
            title: Text(
              "profile".L(),
              style: R.textStyles.urbanist().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18.px,
                color: R.appColors.white,
              ),
            ),
            centerTitle: true,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(EditProfileView.route);
            },
            child: Container(
              padding: EdgeInsets.all(16) + EdgeInsets.symmetric(horizontal: 4),
              decoration: R.appDecorations.verticalRadiusBoxDec(
                radiusFromBottom: true,
                hideShadow: true,
                backgroundColor: R.appColors.secondaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageWidget(
                          height: 68.px,
                          width: 68.px,
                          isAddIcon: false,
                          isEnable: false,
                          isShowBorder:false,
                          grey: R.appColors.transparent,
                          backgroundColor: R.appColors.white,
                          isFile: AppUser.userData?.image != null &&AppUser.userData?.image != ""? true : false,
                          pickedFile: File(AppUser.userData?.image ?? ""),
                        ),
                        w2P5,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppUser.userData?.name ?? "UnKnown",
                                style: R.textStyles.urbanist().copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.px,
                                  color: R.appColors.white,overflow: TextOverflow.ellipsis
                                ),maxLines: 2,
                              ),
                              Text(
                                AppUser.userData?.email ?? "UnKnown",
                                style: R.textStyles.urbanist().copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.px,
                                  color: R.appColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  w5,
                  Text(
                    "edit".L(),
                    style: R.textStyles.urbanist(
                      fontWeight: FontWeight.w500,
                      color: R.appColors.white,
                      fontSize: 14.px,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menusWidget({
    required BaseProfileModel model,
    required int indexValue,
  }) {
    return GestureDetector(
      onTap: () => navigationFunc(index: indexValue),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11),
        color: R.appColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: R.appColors.disconnectColor,
                  child: Center(
                    child: Image.asset(
                      model.iconImg,
                      scale: 3.5,
                      color: indexValue == 1 ? R.appColors.white : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    model.title.L(),
                    style: R.textStyles.urbanist(
                      fontWeight: FontWeight.w500,
                      color: R.appColors.black,
                      fontSize: 16.px,
                    ),
                  ),
                ),
              ],
            ),
            if (model.title != "logout" && model.title != "delete_account")
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
                color: R.appColors.black,
              ),
          ],
        ),
      ),
    );
  }

  void navigationFunc({required int index}) {
    switch (index) {
      case 0:
        {
          Get.toNamed(SupportView.route);
        }
      case 1:
        {
          Get.toNamed(UpdatePasswordView.route);
        }
      case 2:
        {
          Get.toNamed(
            TermsAndPolicyView.route,
            arguments: {"title": "terms_and_conditions"},
          );
        }
      case 3:
        {
          Get.toNamed(
            TermsAndPolicyView.route,
            arguments: {"title": "privacy_policy"},
          );
        }
      case 4:
        {
          Get.toNamed(DeleteAccountView.route);
        }
      case 5:
        {
          Get.bottomSheet(
            LogoutSheet(
              onRightTab: () {
                AppUser.userData?.image=null;
                Get.offAllNamed(LoginView.route);
              },
              titleText: "are_you_sure_you_want_to_logout".L(),
            ),
          );
        }
    }
  }
}
