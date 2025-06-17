import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources.dart';
import 'my_loader.dart';

class ZBotToast {
  static Future loadingClose() async {
    BotToast.cleanAll();
    await Future.delayed(const Duration(milliseconds: 100));
  }

  static loadingShow() async {
    BotToast.showCustomLoading(
      toastBuilder: (func) {
        return MyLoader(color: R.appColors.black);
      },
      allowClick: false,
      clickClose: false,
      backgroundColor: Colors.transparent,
    );
    Future.delayed(const Duration(seconds: 60), () => loadingClose());
  }

  static showToastSuccess({
    String? title,
    required String message,
    Duration? duration,
  }) async {
    await loadingClose();

    BotToast.showCustomText(
      toastBuilder: (func) {
        return Material(
          color: R.appColors.transparent,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: R.appColors.white,
              boxShadow: [
                BoxShadow(
                  color: R.appColors.black.withValues(alpha: 0.2),
                  spreadRadius: 8,
                  blurRadius: 30,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              leading: Image.asset(R.appImages.toastCheck, scale: 4),
              title:
                  title != null
                      ? Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: R.textStyles.poppins().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.px,
                        ),
                      )
                      : Text(message, style: R.textStyles.poppins()),
              subtitle:
                  title != null
                      ? Text(
                        message,
                        style: R.textStyles.poppins(
                          fontSize: 11.px,
                          color: R.appColors.subTitleGrey,
                        ),
                      )
                      : null,
            ),
          ),
        );
      },
      clickClose: true,
      crossPage: true,
      animationReverseDuration: const Duration(seconds: 1),
      animationDuration: const Duration(seconds: 1),
      align: Alignment.topCenter,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static showToastError({
    String? title,
    required String message,
    Duration? duration,
  }) async {
    await loadingClose();

    BotToast.showCustomText(
      toastBuilder: (func) {
        return Material(
          color: R.appColors.transparent,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: R.appColors.redToast,
              border: Border.all(color: R.appColors.red, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: R.appColors.black.withValues(alpha: 0.2),
                  spreadRadius: 8,
                  blurRadius: 30,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              leading: Image.asset(R.appImages.errorIcon, scale: 4),
              visualDensity: VisualDensity.compact,
              title:
                  title != null
                      ? Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: R.textStyles.poppins().copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      : Text(message, style: R.textStyles.poppins()),
              subtitle:
                  title != null
                      ? Text(message, style: R.textStyles.poppins())
                      : null,
            ),
          ),
        );
      },
      clickClose: true,
      crossPage: true,
      align: Alignment.topCenter,
      animationReverseDuration: const Duration(seconds: 1),
      animationDuration: const Duration(seconds: 1),
      duration: duration ?? const Duration(seconds: 2),
    );
  }
}
