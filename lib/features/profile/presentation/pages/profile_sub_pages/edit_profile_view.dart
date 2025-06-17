import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../global/constants/app_user.dart';
import '../../../../global/constants/heights_widths.dart';
import '../../../../global/resources/app_validator.dart';
import '../../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../../global/resources/resources.dart';
import '../../../../global/utils/global_widgets/custom_button.dart';
import '../../../../global/utils/global_widgets/image_picker/image_widget.dart';

class EditProfileView extends StatefulWidget {
  static String route = "/EditProfileView";

  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameTC = TextEditingController();
  TextEditingController emailTC = TextEditingController();

  FocusNode nameFN = FocusNode();
  FocusNode emailFN = FocusNode();

  File? profileImage;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameFN.dispose();
    emailFN.dispose();
    emailTC.dispose();
    nameTC.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailTC.text = AppUser.userData?.email ?? '';
    nameTC.text = AppUser.userData?.name ?? '';
    profileImage =
        AppUser.userData?.image == null
            ? null
            : File(AppUser.userData?.image ?? "");
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.white,
      appBar: AppBar(
        backgroundColor: R.appColors.white,
        surfaceTintColor: R.appColors.white,
        title: Text(
          "edit_profile".L(),
          style: R.textStyles.urbanist().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.px,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeAreaWidget(
        top: true,
        backgroundColor: R.appColors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        h2,
                        ImageWidget(
                          height: 100,
                          width: 100,
                          isEnable: true,
                          isAddIcon: profileImage != null ? true : false,
                          isCircle: true,
                          backgroundColor: R.appColors.lightGrey1,
                          grey: R.appColors.lightGrey1,
                          isFile: true,
                          cameraColor: R.appColors.white,
                          pickedFile: profileImage,
                          uploadImage: (value) {
                            if (value != null) {
                              profileImage = value;
                              setState(() {});
                            }
                          },
                        ),
                        h4,
                        nameTextField(),
                        h2,
                        emailTextField(),
                        h3,
                      ],
                    ),
                  ),
                ),

                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      AppUser.userData?.name = nameTC.text;
                      AppUser.userData?.image = profileImage?.path ?? "";

                      ZBotToast.showToastSuccess(
                        title: "profile_updated".L(),
                        message: "profile_has_been_updated_successfully".L(),
                      );

                      Get.forceAppUpdate();

                      Get.back();
                    }
                  },
                  title: "update",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText({required String labelText}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        labelText,
        style: R.textStyles.urbanist(
          fontSize: 15.px,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: nameTC,
      focusNode: nameFN,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.name,
      inputFormatters: [LengthLimitingTextInputFormatter(50)],
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_name",
        showBorder: true,
        filledColor: R.appColors.fillColor,
        contentPadding: 16,
        borderRadius: 10,
      ),
      onTapOutside: (v) {
        nameFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(nameFN);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: AppValidator.validateName,
    );
  }

  Widget emailTextField() {
    return TextFormField(
      controller: emailTC,
      focusNode: emailFN,
      style: R.textStyles.urbanist(color: R.appColors.grey, fontSize: 14.px),
      readOnly: true,
      autofillHints: [AutofillHints.email],
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_email",
        isReadOnly: true,
        filledColor: R.appColors.fillColor,
        contentPadding: 17.5,
        borderRadius: 10,
      ),
      onTapOutside: (v) {
        emailFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(emailFN);
        setState(() {});
      },
    );
  }
}
