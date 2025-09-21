import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppOrderHistoryCard extends StatelessWidget {
  const AppOrderHistoryCard({
    super.key,
    this.shrinkWrap = false,
    this.nonScrollable = false,
    required this.onTap,
  });

  final bool shrinkWrap;
  final bool nonScrollable;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return ListView.separated(
      padding: EdgeInsets.zero, //delete padding arround listview
      shrinkWrap: shrinkWrap, // ✅
      physics: nonScrollable
          ? const NeverScrollableScrollPhysics() // ✅
          : const ClampingScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        return AppRoundedContainer(
          showBorder: true,
          backgroundColor: dark ? AppColors.dark : AppColors.light,
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        const Icon(Iconsax.tag),
                        const SizedBox(width: AppSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pending Order',
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .apply(
                                      color: AppColors.primary,
                                      fontWeightDelta: 1,
                                    ),
                              ),
                              Text(
                                'GYS324',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        const Icon(Iconsax.calendar),
                        const SizedBox(width: AppSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Date',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                '06 Jan 2025',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Row(
                children: [
                  const Icon(Iconsax.user),
                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer Info'),
                        Text(
                          'Abdelkader',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onTap,
                        child: Icon(Iconsax.arrow_right_34),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
