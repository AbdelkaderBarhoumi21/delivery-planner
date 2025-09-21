import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/controllers/onboarding/onboardding_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/onboarding/widgets/onboarding_skip_button.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboarddingController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnBoardingPage(
                  animation: AppImages.onBoardingAnimation1,
                  title: AppTexts.onBoardingTitle1,
                  subTitle: AppTexts.onBoardingSubTitle1,
                ),
                OnBoardingPage(
                  animation: AppImages.onBoardingAnimation2,
                  title: AppTexts.onBoardingTitle2,
                  subTitle: AppTexts.onBoardingSubTitle2,
                ),
                OnBoardingPage(
                  animation: AppImages.onBoardingAnimation3,
                  title: AppTexts.onBoardingTitle3,
                  subTitle: AppTexts.onBoardingSubTitle3,
                ),
              ],
            ),

            //indicator
            const OnBoardingDotNavigation(),
            //next button
            const OnBoardingNextButton(),
            //skip button
            const OnBoardingSkipButton(),
          ],
        ),
      ),
    );
  }
}
