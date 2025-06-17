import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../../global/constants/heights_widths.dart';
import '../../../../global/resources/app_validator.dart';
import '../../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../../global/resources/resources.dart';
import '../../../../global/utils/global_widgets/custom_button.dart';

class UpdatePasswordView extends StatefulWidget {
  static String route = "/UpdatePasswordView";
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  TextEditingController oldPassTC = TextEditingController();
  TextEditingController passTC = TextEditingController();
  TextEditingController confirmPassTC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FocusNode oldPassFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode confirmPassFN = FocusNode();

  bool isOldPassVisible = false;
  bool isPassVisible = false;
  bool isConfirmPassVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: R.appColors.white,
      appBar: AppBar(
        backgroundColor: R.appColors.white,
        surfaceTintColor: R.appColors.white,
        title: Text(
          "change_password".L(),
          style: R.textStyles.urbanist().copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18.px,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "update_your_password_to_keep_your_account_secure".L(),
                        style: R.textStyles.poppins(
                          fontSize: 14.px,
                          color: R.appColors.subTitleGrey,
                        ),
                      ),
                      h3,
                      labelText(labelText: "enter_your_current_password"),
                      h1,
                      oldPasswordField(),
                      h2,
                      labelText(labelText: "enter_your_new_password"),
                      h1,
                      passwordField(),
                      h2,
                      labelText(labelText: "re_enter_your_new_password"),
                      h1,
                      confirmPasswordField(),
                      h10,
                    ],
                  ),
                ),
              ),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ZBotToast.showToastSuccess(
                      title: "password_changed".L(),
                      message: "password_has_been_changed_successfully".L(),
                    );
                    Get.back();
                  }
                },
                title: "change_password",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // widgets

  Widget labelText({required String labelText}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(labelText.L(), style: R.textStyles.poppins(fontSize: 12.px)),
    );
  }

  Widget oldPasswordField() {
    return TextFormField(
      controller: oldPassTC,
      focusNode: oldPassFN,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      obscuringCharacter: "*",
      obscureText: !isOldPassVisible,
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_password",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
        suffixIcon: IconButton(
          onPressed: () {
            isOldPassVisible = !isOldPassVisible;
            setState(() {});
          },
          icon: Image.asset(
            isOldPassVisible
                ? R.appImages.visibilityOff
                : R.appImages.visibilityOn,
            scale: 4,
            color:
                oldPassFN.hasFocus
                    ? R.appColors.secondaryColor
                    : R.appColors.disconnectColor,
          ),
        ),
      ),
      onTapOutside: (v) {
        oldPassFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(oldPassFN);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: AppValidator.validateLoginPassword,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(passFN);
      },
    );
  }

  // password text field
  Widget passwordField() {
    return TextFormField(
      controller: passTC,
      focusNode: passFN,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      obscuringCharacter: "*",
      obscureText: !isPassVisible,
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_password",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
        suffixIcon: IconButton(
          onPressed: () {
            isPassVisible = !isPassVisible;
            setState(() {});
          },
          icon: Image.asset(
            isPassVisible
                ? R.appImages.visibilityOff
                : R.appImages.visibilityOn,
            scale: 4,
            color:
                passFN.hasFocus ? R.appColors.secondaryColor : R.appColors.disconnectColor,
          ),
        ),
      ),
      onTapOutside: (v) {
        passFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(passFN);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: AppValidator.validatePassword,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(confirmPassFN);
      },
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      controller: confirmPassTC,
      focusNode: confirmPassFN,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscuringCharacter: "*",
      obscureText: !isConfirmPassVisible,
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_password",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
        suffixIcon: IconButton(
          onPressed: () {
            isConfirmPassVisible = !isConfirmPassVisible;
            setState(() {});
          },
          icon: Image.asset(
            isConfirmPassVisible
                ? R.appImages.visibilityOff
                : R.appImages.visibilityOn,
            scale: 4,
            color:
                passFN.hasFocus ? R.appColors.secondaryColor : R.appColors.disconnectColor,
          ),
        ),
      ),
      onTapOutside: (v) {
        confirmPassFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(confirmPassFN);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:
          (value) => AppValidator.validatePasswordMatch(value, passTC.text),
    );
  }
}
