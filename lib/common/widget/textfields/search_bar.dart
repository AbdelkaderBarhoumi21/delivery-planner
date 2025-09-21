import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/shadow.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: 0,
      right: AppSizes.spaceBtwSections,
      left: AppSizes.spaceBtwSections,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
        height: AppSizes.searchBarHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          color: dark ? AppColors.dark : AppColors.light,
          boxShadow: AppShadow.searchBarShadow,
        ),
        child: Row(
          children: [
            Icon(Iconsax.search_normal, color: AppColors.darkGrey),
            SizedBox(width: AppSizes.spaceBtwItems),
            Text(
              AppTexts.searchBarTitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
