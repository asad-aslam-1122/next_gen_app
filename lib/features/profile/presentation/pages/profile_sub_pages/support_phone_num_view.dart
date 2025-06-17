import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:nextgen_reeftech/features/global/constants/heights_widths.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../../global/resources/resources.dart';
import '../../widget/phone_picker_widget.dart';

class SupportPhoneNumView extends StatefulWidget {
  static String route = "/SupportPhoneNumView";

  SupportPhoneNumView({super.key});

  @override
  State<SupportPhoneNumView> createState() => _SupportPhoneNumViewState();
}

class _SupportPhoneNumViewState extends State<SupportPhoneNumView> {
  TextEditingController phoneNumTC = TextEditingController();

  FocusNode phoneNumFN = FocusNode();

  late PhoneNumber number;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumTC.dispose();
    phoneNumFN.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.white,
      appBar: AppBar(
        backgroundColor: R.appColors.white,
        surfaceTintColor: R.appColors.white,
        title: Text(
          "support".L(),
          style: R.textStyles.urbanist().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.px,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "please_enter_your_phone_number".L(),
                    style: R.textStyles.urbanist().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.px,
                    ),
                  ),

                  h2,

                  labelText(labelText: "enter_your_phone".L()),
                  h1,
                  phoneNumPicker(),

                  h4,
                ],
              ),
            ),
            CustomButton(
              onPressed: () {
                ZBotToast.showToastSuccess(
                  title: "ticket_created".L(),
                  message: "ticket_has_been_created_successfully".L(),
                );
                Get.back();
              },
              title: "submit",
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneNumPicker() {
    return PhoneNumPicker(
      controller: phoneNumTC,
      focusNode: phoneNumFN,
      phoneNumber: (phoneNumber) {
        number = phoneNumber;
      },
      phone: "03123456789",
    );
  }

  Widget labelText({required String labelText}) {
    return Text(labelText, style: R.textStyles.poppins(fontSize: 12.px));
  }
}
