// lib/features/shop/screens/order/widgets/order_history_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/history_assign_model.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

// ViewModel exposé par OrderHistoryController
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_history_controller.dart';

class AppOrderHistoryCard extends StatelessWidget {
  const AppOrderHistoryCard({
    super.key,
    required this.items,
    required this.onTap,
    this.shrinkWrap = false,
    this.nonScrollable = false,
  });

  final List<HistoryItemVM> items;
  final void Function(String orderId) onTap;
  final bool shrinkWrap;
  final bool nonScrollable;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final fmt = DateFormat('dd MMM yyyy');

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: shrinkWrap,
      physics: nonScrollable
          ? const NeverScrollableScrollPhysics()
          : const ClampingScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        final vm = items[index];

        final Color statusColor = switch (vm.status.toLowerCase()) {
          'pending' => AppColors.primary,
          'in-transit' => Colors.orange,
          'completed' => Colors.green,
          'cancelled' => Colors.red,
          _ => AppColors.primary,
        };

        final String statusLabel = switch (vm.status.toLowerCase()) {
          'pending' => 'Pending Order',
          'in-transit' => 'In-Transit Order',
          'completed' => 'Completed Order',
          'cancelled' => 'Cancelled Order',
          _ => '${vm.status} Order',
        };

        return AppRoundedContainer(
          showBorder: true,
          backgroundColor: dark ? AppColors.dark : AppColors.light,
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---- Ligne 1: Status + Order Id | Shipping Date ----
              Row(
                children: [
                  // Statut + ID
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
                                statusLabel,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                vm.id, // Order Id
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Date d’expédition
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
                                fmt.format(vm.shippingDate),
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

              // ---- Ligne 2: Customer + flèche ----
              Row(
                children: [
                  const Icon(Iconsax.user),
                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Customer Info'),
                        Text(
                          vm.customerName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),

                  // Flèche
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () =>
                            onTap(vm.id), // ← renvoie l’orderId au parent
                        child: const Icon(Iconsax.arrow_right_34),
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
