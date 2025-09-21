import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/controllers/onboarding/onboardding_controller.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/device_helpers.dart';
import 'package:get/get.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboarddingController.instance;
    return Obx(
      () => controller.currentIndex.value == 2
          ? SizedBox()
          : Positioned(
              top: AppDeviceHelpers.getAppBarHeight(),
              right: 0,
              child: TextButton(
                onPressed: controller.skipPage,
                child: Text(
                  "Skip",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.apply(color: AppColors.primary),
                ),
              ),
            ),
    );
  }
}
