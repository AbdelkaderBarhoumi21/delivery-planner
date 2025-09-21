import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/circular_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/orderdetails_controller.dart';
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
    final c = OrdersdetailsController.instance;

    return AppRoundedContainer(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      padding: const EdgeInsets.all(AppSizes.md),
      child: Row(
        children: [
          AppCircularContainer(
            height: 56, width: 56,
            backgroundColor: dark ? AppColors.dark : AppColors.light,
            padding: const EdgeInsets.all(AppSizes.sm),
            child: Image.asset(AppImages.profileLogo, fit: BoxFit.cover),
          ),
          const SizedBox(width: AppSizes.spaceBtwItems),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.customerName, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSizes.spaceBtwItems / 4),
              Text(
                // pas d'adresse dans le JSON, on affiche les coords lisibles
                '${c.customerLatLng.latitude.toStringAsFixed(4)}, '
                '${c.customerLatLng.longitude.toStringAsFixed(4)}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Iconsax.call5, color: AppColors.primary),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Icon(Iconsax.message_21, color: AppColors.primary.withOpacity(0.6)),
            ],
          ),
        ],
      ),
    );
  }
}
