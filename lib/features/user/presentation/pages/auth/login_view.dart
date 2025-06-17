import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/constants/heights_widths.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/safe_area_widget.dart';
import 'package:nextgen_reeftech/features/home/presentation/pages/home_view.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/pages/forget_password_view.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/pages/sign_up_view.dart';
import 'package:sizer/sizer.dart';

import '../../../../global/constants/app_user.dart';
import '../../../../global/resources/app_validator.dart';
import '../../../../global/resources/resources.dart';
import '../../../data/models/user_model.dart';
import '../../../../global/utils/global_widgets/pop_scope_widget.dart';

class LoginView extends StatefulWidget {
  static String route = "/LoginView";

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();

  FocusNode emailFN = FocusNode();
  FocusNode passwordFN = FocusNode();

  bool isVisible = false;
  bool isKeyboardVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    disposeTextFields();
  }

  @override
  Widget build(BuildContext context) {
    return PopScopeWidget.onPop(
      child: SafeAreaWidget(
        backgroundColor: R.appColors.transparent,
        top: true,
        child: Scaffold(
          backgroundColor: R.appColors.white,
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
                          Center(
                            child: Image.asset(R.appImages.splashLogo, height: 100,width: 100),
                          ),
                          h2,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "login_to_your_account".L(),
                                style: R.textStyles.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24.px,
                                  color: R.appColors.primaryColor
                                ),
                              ),
                              h0P5,
                              Text(
                                "please_enter_your_details_below_to_continue".L(),
                                style: R.textStyles.poppins(
                                  fontSize: 14.px,
                                  color: R.appColors.subTitleGrey,
                                ),
                              ),
                            ],
                          ),
                          h4,
                          labelText(labelText: "email_address".L()),
                          h1,
                          emailField(),
                          h2P5,
                          labelText(labelText: "password".L()),
                          h1,
                          passwordField(),
                          h1P5,
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(ForgetPasswordView.route);
                              },
                              child: Text(
                                "forgot_password?".L(),
                                style: R.textStyles.poppins(fontSize: 14.px,color: R.appColors.appBarTitle),
                              ),
                            ),
                          ),
                          h5,
                          CustomButton(
                            onPressed: () {
                              if(_formKey.currentState?.validate() ?? false){
                                AppUser.userData = UserData(
                                    name: AppUser.userData?.name ?? "John Doe",
                                    email: AppUser.userData?.email ?? emailTC.text,
                                    image: AppUser.userData?.image ?? null
                                );
                                Get.offAllNamed(HomeView.route);
                              }
                            },
                            title: "log_in",
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      Get.toNamed(SignUpView.route);
                    },
                    title: "sign_up",
                    textColor: R.appColors.darkGreyColor1,
                    backgroundColor: R.appColors.transparent,
                    textSize: 14.px,
                    textWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText({required String labelText}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(labelText, style: R.textStyles.poppins(fontSize: 12.px,color: R.appColors.cancelColor)),
    );
  }

  void disposeTextFields() {
    emailTC.dispose();
    emailFN.dispose();
    passwordTC.dispose();
    passwordFN.dispose();
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

  Widget passwordField() {
    return TextFormField(
      controller: passwordTC,
      focusNode: passwordFN,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscuringCharacter: "*",
      obscureText: !isVisible,
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "enter_password",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
        suffixIcon: IconButton(
          onPressed: () {
            isVisible = !isVisible;
            setState(() {});
          },
          icon: Image.asset(
            isVisible ? R.appImages.visibilityOff : R.appImages.visibilityOn,
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: AppValidator.validateLoginPassword,
    );
  }
}
