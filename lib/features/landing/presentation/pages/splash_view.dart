import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/landing/presentation/pages/onboard_base_view.dart';

import '../../../global/resources/resources.dart';

class SplashView extends StatefulWidget {
  static String route = "/SplashView";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.backgroundColor,
      body: Center(child: Image.asset(R.appImages.splashLogo, scale: 4)),
    );
  }

  void navigateToNext() async {
    await Future.delayed(Duration(seconds: 2), () async {
      Get.offAllNamed(OnboardBaseView.route);
    });
  }
}
