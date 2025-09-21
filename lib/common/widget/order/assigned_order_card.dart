import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/order_details_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

// ⬇️ importe le controller
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/home/home_controller.dart';

class AppAssignedOrderCard extends StatelessWidget {
  const AppAssignedOrderCard({
    super.key,
    this.shrinkWrap = false,
    this.nonScrollable = false,
  });

  final bool shrinkWrap;
  final bool nonScrollable;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final ctrl = HomeController.instance;
    final fmt = DateFormat('dd MMM yyyy');

    return Obx(() {
      final items = ctrl.assigned;
      if (items.isEmpty) {
        return const SizedBox.shrink(); // ou un petit placeholder si tu veux
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
                                  '${vm.status} Order',
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .apply(
                                        color: AppColors.primary,
                                        fontWeightDelta: 1,
                                      ),
                                ),
                                Text(
                                  vm.id, // <-- Order ID
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                ),
                                Text(
                                  fmt.format(vm.shippingDate), // <-- date
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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

                // ---- Ligne 2: Customer ----
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
                            vm.customerName, // <-- nom client
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),

                    // Arrow
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const OrderDetailScreen(),
                              arguments: {'orderId': vm.id},
                            );
                          }, // tu peux aussi passer un onTap qui reçoit l'id
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
    });
  }
}
