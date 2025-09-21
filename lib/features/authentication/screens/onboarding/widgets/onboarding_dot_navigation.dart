import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/controllers/onboarding/onboardding_controller.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/device_helpers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboarddingController.instance;
    return Positioned(
      bottom: AppDeviceHelpers.getBottomNavigationBarHeight() * 4,
      left: AppDeviceHelpers.getScreenWidth(context) / 3,
      right: AppDeviceHelpers.getScreenWidth(context) / 3,

      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(dotHeight: 6.0),
      ),
    );
  }
}
