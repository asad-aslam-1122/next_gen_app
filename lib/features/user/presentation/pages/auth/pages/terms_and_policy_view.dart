import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../../../global/resources/resources.dart';

class TermsAndPolicyView extends StatefulWidget {
  static String route = "/TermsAndPolicyView";

  const TermsAndPolicyView({super.key});

  @override
  State<TermsAndPolicyView> createState() => _TermsAndPolicyViewState();
}

class _TermsAndPolicyViewState extends State<TermsAndPolicyView> {
  String? title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = Get.arguments["title"];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.white,
      appBar: AppBar(
        backgroundColor: R.appColors.white,
        surfaceTintColor: R.appColors.white,
        title: Text(
          title != null ? title!.L() : "",
          style: R.textStyles.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16.px,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est "
          "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est "
          "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est "
          "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est "
          "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est "
          "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est "
          "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est ",
          style: R.textStyles.poppins(fontSize: 12.px),
        ),
      ),
    );
  }
}
