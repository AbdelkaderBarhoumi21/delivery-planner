import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppProductQuantityWithAddRemove extends StatelessWidget {
  const AppProductQuantityWithAddRemove({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        //increment button
        AppCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: AppSizes.iconSm,
          color: dark ? AppColors.white : AppColors.black,
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.light,
        ),
        SizedBox(width: AppSizes.spaceBtwItems),
        //text counter
        Text('2', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: AppSizes.spaceBtwItems),
        //Decrement button
        AppCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: AppSizes.iconSm,
          color: AppColors.white,
          backgroundColor: AppColors.primary,
        ),
      ],
    );
  }
}
