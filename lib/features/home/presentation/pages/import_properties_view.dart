import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/resources/bot_toast/zbot_toast.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/global_app_bar.dart';
import '../../../global/utils/global_widgets/safe_area_widget.dart';

class ImportPropertiesView extends StatefulWidget {
  static String route = "/ImportPropertiesView";
  const ImportPropertiesView({super.key});

  @override
  State<ImportPropertiesView> createState() => _ImportPropertiesViewState();
}

class _ImportPropertiesViewState extends State<ImportPropertiesView> {
  int selectedDeviceIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
        backgroundColor: R.appColors.transparent,
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
            child: CustomButton(onPressed: (){
              Get.back();
              ZBotToast.showToastSuccess(message: "properties_has_been_imported_successfully".L(),title: "properties_imported".L());
            }, title: "import"),
          ),
          backgroundColor: R.appColors.backgroundColor,
          appBar: GlobalAppBar.customAppBar2(title: "import_properties",
              backGroundColor: R.appColors.backgroundColor,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                  decoration: BoxDecoration(
                    color: R.appColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: R.appColors.shadowColor.withOpacity(0.1),blurRadius: 20),
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("connected_devices".L(),style: R.textStyles.poppins(fontWeight: FontWeight.w600),),
                      h2,
                      ...List.generate(5, (index){
                        return GestureDetector(
                          onTap: (){
                            selectedDeviceIndex = index;
                            setState(() {

                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 1.h),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: R.appColors.secondaryColor,
                                    shape: BoxShape.circle
                                ),
                                child: Image.asset(R.appImages.device,height: 24,width: 24,),
                              ),
                              w2,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("NextGen_Atoms_48",style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.primaryColor),),
                                  Text("Connected",style: R.textStyles.poppins(fontWeight: FontWeight.w500,color: R.appColors.greyLight,fontSize: 12.px),),
                                ],
                              ),
                              Spacer(),
                              Radio<int>(value: index, groupValue: selectedDeviceIndex, onChanged: (v){
                                selectedDeviceIndex = index;
                                setState(() {

                                });
                              },activeColor: R.appColors.secondaryColor,)
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
