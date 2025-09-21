import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/controllers/onboarding/onboardding_controller.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboarddingController.instance;
    return Positioned(
      left: 0,
      right: 0,
      bottom: AppSizes.spaceBtwItems,
      child: AppElevatedButton(
        onPressed: controller.nextPage,
        child: Obx(
          () =>
              Text(controller.currentIndex.value == 2 ? "Get Started" : "Next"),
        ),
      ),
    );
  }
}
