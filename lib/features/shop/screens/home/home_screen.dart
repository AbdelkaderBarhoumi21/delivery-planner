import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/order/assigned_order_card.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/order/order_status.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/home/home_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/all_products/all_products_screen.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/textfields/search_bar.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/primary_header_container.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/order_details_screen.dart';

import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// ...imports...
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Upper part ─────────────────────────────────────────
            Stack(
              children: [
                AppPrimaryHeaderContainer(
                  height: AppSizes.profilePrimaryHeaderHeight,
                  child: Column(
                    children: [
                      const AppHomeAppBar(),
                      const SizedBox(height: AppSizes.spaceBtwSections),
                    ],
                  ),
                ),
                const AppSearchBar(),
              ],
            ),

            // ── Lower part ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppSectionHeading(
                    title: 'Order Status',
                    showActionsButtons: false,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  SizedBox(
                    height: AppSizes.brandCardHeight,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSizes.spaceBtwItems / 2),
                      itemBuilder: (_, i) => SizedBox(
                        width: AppSizes.brandCardWidth,
                        child: const AppCardOrderStatus(
                          orderStatus: 'Assigned',
                          orderStatusNumber: '21',
                          iconData: Iconsax.pause,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.spaceBtwSections),
                  AppSectionHeading(
                    title: 'Assigned Orders',
                    onPressed: () => Get.to(() => const AllProductsScreen()),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  AppAssignedOrderCard(
                    shrinkWrap: true,
                    nonScrollable: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
