import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/controllers/auth/authentication_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/login/login_screen.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  final AuthController authController = Get.find<AuthController>();

  final RxInt currentIndex = 0.obs;

  void updatePageIndicator(int index) {
    currentIndex.value = index;
  }

  void dotNavigationClick(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  Future<void> nextPage() async {
    if (currentIndex.value == 2) {
      await authController.setFirstTimeDone();  // sauver
      Get.offAll(() => const LoginScreen());    // aller au login
      return;
    }
    currentIndex.value++;
    pageController.jumpToPage(currentIndex.value);
  }

  void skipPage() {
    currentIndex.value = 2;
    pageController.jumpToPage(currentIndex.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
