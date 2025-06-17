import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

class DropdownWidget extends StatefulWidget {
  final String? selectedValue;
  final String hintText;
  final bool isDisable;
  final List<String> list;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const DropdownWidget({
    super.key,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
    required this.list,
    this.isDisable = false,
    required this.validator,
  });

  @override
  DropdownWidgetState createState() => DropdownWidgetState();
}

class DropdownWidgetState extends State<DropdownWidget> {
  String? selectedValue;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedValue = widget.selectedValue;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down,color: R.appColors.closeColor,),
          openMenuIcon: Transform.flip(
            flipY: true,
            child: Icon(Icons.arrow_drop_up),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          elevation: 1,
          offset: const Offset(-1, 0),
          decoration: BoxDecoration(
            color: R.appColors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
        ),
        hint:
            widget.hintText == ''
                ? null
                : Text(
                  widget.hintText.L(),
                  style: R.textStyles.inter(
                    fontSize: 15.sp,
                    color: R.appColors.subTitleGrey,
                  ),
                ),
        validator: widget.validator,
        items:
            widget.list
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: R.textStyles.inter(
                        fontSize: 16.sp,
                        color: R.appColors.black,
                      ),
                    ),
                  ),
                )
                .toList(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: selectedValue,
        onChanged: widget.isDisable == true ? null : widget.onChanged,
        menuItemStyleData: const MenuItemStyleData(height: 40),
        isDense: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
          filled: true,
          fillColor: R.appColors.fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: R.appColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: R.appColors.borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: R.appColors.borderColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: R.appColors.borderColor),
          ),
        ),
      ),
    );
  }
}
