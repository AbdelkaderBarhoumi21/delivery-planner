import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/circular_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppProfileInfo extends StatelessWidget {
  const AppProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return AppRoundedContainer(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      padding: const EdgeInsets.all(AppSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //profile picture
          AppCircularContainer(
            height: 56,
            width: 56,
            backgroundColor: dark ? AppColors.dark : AppColors.light,
            padding: EdgeInsets.all(AppSizes.sm),
            child: Image.asset(AppImages.profileLogo, fit: BoxFit.cover),
          ),
          const SizedBox(width: AppSizes.spaceBtwItems),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Abdelkader Brh",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 4),
              Text(
                '76B Tunis Olympic City',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          Spacer(),

          Row(
            children: [
              //call
              Icon(Iconsax.call5, color: AppColors.primary),
              const SizedBox(width: AppSizes.spaceBtwItems),
              //message
              Icon(
                Iconsax.message_21,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
