import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/constants/heights_widths.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/app_validator.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/drop_down_widget.dart';
import 'package:nextgen_reeftech/features/profile/data/model/support_model.dart';
import 'package:nextgen_reeftech/features/profile/presentation/pages/profile_sub_pages/support_phone_num_view.dart';
import 'package:sizer/sizer.dart';

import '../../../../global/resources/resources.dart';
import '../../../../global/utils/global_widgets/custom_button.dart';

class SupportView extends StatefulWidget {
  static String route = "/SupportView";
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {
  String? selectedValue;

  TextEditingController detailTC = TextEditingController();
  FocusNode detailFN = FocusNode();

  List<SupportModel> problemsList = [
    SupportModel(label: "indicator_light_showing_problem".L()),
    SupportModel(label: "hardware_issue".L()),
    SupportModel(label: "software_issue".L()),
  ];
  List<SupportModel> channelsList = [
    SupportModel(label: "CH1"),
    SupportModel(label: "CH2"),
    SupportModel(label: "CH3"),
    SupportModel(label: "CH4"),
    SupportModel(label: "CH5"),
    SupportModel(label: "CH6"),
  ];

  List<String> devicesList = [
    "Nextgen-atmos-40",
    "Nextgen-atmos-41",
    "Nextgen-atmos-42",
    "Nextgen-atmos-43",
    "Nextgen-atmos-44",
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detailTC.dispose();
    detailFN.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Segment 1
                      Text(
                        "which_led_lighting_system_is_experiencing_issues".L(),
                        style: R.textStyles.poppins(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      h1P5,
                      DropdownWidget(
                        selectedValue: selectedValue,
                        hintText: "please_select",
                        onChanged: (newValue) {
                          selectedValue = newValue;
                          setState(() {});
                        },
                        list: devicesList,
                        validator: AppValidator.validateDropdown,
                      ),
                      h2,

                      // Segment 2
                      if (selectedValue != null) ...[
                        Text(
                          "_select_problem".L(),
                          style: R.textStyles.poppins(
                            fontSize: 14.px,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        h1P5,
                        ...List.generate(problemsList.length, (index) {
                          SupportModel supportModel = problemsList[index];

                          return problemWidget(model: supportModel);
                        }),
                        h0P5,
                      ],

                      // Segment 3
                      if (selectedValue != null &&
                          problemsList.any(
                            (element) => element.isEnable == true,
                          )) ...[
                        Text(
                          "_channel_options".L(),
                          style: R.textStyles.poppins(
                            fontSize: 14.px,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        h1P5,
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 30,
                                mainAxisSpacing: 8,
                              ),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            SupportModel model = channelsList[index];

                            return problemWidget(model: model);
                          },
                          itemCount: channelsList.length,
                        ),
                        h1,
                      ],

                      // Segment 4
                      if (selectedValue != null &&
                          problemsList.any(
                            (element) => element.isEnable == true,
                          ) &&
                          channelsList.any(
                            (element) => element.isEnable == true,
                          )) ...[
                        Text(
                          "_in_detail_please_describe_the_issues_you_are_facing"
                              .L(),
                          style: R.textStyles.poppins(
                            fontSize: 14.px,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        h1P5,
                        detailField(),
                        h0P5,
                      ],
                    ],
                  ),
                ),
              ),
              h1,
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedValue != null &&
                        problemsList.any(
                          (element) => element.isEnable == true,
                        ) &&
                        channelsList.any(
                          (element) => element.isEnable == true,
                        )) {
                      Get.offAndToNamed(SupportPhoneNumView.route);
                    }
                  }
                },
                backgroundColor:
                    (detailTC.text.isNotEmpty &&
                            selectedValue != null &&
                            problemsList.any(
                              (element) => element.isEnable == true,
                            ) &&
                            channelsList.any(
                              (element) => element.isEnable == true,
                            ))
                        ? null
                        : R.appColors.fillColor,

                textColor:
                    (detailTC.text.isNotEmpty &&
                            selectedValue != null &&
                            problemsList.any(
                              (element) => element.isEnable == true,
                            ) &&
                            channelsList.any(
                              (element) => element.isEnable == true,
                            ))
                        ? null
                        : R.appColors.separatorColor,

                title: "proceed",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailField() {
    return TextFormField(
      controller: detailTC,
      focusNode: detailFN,
      minLines: 5,
      maxLines: 7,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onChanged: (newValue) {
        setState(() {});
      },
      decoration: R.appDecorations.inputDecorationWithHint(
        hintText: "write_here",
        filledColor: R.appColors.fillColor,
        borderRadius: 10,
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(detailFN);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: AppValidator.validateEmpty,
    );
  }

  Widget problemWidget({required SupportModel model}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              model.isEnable = !model.isEnable;
              setState(() {});
            },
            child: Icon(
              model.isEnable ? Icons.check_box : Icons.check_box_outline_blank,
              color:
                  model.isEnable
                      ? R.appColors.secondaryColor
                      : R.appColors.subTitleGrey,
            ),
          ),
          w2,
          Text(model.label, style: R.textStyles.poppins(fontSize: 14.px)),
        ],
      ),
    );
  }
}
