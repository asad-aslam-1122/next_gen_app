

import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';

class AppValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please_enter_your_email".L();
    }
    final emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );

    if (!emailRegex.hasMatch(value)) {
      return "enter_a_valid_email".L();
    }

    final domainExtensionRegex = RegExp(r'\.(?:[a-zA-Z]{2,})$');
    if (!domainExtensionRegex.hasMatch(value) ||
        RegExp(r'\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})+$').hasMatch(value)) {
      return "enter_a_valid_email".L();
    }

    if (value.contains(
      RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
      ),
    )) {
      return "emojis_are_not_allowed".L();
    }

    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_password".L();
    }
    if (!RegExp(r'^[^\s]').hasMatch(value)) {
      return "please_enter_your_password".L();
    }
    if (value.length < 6) {
      return "password_consists_minimum_6_character".L();
    }
    return null;
  }

  static String? validateWifiPassword(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_password".L();
    }
    if (value.length < 8) {
      return "password_consists_minimum_8_character".L();
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_name".L();
    }
    if (RegExp(r'\s$').hasMatch(value)) {
      return "leading_trailing_space_not_allowed".L();
    }

    if (RegExp(r'^\s').hasMatch(value)) {
      return "leading_trailing_space_not_allowed".L();
    }
    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(value)) {
      return "invalid_name".L();
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_password".L();
    }
    if (!RegExp(r'^[^\s]').hasMatch(value)) {
      return "please_enter_your_password".L();
    }
    if (value.length < 6) {
      return "password_must_be_at_least".L();
    }
    if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
      return "password_must_contains_at_least_one_number".L();
    }
    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value.trim())) {
      return "password_must_contains_at_least_one_special_character".L();
    }
    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
      return "password_must_contains_at_least_one_upper_case".L();
    }
    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
      return "password_must_contains_at_least_one_lower_case".L();
    }
    return null;
  }

  static String? validatePasswordMatch(String? value, String? pass2) {
    if (value!.isEmpty) {
      return "please_re_enter_your_password".L();
    }
    if (value != pass2) {
      return "password_did_not_match".L();
    }
    return null;
  }

  static String? validateDOB(String? value) {
    if (value!.isEmpty) {
      return "please_select_your_date_of_birth".L();
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value!.isEmpty) return "please_enter_your_otp".L();
    if (value.length < 6) {
      return "invalid_otp".L();
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return "field_required".L();
    }
    return null;
  }

  static String? validateBusinessName(String? value) {
    if (value!.isEmpty) {
      return "business_name_required".L();
    }
    if (RegExp(r'\s$').hasMatch(value)) {
      return "leading_trailing_space_not_allowed".L();
    }

    if (RegExp(r'^\s').hasMatch(value)) {
      return "leading_trailing_space_not_allowed".L();
    }
    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(value)) {
      return "invalid_name".L();
    }
    return null;
  }

  static String? validateDropdown(String? value) {
    if (value == null) {
      return "field_required".L();
    }
    return null;
  }

  static String? validateBusinessLocation(String? value) {
    if (value!.isEmpty) {
      return "business_location_required".L();
    }
    return null;
  }

  static String? validateMessage(String? value) {
    if (value!.isEmpty) {
      return "message_required".L();
    }
    return null;
  }

  // Custom validator functions
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }



  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return null; // Optional field
    if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateYear(String? value,{String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    final year = int.tryParse(value) ?? 0;
    if (year < 1900 || year > DateTime.now().year + 1) {
      return 'Enter a valid year between 1900-${DateTime.now().year + 1}';
    }
    return null;
  }

  String? validatePercentage(String? value,{String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    final percent = int.tryParse(value.replaceAll('%', '')) ?? 0;
    if (percent < 0 || percent > 100) {
      return 'Enter a percentage between 0-100';
    }
    return null;
  }

  String? validateVin(String? value,{String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length != 17) {
      return 'VIN must be 17 characters';
    }
    return null;
  }

  String? validateDecimal(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return '$fieldName must be a number';
    }
    return null;
  }

  String? validateInteger(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (int.tryParse(value) == null) {
      return '$fieldName must be a whole number';
    }
    return null;
  }
}
