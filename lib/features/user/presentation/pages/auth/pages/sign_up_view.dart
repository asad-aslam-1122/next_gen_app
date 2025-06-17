import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/constants/app_user.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/bot_toast/zbot_toast.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:nextgen_reeftech/features/user/data/models/user_model.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/pages/terms_and_policy_view.dart';
import 'package:sizer/sizer.dart';

import '../../../../../global/constants/heights_widths.dart';
import '../../../../../global/resources/app_validator.dart';
import '../../../../../global/resources/resources.dart';
import '../../../../../global/utils/global_widgets/custom_button.dart';
import '../../../../../global/utils/global_widgets/image_picker/image_widget.dart';
import 'otp_verification_view.dart';

class SignUpView extends StatefulWidget {
  static String route = "/SignUpView";
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  File? profileImage;

  bool? isAccepted;

  TextEditingController emailTC = TextEditingController();
  TextEditingController nameTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPassTC = TextEditingController();

  FocusNode nameFN = FocusNode();
  FocusNode emailFN = FocusNode();
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
    return SafeAreaWidget(
      backgroundColor: R.appColors.transparent,
      top: true,
      child: Scaffold(
        backgroundColor: R.appColors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isAccepted ?? false) {
                      AppUser.userData = UserData(
                        name: nameTC.text,
                        email: emailTC.text,
                        image: profileImage?.path ?? "",
                      );

                      Get.toNamed(
                        OtpVerificationView.route,
                        arguments: {"isSignUp": true},
                      );
                    } else {
                      ZBotToast.showToastError(
                        message: "please_accept_terms".L(),
                      );
                    }
                  }
                },
                title: "sign_up",
              ),
              h2,
              RichText(
                text: TextSpan(
                  style: R.textStyles.poppins(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: R.appColors.secondaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: "${"already_have_an_account".L()}  ",
                      style: R.textStyles.poppins(
                        fontSize: 14.px,
                        color: R.appColors.darkGrey,
                      ),
                    ),
                    TextSpan(
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            },

                      text: "log_in_".L(),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              h1,
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: 16) +
              EdgeInsets.only(bottom: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                h2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "sign_up".L(),
                      style: R.textStyles.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.px,
                        color: R.appColors.primaryColor
                      ),
                    ),
                    h0P5,
                    Text(
                      "create_an_account_to_get_started".L(),
                      style: R.textStyles.poppins(
                        fontSize: 14.px,
                        color: R.appColors.subTitleGrey,
                      ),
                    ),
                  ],
                ),
                h2,
                profileWidget(),
                h2,
                labelText(labelText: "name".L()),
                h0P5,
                nameField(),
                h2,
                labelText(labelText: "email_address".L()),
                h0P5,
                emailField(),
                h2,
                labelText(labelText: "password".L()),
                h0P5,
                passwordField(),
                h2,
                labelText(labelText: "confirm_password".L()),
                h0P5,
                confirmPassField(),
                h2,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isAccepted = !(isAccepted ?? false);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (isAccepted ?? false)
                                  ? R.appColors.secondaryColor
                                  : R.appColors.transparent,
                          border: Border.all(color: R.appColors.subTitleGrey),
                        ),
                      ),
                    ),
                    w2,
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: R.textStyles.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.px,
                          ),
                          children: [
                            TextSpan(
                              text: "i_agree_with".L(),
                              style: R.textStyles.poppins(
                                fontSize: 12.px,
                                color: R.appColors.subTitleGrey,
                              ),
                            ),
                            TextSpan(
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(
                                        TermsAndPolicyView.route,
                                        arguments: {
                                          "title": "terms_and_conditions",
                                        },
                                      );
                                    },
                              text: " ${"terms_conditions".L()}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: emailTC,
      focusNode: emailFN,
      autofillHints: [AutofillHints.email],
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,

      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_email",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
      ),
      onTapOutside: (v) {
        emailFN.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(emailFN);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: AppValidator.validateEmail,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(passwordFN);
      },
    );
  }

  Widget nameField() {
    return TextFormField(
      controller: nameTC,
      focusNode: nameFN,
      autofillHints: [AutofillHints.name],
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      inputFormatters: [LengthLimitingTextInputFormatter(50)],
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_name",
        filledColor: R.appColors.fillColor,
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
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(emailFN);
      },
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
                    : R.appColors.disconnectColor,
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
                    : R.appColors.disconnectColor,
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
          (value) => AppValidator.validatePasswordMatch(value, passwordTC.text),
    );
  }

  Widget labelText({required String labelText}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(labelText, style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.appBarTitle)),
    );
  }

  void disposeTextFields() {
    nameTC.dispose();
    nameFN.dispose();
    emailTC.dispose();
    emailFN.dispose();
    passwordTC.dispose();
    passwordFN.dispose();
    confirmPassTC.dispose();
    confirmPassFN.dispose();
  }

  Widget profileWidget() {
    return Row(
      children: [
        ImageWidget(
          emptyIcon: R.appImages.userOutlineIcon,
          height: 60,
          width: 60,
          isAddIcon: false,
          backgroundColor: R.appColors.lightGrey1,
          grey: R.appColors.lightGrey1,
          isFile: true,
          isCircle: true,
          pickedFile: profileImage,
          uploadImage: (value) {
            if (value != null) {
              profileImage = value;
              setState(() {});
            }
          },
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "profile_picture".L(),
                  style: R.textStyles.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.px,
                  ),
                ),
                w1P5,
                Text(
                  "_optional_".L(),
                  style: R.textStyles.poppins(
                    fontSize: 10.px,
                    color: R.appColors.subTitleGrey,
                  ),
                ),
              ],
            ),
            h0P1,
            Text(
              "click_to_upload_an_image".L(),
              style: R.textStyles.poppins(
                fontSize: 10.px,
                color: R.appColors.subTitleGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
