import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/cart/cart_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppCartCounterIcon extends StatelessWidget {
  const AppCartCounterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        //bag icon | cart icon
        IconButton(
          onPressed: () => Get.to(() => CartScreen()),
          icon: const Icon(Iconsax.shopping_bag, size: 32),
          color: dark ? AppColors.white : AppColors.white,
        ),
        //counter text
        Positioned(
          right: 6.0,

          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: dark ? AppColors.dark : AppColors.light,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  //apply factor to the font sizee eg 16 × 0.8
                  fontSizeFactor: 0.8,
                  color: dark ? AppColors.light : AppColors.dark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
