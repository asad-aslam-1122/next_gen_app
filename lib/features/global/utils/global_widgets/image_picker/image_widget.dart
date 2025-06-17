import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../resources/resources.dart';
import 'image_picker_option.dart';

class ImageWidget extends StatefulWidget {
  final String? url;
  final bool? isFile;
  final File? pickedFile;
  final ValueChanged<File?>? uploadImage;
  final double height;
  final double width;
  final double borderRadius;
  final bool isAddIcon;
  final bool isCircle;
  final bool isShowBorder;
  final Color? backgroundColor;
  final Color? grey;
  final Color? cameraColor;
  final bool? isEnable;
  final bool? showStar;
  final double? starSize;
  final String? emptyIcon;
  final bool? imageBorder;
  const ImageWidget({
    super.key,
    this.url,
    this.isFile,
    this.cameraColor,
    this.pickedFile,
    this.uploadImage,
    this.backgroundColor,
    this.showStar,
    this.starSize,
    this.grey,
    this.borderRadius = 10,
    this.isCircle = true,
    this.isAddIcon = true,
    this.isEnable = true,
    this.isShowBorder = true,
    required this.height,
    required this.width,
    this.emptyIcon, this.imageBorder,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? pickedFile;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pickedFile = widget.pickedFile;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant ImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pickedFile = widget.pickedFile;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFile == true
        ? GestureDetector(
          onTap:
              widget.isEnable == false
                  ? null
                  : () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Get.bottomSheet(
                      ImagePickerOption(
                        uploadImage: (value) {
                          if (value != null) {
                            pickedFile = value;
                            widget.uploadImage!(pickedFile!);
                            setState(() {});
                          }
                        },
                        isOptionEnable: false,
                      ),
                      isScrollControlled: true,
                    );
                  },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:widget.isShowBorder==false?null: Border.all(
                    color: widget.grey ?? R.appColors.grey,
                    width: 3,
                  ),
                ),
                child:
                    pickedFile != null
                        ? Container(
                          height: widget.height,
                          width: widget.width,
                          decoration: BoxDecoration(
                            color: R.appColors.white,
                            image: DecorationImage(
                              image: FileImage(pickedFile!),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child:
                              widget.isAddIcon == true
                                  ? Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: -8,
                                        child: IconButton(
                                          visualDensity: VisualDensity.compact,
                                          padding: EdgeInsets.all(4),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            Get.bottomSheet(
                                              ImagePickerOption(
                                                uploadImage: (value) {
                                                  if (value != null) {
                                                    pickedFile = value;
                                                    widget.uploadImage!(
                                                      pickedFile!,
                                                    );
                                                    setState(() {});
                                                  }
                                                },
                                                isOptionEnable: false,
                                              ),
                                              isScrollControlled: true,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 18,
                                            color:
                                                widget.cameraColor ??
                                                R.appColors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  : null,
                        )
                        : Container(
                          height: widget.height,
                          width: widget.width,
                          decoration: BoxDecoration(
                            color: widget.backgroundColor ?? R.appColors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(5),
                          child:
                              widget.isAddIcon == true
                                  ? Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          R.appImages.user,
                                        ),
                                        scale: 4,
                                        // fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: -8,
                                          child: IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            padding: EdgeInsets.all(4),
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              Get.bottomSheet(
                                                ImagePickerOption(
                                                  uploadImage: (value) {
                                                    if (value != null) {
                                                      pickedFile = value;
                                                      widget.uploadImage!(
                                                        pickedFile!,
                                                      );
                                                      setState(() {});
                                                    }
                                                  },
                                                  isOptionEnable: false,
                                                ),
                                                isScrollControlled: true,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.camera_alt,
                                              size: 18,
                                              color:
                                                  widget.cameraColor ??
                                                  R.appColors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : Image.asset(
                                    widget.emptyIcon ?? R.appImages.user,
                                    scale: 4,
                                  ),
                        ),
              ),


            ],
          ),
        )
        : GestureDetector(
      onTap:
      widget.isEnable == false
          ? null
          : () {
        FocusManager.instance.primaryFocus?.unfocus();
        Get.bottomSheet(
          ImagePickerOption(
            uploadImage: (value) {
              if (value != null) {
                pickedFile = value;
                widget.uploadImage!(pickedFile!);
                setState(() {});
              }
            },
            isOptionEnable: false,
          ),
          isScrollControlled: true,
        );
      },
      child: CachedNetworkImage(
        imageUrl: widget.url ?? "",
        imageBuilder:
            (context, imageProvider) => Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: widget.height,
              width: widget.width,
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? R.appColors.white,
                border: widget.isShowBorder ?? false ? Border.all(color: R.appColors.blueColor) : null,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                shape:
                widget.isCircle
                    ? BoxShape.circle
                    : BoxShape.rectangle,

              ),
              child:
              widget.isAddIcon == true
                  ? Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: -8,
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.all(4),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Get.bottomSheet(
                          ImagePickerOption(
                            uploadImage: (value) {
                              if (value != null) {
                                pickedFile = value;
                                widget.uploadImage!(
                                  pickedFile!,
                                );
                                setState(() {});
                              }
                            },
                            isOptionEnable: false,
                          ),
                          isScrollControlled: true,
                        );
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color:
                        widget.cameraColor ??
                            R.appColors.grey,
                      ),
                    ),
                  ),
                ],
              )
                  : null,
            ),

          ],
        ),
        placeholder:
            (context, url) => Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? R.appColors.white,
                shape:
                widget.isCircle
                    ? BoxShape.circle
                    : BoxShape.rectangle,

              ),
              child: SpinKitPulse(color: R.appColors.primaryColor),
            ),

          ],
        ),
        errorWidget:
            (context, url, error) => Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color:
                widget.backgroundColor,
                shape:
                widget.isCircle
                    ? BoxShape.circle
                    : BoxShape.rectangle,

              ),
              child: Image.asset(R.appImages.user, height: widget.height,
                width: widget.width,),
            ),

          ],
        ),
      ),
    );
  }
}
