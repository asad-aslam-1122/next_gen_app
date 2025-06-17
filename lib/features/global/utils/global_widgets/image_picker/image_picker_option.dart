import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/heights_widths.dart';
import '../../../resources/resources.dart';
import '../safe_area_widget.dart';
import 'image_picker_services.dart';

class ImagePickerOption extends StatefulWidget {
  final ValueChanged<File?>? uploadImage;
  final bool? isOptionEnable;
  const ImagePickerOption({
    this.uploadImage,
    super.key,
    this.isOptionEnable = false,
  });

  @override
  ImagePickerOptionState createState() => ImagePickerOptionState();
}

class ImagePickerOptionState extends State<ImagePickerOption> {
  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      backgroundColor: R.appColors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: Get.width,
          padding: EdgeInsets.fromLTRB(7.w, 4.h, 7.w, 1.5.h),
          decoration: BoxDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      ImagePickerServices.getProfileImage(
                        isSizeOptional: widget.isOptionEnable,
                        isCamera: true,
                        context: context,
                      ).then((value) async {
                        if (ImagePickerServices.profileImage != null) {
                          bool check = await ImagePickerServices.checkFileSize(
                            ImagePickerServices.profileImage!.path,
                          );
                          if (check) {
                            widget.uploadImage!(
                              ImagePickerServices.profileImage,
                            );
                            ImagePickerServices.profileImage = null;
                          }
                        }
                      });

                      Navigator.pop(context);
                    },
                    child: Container(
                      color: R.appColors.transparent,
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: R.appColors.secondaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(R.appImages.camera, scale: 4),
                          ),
                          h1,
                          Text(
                            "camera".L(),
                            style: R.textStyles.poppins().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.px,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  w10,
                  GestureDetector(
                    onTap: () {
                      ImagePickerServices.getProfileImage(
                        isSizeOptional: widget.isOptionEnable,
                        isCamera: false,
                        context: context,
                      ).then((value) async {
                        if (ImagePickerServices.profileImage != null) {
                          bool check = await ImagePickerServices.checkFileSize(
                            ImagePickerServices.profileImage!.path,
                          );

                          if (check) {
                            widget.uploadImage!(
                              ImagePickerServices.profileImage,
                            );
                            ImagePickerServices.profileImage = null;
                          }
                        }
                      });

                      Navigator.pop(context);
                    },
                    child: Container(
                      color: R.appColors.transparent,
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: R.appColors.secondaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(R.appImages.gallery, scale: 4),
                          ),
                          h1,
                          Text(
                            "gallery".L(),
                            style: R.textStyles.poppins().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.px,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
