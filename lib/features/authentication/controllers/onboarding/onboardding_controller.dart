import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/login/login_screen.dart';
import 'package:get/get.dart';

class OnboarddingController extends GetxController {
  //static OnboardingController get instance => Get.find();
  //→ Creates a global shortcut to retrieve the controller from anywhere in your app.
  //Get.find() → Retrieves an instance of a controller already stored in memory with Get.put().
  //e.g.. => OnboardingController.instance.nextPage();
  static OnboarddingController get instance => Get.find();
  //variables
  final pageController = PageController();
  RxInt currentIndex = 0.obs;
  void updatePageIndicator(index) {
    currentIndex.value = index;
  }

  //jump to specific dot selected page
  void dotNavigationClick(index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  //update current index and jump to the next page
  void nextPage() {
    if (currentIndex.value == 2) {
      Get.offAll(() => LoginScreen());
      return;
    }
    currentIndex.value++;
    pageController.jumpToPage(currentIndex.value);
  }

  //update current index and jump to the last page
  void skipPage() {
    currentIndex.value = 2;
    pageController.jumpToPage(currentIndex.value);
  }
}
