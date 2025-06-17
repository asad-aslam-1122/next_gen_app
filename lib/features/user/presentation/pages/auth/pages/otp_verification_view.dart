import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/login_view.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/pages/change_password_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../../../global/constants/heights_widths.dart';
import '../../../../../global/resources/app_validator.dart';
import '../../../../../global/resources/resources.dart';
import '../../../../../global/utils/congratulation_sheet.dart';
import '../../../../../global/utils/global_widgets/custom_button.dart';
import '../../../../../global/utils/global_widgets/safe_area_widget.dart';

class OtpVerificationView extends StatefulWidget {
  static String route = "/OtpVerificationView";
  const OtpVerificationView({super.key});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpTC = TextEditingController();
  FocusNode otpFN = FocusNode();
  Timer? _timer;
  int remainingTime = 60;
  bool isSignUp = false;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        _timer?.cancel();
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null) {
      isSignUp = Get.arguments['isSignUp'];
    }

    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  String formatTime(int time)
  {
    return time<10?"0$time":"$time";
  }
  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.white,
      child: Scaffold(
        backgroundColor: R.appColors.white,
        appBar: AppBar(
          backgroundColor: R.appColors.white,
          surfaceTintColor: R.appColors.white,
          toolbarHeight: 12.h,
          title: Image.asset(R.appImages.splashLogo, scale: 10),
          centerTitle: true,
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5.w) +
              EdgeInsets.only(bottom: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                              isSignUp
                                  ? "verify_your_account".L()
                                  : "reset_password".L(),
                              style: R.textStyles.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.px,
                              ),
                            ),
                            h0P5,
                            Text(
                              isSignUp
                                  ? "verification_subTitle".L()
                                  : "reset_pass_subtitle".L(),
                              style: R.textStyles.poppins(
                                fontSize: 14.px,
                                color: R.appColors.subTitleGrey,
                              ),
                            ),
                          ],
                        ),
                        h3,

                        if (!isSignUp)
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "enter_otp".L(),
                              style: R.textStyles.poppins(
                                fontSize: 12.px,
                                color: R.appColors.black,
                              ),
                            ),
                          ),
                        h2,
                        otpWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "00:${formatTime(remainingTime)} sec",
                              style: R.textStyles.urbanist(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.px,
                                color: R.appColors.subTitleGrey,
                              ),
                            ),
                            w2,
                            GestureDetector(
                              onTap: () {
                                if (remainingTime > 0) {
                                } else {
                                  resendCallback();
                                }
                              },
                              child: Text(
                                "resend_code".L(),
                                style: R.textStyles.urbanist(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.px,
                                  color: R.appColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (isSignUp) {
                        Get.bottomSheet(
                          CongratulationSheet(
                            title: "verification_sucessfully_completed".L(),
                            subtitle: "you_can_now_login_your_account".L(),
                          ),
                          isDismissible: false,
                        );
                        Future.delayed(Duration(seconds: 3), () {
                          Get.back();
                          Get.offAllNamed(LoginView.route);
                        });
                      } else {
                        Get.toNamed(ChangePasswordView.route);
                      }
                    }
                  },
                  title: isSignUp ? "verify" : "proceed",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // otp fields widgets
  Widget otpWidget() {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      textStyle: R.textStyles.urbanist(
        fontWeight: FontWeight.w600,
        color: R.appColors.black,
        fontSize: 18.px,
      ),
      animationType: AnimationType.fade,
      errorTextSpace: 20,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 40,
        fieldWidth: 40,
        activeColor: R.appColors.borderColor,
        activeFillColor: R.appColors.fillColor,
        selectedColor: R.appColors.borderColor,
        selectedFillColor: R.appColors.fillColor,
        inactiveFillColor: R.appColors.fillColor,
        inactiveColor: R.appColors.borderColor,
        errorBorderColor: R.appColors.red,
        activeBorderWidth: 1.3,
        selectedBorderWidth: 1.3,
        errorBorderWidth: 1.3,
        disabledBorderWidth: 1.3,
        inactiveBorderWidth: 1.3,
      ),
      animationDuration: Duration(milliseconds: 300),
      autoDisposeControllers: true,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: AppValidator.validateOTP,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      showCursor: true,
      cursorColor: R.appColors.primaryColor,
      // textStyle: ,
      cursorHeight: 20,
      controller: otpTC,
      focusNode: otpFN,
      onCompleted: (v) {},
    );
  }

  // Resend OTP Callback
  Future<void> resendCallback() async {
    otpTC.clear();
    remainingTime = 60;
    if (_timer!.isActive == false) {
      startTimer();
    }
  }
}
