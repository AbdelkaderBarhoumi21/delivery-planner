import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/home/home_controller.dart';
import 'package:get/state_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerDotNavigation extends StatelessWidget {
  const BannerDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Obx(
      () => SmoothPageIndicator(
        controller: PageController(initialPage: controller.currentIndex.value),
        count: 5,
        effect: ExpandingDotsEffect(dotHeight: 6.0),
      ),
    );
  }
}
