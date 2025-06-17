import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/landing/presentation/pages/onboard_base_view.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/schedule_bottom_sheet.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_base_view.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_sub_pages/delete_account_view.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_sub_pages/support_view.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_sub_pages/update_password_view.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/accimilation_view.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/login_view.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/pages/otp_verification_view.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/pages/sign_up_view.dart';

import '../../home/presentation/pages/connect_wifi_view.dart';
import '../../home/presentation/pages/device_settings_view.dart';
import '../../home/presentation/pages/find_devices_view.dart';
import '../../home/presentation/pages/home_view.dart';
import '../../home/presentation/pages/import_properties_view.dart';
import '../../home/presentation/pages/qr_code_view.dart';
import '../../landing/presentation/pages/splash_view.dart';
import '../../modes/presentation/pages/brightness_view.dart';
import '../../modes/presentation/pages/modes_view.dart';
import '../../modes/presentation/pages/scheduling_view.dart';
import '../../modes/presentation/pages/set_channel_view.dart';
import '../../profile/presentation/pages/profile_sub_pages/edit_profile_view.dart';
import '../../profile/presentation/pages/profile_sub_pages/support_phone_num_view.dart';
import '../../user/presentation/pages/auth/pages/change_password_view.dart';
import '../../user/presentation/pages/auth/pages/forget_password_view.dart';
import '../../user/presentation/pages/auth/pages/terms_and_policy_view.dart';

abstract class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: SplashView.route,
      page: () => const SplashView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: ModesView.route,
      page: () => const ModesView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: SetChannelView.route,
      page: () => const SetChannelView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: HomeView.route,
      page: () => const HomeView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: FindDevicesView.route,
      page: () => const FindDevicesView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: SchedulingView.route,
      page: () => const SchedulingView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),

    GetPage(
      name: OnboardBaseView.route,
      page: () => const OnboardBaseView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: LoginView.route,
      page: () => const LoginView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: SignUpView.route,
      page: () => const SignUpView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: OtpVerificationView.route,
      page: () => const OtpVerificationView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: ForgetPasswordView.route,
      page: () => const ForgetPasswordView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: ProfileBaseView.route,
      page: () => ProfileBaseView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: EditProfileView.route,
      page: () => EditProfileView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: DeleteAccountView.route,
      page: () => DeleteAccountView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: SupportView.route,
      page: () => SupportView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: UpdatePasswordView.route,
      page: () => UpdatePasswordView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: TermsAndPolicyView.route,
      page: () => TermsAndPolicyView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: SupportPhoneNumView.route,
      page: () => SupportPhoneNumView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: AccimilationView.route,
      page: () => AccimilationView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: DeviceSettingsView.route,
      page: () => DeviceSettingsView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: ConnectWifiView.route,
      page: () => ConnectWifiView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),

    GetPage(
      name: BrightnessView.route,
      page: () => BrightnessView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: ImportPropertiesView.route,
      page: () => ImportPropertiesView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: QRCodeView.route,
      page: () => QRCodeView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: ChangePasswordView.route,
      page: () => ChangePasswordView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];
}
