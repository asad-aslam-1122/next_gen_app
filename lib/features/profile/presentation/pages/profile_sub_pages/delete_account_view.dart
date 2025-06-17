import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/login_view.dart';
import 'package:sizer/sizer.dart';

import '../../../../global/constants/heights_widths.dart';
import '../../../../global/resources/app_validator.dart';
import '../../../../global/resources/bot_toast/zbot_toast.dart';
import '../../../../global/resources/resources.dart';
import '../../../../global/utils/global_widgets/custom_button.dart';
import '../../../../global/utils/logout_sheet.dart';

class DeleteAccountView extends StatefulWidget {
  static String route = "/DeleteAccountView";
  const DeleteAccountView({super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  final _formKey = GlobalKey<FormState>();

  bool isOldPassVisible = false;

  TextEditingController oldPassTC = TextEditingController();

  FocusNode oldPassFN = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.white,
      appBar: AppBar(
        backgroundColor: R.appColors.white,
        surfaceTintColor: R.appColors.white,
        title: Text(
          "delete_account".L(),
          style: R.textStyles.urbanist().copyWith(
            fontWeight: FontWeight.w600,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "once_deleted_your_account_and_data_cannot_be_recovered"
                          .L(),
                      style: R.textStyles.urbanist(
                        fontSize: 15.px,
                        color: R.appColors.subTitleGrey,
                      ),
                    ),

                    h3,
                    Text(
                      "enter_your_password".L(),
                      style: R.textStyles.urbanist(fontSize: 12.px),
                    ),
                    h1,
                    oldPasswordField(),
                    h3,
                  ],
                ),
              ),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Get.bottomSheet(
                      LogoutSheet(
                        onRightTab: () {
                          ZBotToast.showToastSuccess(
                            title: "account_deleted".L(),
                            message:
                                "account_has_been_deleted_successfully".L(),
                          );
                          Get.offAllNamed(LoginView.route);
                        },
                        titleText:
                            "${"are_you_sure_you_want_to_delete_this_account".L()} ?",
                      ),
                    );
                  }
                },
                title: "proceed",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget oldPasswordField() {
    return TextFormField(
      controller: oldPassTC,
      focusNode: oldPassFN,
      textInputAction: TextInputAction.done,
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
        FocusScope.of(context).unfocus();
      },
    );
  }
}
