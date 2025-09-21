import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/profile/profile_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/home/home_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/store/store_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/whishlist/whishlist_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    bool dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          backgroundColor: dark ? AppColors.dark : AppColors.light,
          indicatorColor: dark
              ? AppColors.white.withValues(alpha: 0.1)
              : AppColors.black.withValues(alpha: 0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: ('Home')),
            NavigationDestination(icon: Icon(Iconsax.shop), label: ('Store')),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: ('Whishlist'),
            ),
            NavigationDestination(icon: Icon(Iconsax.user), label: ('Profile')),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  RxInt selectedIndex = 0.obs;
  List<Widget> screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WhishlistScreen(),
    const ProfileScreen(),
  ];
}
