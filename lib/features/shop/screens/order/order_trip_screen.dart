import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_tripplanner_map.dart';

import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_trip_screen_controller.dart';

class OrderTripScreen extends StatelessWidget {
  const OrderTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Put controller here so the screen can be Stateless
    final c = Get.put(OrderTripScreenController());

    final theme = Theme.of(context);
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: UAppBar(
        title: Text('Order Trip', style: theme.textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: Padding(
        padding: AppPadding.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map (same behavior)
            AppOrderTripMap(controller: c.mapCtrl),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // Trip cards
            Expanded(
              child: Obx(() {
                final items = c.mapCtrl.activeTrips;              // unchanged
                final selectedId = c.mapCtrl.selectedTripId.value;

                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      'No active trips. Tap "Plan a Trip" below.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSizes.spaceBtwItems),
                  itemBuilder: (_, i) {
                    final t = items[i];
                    final bool isSelected = t.id == selectedId;

                    final Color cardBg = isSelected
                        ? AppColors.primary
                        : (dark ? AppColors.dark : AppColors.light);
                    final Color headText =
                        isSelected ? Colors.white : (dark ? Colors.white : Colors.black87);
                    final Color subText =
                        isSelected ? Colors.white70 : AppColors.darkerGrey;

                    return GestureDetector(
                      onTap: () => c.selectTrip(t.id),
                      child: AppRoundedContainer(
                        showBorder: true,
                        backgroundColor: cardBg,
                        padding: const EdgeInsets.all(AppSizes.md),
                        child: DefaultTextStyle(
                          style: theme.textTheme.bodyMedium!.copyWith(color: headText),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Iconsax.truck, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('Trip ${t.id}'),
                                  const Spacer(),
                                  Text(t.vehicleName),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems / 2),

                              Row(
                                children: [
                                  Icon(Iconsax.weight, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('Weight',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: subText)),
                                  const Spacer(),
                                  Text('${t.usedWeight.toStringAsFixed(1)} kg'),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems / 2),

                              Row(
                                children: [
                                  Icon(Iconsax.box, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('Volume',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: subText)),
                                  const Spacer(),
                                  Text('${t.usedVolume.toStringAsFixed(2)} m³'),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems / 2),

                              Row(
                                children: [
                                  Icon(Iconsax.money, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('COD',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: subText)),
                                  const Spacer(),
                                  Text(c.money.format(t.totalCod)),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems / 2),

                              Row(
                                children: [
                                  Icon(Iconsax.bag, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('Orders',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: subText)),
                                  const Spacer(),
                                  Text(t.orderIds.join(', ')),
                                ],
                              ),

                              TextButton(
                                onPressed: () =>
                                    c.openTracking(t.id, t.orderIds),
                                child: Text(
                                  'Track',
                                  style: theme.textTheme.bodyMedium!.apply(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.playlist_add),
                label: const Text('Plan a Trip'),
                onPressed: () => c.planTrip(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
