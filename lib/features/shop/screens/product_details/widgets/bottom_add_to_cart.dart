import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppBottomAddToCart extends StatelessWidget {
  const AppBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace,
        vertical: AppSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.cardRadiusLg),
          topRight: Radius.circular(AppSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        children: [
          //decrement button
          AppCircularIcon(
            icon: Iconsax.minus,
            backgroundColor: AppColors.darkGrey,
            width: 40,
            height: 40,
            color: AppColors.white,
          ),
          SizedBox(width: AppSizes.spaceBtwItems),
          //text counter
          Text('2', style: Theme.of(context).textTheme.titleSmall),
          SizedBox(width: AppSizes.spaceBtwItems),
          //increment button
          AppCircularIcon(
            icon: Iconsax.add,
            backgroundColor: AppColors.black,
            width: 40,
            height: 40,
            color: AppColors.white,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Iconsax.shopping_bag),
                SizedBox(width: AppSizes.spaceBtwItems / 2),
                Text('Add To Cart'),
              ],
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(AppSizes.md),
              backgroundColor: AppColors.black,
              side: BorderSide(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
