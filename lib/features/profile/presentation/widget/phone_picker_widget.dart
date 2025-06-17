import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../global/resources/resources.dart';

class PhoneNumPicker extends StatefulWidget {
  final ValueSetter<PhoneNumber>? phoneNumber;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? phone;
  final PhoneNumber? number;
  const PhoneNumPicker({
    super.key,
    this.phoneNumber,
    this.phone,
    required this.controller,
    required this.focusNode,
    this.number,
  });

  @override
  PhoneNumPickerState createState() => PhoneNumPickerState();
}

class PhoneNumPickerState extends State<PhoneNumPicker> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      formatInput: true,
      keyboardAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      key: const Key('phone_number'),
      textStyle: R.textStyles.urbanist(
        fontSize: 14.px,
        fontWeight: FontWeight.w500,
      ),
      selectorTextStyle: R.textStyles.urbanist(
        fontSize: 14.px,
        fontWeight: FontWeight.w500,
      ),
      searchBoxDecoration: R.appDecorations.inputDecoration(
        hintText: "search_by_country_name_or_code",
      ),
      inputDecoration: R.appDecorations.inputDecoration(
        hintText: "enter_phone_number",
        filledColor: R.appColors.fillColor,
      ),
      onInputChanged: (PhoneNumber pNumber) {
        number = pNumber;
        if (widget.phoneNumber != null) {
          widget.phoneNumber!(number);
        }
      },
      // onInputValidated: (bool value) {},
      textAlignVertical: TextAlignVertical.center,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        showFlags: false,
        trailingSpace: false,
        setSelectorButtonAsPrefixIcon: true,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      initialValue: widget.number ?? number,
      textFieldController: widget.controller,
      focusNode: widget.focusNode,
    );
  }
}
