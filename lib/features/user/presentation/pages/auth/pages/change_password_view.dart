import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../global/constants/heights_widths.dart';
import '../../../../../global/resources/app_validator.dart';
import '../../../../../global/resources/resources.dart';
import '../../../../../global/utils/congratulation_sheet.dart';
import '../../../../../global/utils/global_widgets/custom_button.dart';
import '../login_view.dart';

class ChangePasswordView extends StatefulWidget {
  static String route = "/ChangePasswordView";
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  File? profileImage;

  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPassTC = TextEditingController();

  FocusNode confirmPassFN = FocusNode();
  FocusNode passwordFN = FocusNode();

  bool showPass = false;
  bool showConfirmPass = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    disposeTextFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.white,
      // appBar: AppBar(
      //   backgroundColor: R.appColors.white,
      //   surfaceTintColor: R.appColors.white,
      //   toolbarHeight: 12.h,
      //   title: Image.asset(R.appImages.splashLogo, scale: 10),
      //   centerTitle: true,
      // ),
      body: SafeAreaWidget(
        backgroundColor: R.appColors.transparent,
        top: true,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16) +
              EdgeInsets.only(bottom: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                h2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.arrow_back,color: R.appColors.appBarTitle,),
                    ),
                    Image.asset(R.appImages.splashLogo, scale: 10),
                    Icon(Icons.arrow_back,color: R.appColors.transparent,),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h2,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "change_password".L(),
                              style: R.textStyles.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 21.px,
                              ),
                            ),
                            h0P5,
                            Text(
                              "change_pass_subtitle".L(),
                              style: R.textStyles.poppins(
                                fontSize: 12.px,
                                color: R.appColors.subTitleGrey,
                              ),
                            ),
                          ],
                        ),
                        h2,
                        labelText(labelText: "password".L()),
                        h1,
                        passwordField(),
                        h2P5,
                        labelText(labelText: "confirm_password".L()),
                        h1,
                        confirmPassField(),
                        h2,
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.bottomSheet(
                        CongratulationSheet(
                          title: "congratulations".L(),
                          subtitle: "congratulate_subtitle".L(),
                        ),
                        isDismissible: false,
                      );
                      Future.delayed(Duration(seconds: 3), () {
                        Get.back();
                        Get.offAllNamed(LoginView.route);
                      });
                    }
                  },
                  title: "proceed",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordTC,
      focusNode: passwordFN,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      obscuringCharacter: "*",
      obscureText: !showPass,
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_password",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
        suffixIcon: IconButton(
          onPressed: () {
            showPass = !showPass;
            setState(() {});
          },
          icon: Image.asset(
            showPass ? R.appImages.visibilityOff : R.appImages.visibilityOn,
            scale: 4.5,
            color:
                passwordFN.hasFocus
                    ? R.appColors.secondaryColor
                    : R.appColors.grey,
          ),
        ),
      ),
      onTapOutside: (v) {
        passwordFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(passwordFN);
        setState(() {});
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(confirmPassFN);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: AppValidator.validatePassword,
    );
  }

  Widget confirmPassField() {
    return TextFormField(
      controller: confirmPassTC,
      focusNode: confirmPassFN,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscuringCharacter: "*",
      obscureText: !showConfirmPass,
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_confirm_password",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
        suffixIcon: IconButton(
          onPressed: () {
            showConfirmPass = !showConfirmPass;
            setState(() {});
          },
          icon: Image.asset(
            showConfirmPass
                ? R.appImages.visibilityOff
                : R.appImages.visibilityOn,
            scale: 4.5,
            color:
                confirmPassFN.hasFocus
                    ? R.appColors.secondaryColor
                    : R.appColors.grey,
          ),
        ),
      ),
      onTapOutside: (v) {
        passwordFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(passwordFN);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:
          (value) => AppValidator.validatePasswordMatch(value, passwordTC.text),
    );
  }

  Widget labelText({required String labelText}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(labelText, style: R.textStyles.poppins(fontSize: 12.px)),
    );
  }

  void disposeTextFields() {
    passwordTC.dispose();
    confirmPassFN.dispose();
  }
}
