import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dotted_line/dotted_line.dart';

class AppOrderInfo extends StatelessWidget {
  const AppOrderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return AppRoundedContainer(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.car),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "On the way",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems / 4),
                  Text(
                    "8405 Tunis Street Liberty",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "6m 39s",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.apply(color: AppColors.primary),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  Text(
                    "1.9 KM",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          DottedLine(
            dashLength: 4,
            dashGapLength: 4,
            dashColor: AppColors.grey,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSizes.spaceBtwItems / 4),
              Row(
                children: [
                  Text(
                    "65-inch 4K TV",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Spacer(),
                  Text(
                    "\$1200.00",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 4),
              Row(
                children: [
                  Text(
                    "Redmi 14 pro",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Spacer(),
                  Text(
                    "\$350.00",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              DottedLine(
                dashLength: 4,
                dashGapLength: 4,
                dashColor: AppColors.grey,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: AppSizes.spaceBtwItems / 4),
                  Text(
                    "\$350.00",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
