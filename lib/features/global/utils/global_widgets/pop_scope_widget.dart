import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';

import '../../resources/bot_toast/zbot_toast.dart';

class PopScopeWidget {
  static DateTime? currentBackPressTime;

  static Widget onPop({required Widget child,bool canPop=false}) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        onBackPressed();
      },
      child: child,
    );
  }

  static void onBackPressed() {
    final now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      currentBackPressTime = now;
      ZBotToast.showToastError(message: "press_again_to_exit".L());
      return;
    }
    exit(0);
  }
}
