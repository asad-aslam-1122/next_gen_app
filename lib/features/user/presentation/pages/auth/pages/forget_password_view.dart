import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/pages/otp_verification_view.dart';
import 'package:sizer/sizer.dart';

import '../../../../../global/constants/heights_widths.dart';
import '../../../../../global/resources/app_validator.dart';
import '../../../../../global/resources/resources.dart';
import '../../../../../global/utils/global_widgets/custom_button.dart';
import '../../../../../global/utils/global_widgets/safe_area_widget.dart';

class ForgetPasswordView extends StatefulWidget {
  static String route = "/ForgotPasswordView";
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTC = TextEditingController();
  FocusNode emailFN = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: R.appColors.white,
      // appBar: AppBar(
      //   backgroundColor: R.appColors.white,
      //   surfaceTintColor: R.appColors.white,
      //   toolbarHeight: 12.h,
      //   title: Image.asset(R.appImages.splashLogo, scale: 10),
      //   centerTitle: true,
      // ),
      body: SafeAreaWidget(
        top: true,
        backgroundColor: R.appColors.transparent,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            h2,
                            Text(
                              "forgot_password".L(),
                              style: R.textStyles.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.px,
                              ),
                            ),
                            h0P5,
                            Text(
                              "enter_your_registered_email_to_request_a_password_reset"
                                  .L(),
                              style: R.textStyles.poppins(
                                fontSize: 14.px,
                                color: R.appColors.subTitleGrey,
                              ),
                            ),
                          ],
                        ),
                        h3,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'email_address'.L(),
                            style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.appBarTitle),
                          ),
                        ),
                        h1,
                        emailField(),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Get.toNamed(
                        OtpVerificationView.route,
                        arguments: {"isSignUp": false},
                      );
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

  // email text field
  Widget emailField() {
    return TextFormField(
      controller: emailTC,
      focusNode: emailFN,
      autofillHints: [AutofillHints.email],
      textInputAction: TextInputAction.done,
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
    );
  }
}
