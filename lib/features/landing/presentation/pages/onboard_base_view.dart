import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/resources/app_localization.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:nextgen_reeftech/features/user/presentation/pages/auth/login_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../../global/utils/global_widgets/pop_scope_widget.dart';
import '../../../global/utils/global_widgets/safe_area_widget.dart';
import '../../data/model/onboard_model.dart';
import '../../provider/onboard_vm.dart';
import '../widget/bottom_curve_clipper.dart';
import '../widget/onboard_widget.dart';

class OnboardBaseView extends StatefulWidget {
  static String route = "/OnboardBaseView";
  const OnboardBaseView({super.key});

  @override
  State<OnboardBaseView> createState() => _OnboardBaseViewState();
}

class _OnboardBaseViewState extends State<OnboardBaseView>
    with SingleTickerProviderStateMixin {
  final PageController pageController = PageController();

  AnimationController? _fadeController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeController!);
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    super.dispose();
  }

  List<OnboardModel> onboardModelList = [
    OnboardModel(
      title: "light_up_your_aquarium",
      subTitle: "control_your_aquarium_lighting_like_never_before",
      imagePath: R.appImages.onBoard1,
    ),
    OnboardModel(
      title: "sync_multiple_lights",
      subTitle:
          "Coordinate_multiple_lights_for_a_harmonious_aquarium_environment",
      imagePath: R.appImages.onBoard2,
    ),
    OnboardModel(
      title: "personalized_aquarium_lighting",
      subTitle:
          "adjust_brightness_colors_and_schedules_to_match_your_aquarium_needs",
      imagePath: R.appImages.onBoard3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScopeWidget.onPop(
      child: SafeAreaWidget(
        top:true,
        backgroundColor: R.appColors.transparent,

        child: Consumer<OnboardVm>(
          builder: (context, onBoardVm, child) {
            return Scaffold(
              backgroundColor: R.appColors.backgroundColor,
              body: Column(
                children: [
                  ClipPath(
                    clipper: BottomCurveClipper(),
                    child: Container(
                      height: 55.h,
                      width: double.infinity,
                      decoration: R.appDecorations.onboardImageDec(
                        imagePath:
                            onboardModelList[onBoardVm.currentOnBoardIndex]
                                .imagePath,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: pageController,
                            onPageChanged: (newValue) {
                              onBoardVm.currentOnBoardIndex = newValue;
                              onBoardVm.update();

                              if (newValue == 2) {
                                _fadeController?.forward();
                              } else {
                                _fadeController?.reverse();
                              }
                            },
                            itemBuilder: (context, index) {
                              OnboardModel onboardModel = onboardModelList[index];
                              return OnboardWidget(onboardModel: onboardModel);
                            },
                            itemCount: onboardModelList.length,
                          ),
                        ),
                        SmoothPageIndicator(
                          controller: pageController, // PageController
                          count: 3,
                          effect: ExpandingDotsEffect(
                            activeDotColor: R.appColors.secondaryColor,
                            dotColor: R.appColors.darkGrey,
                            dotHeight: 7,
                            dotWidth: 15,
                            spacing: 3,
                            expansionFactor: 1.1,
                          ), // your preferred effect
                        ),
                      ],
                    ),
                  ),

                  h3,

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20) +
                        EdgeInsets.only(
                          left: onBoardVm.currentOnBoardIndex != 2 ? 8 : 16,
                          right: 16,
                        ),
                    child:
                        onBoardVm.currentOnBoardIndex != 2
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(LoginView.route);
                                  },
                                  child: Text(
                                    "skip".L(),
                                    style: R.textStyles.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.px,
                                      color: R.appColors.subTileDarkGrey,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.linear,
                                    );
                                  },
                                  style: R.appDecorations.iconButtonDec(),
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: R.appColors.white,
                                  ),
                                ),
                              ],
                            )
                            : FadeTransition(
                              opacity: _fadeAnimation!,
                              child: CustomButton(
                                onPressed: () {
                                  Get.offNamed(LoginView.route);
                                },
                                title: "get_started",
                              ),
                            ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
