import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/orderdetails_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/order_trip_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_info.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_profile_info.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_user_map.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    Get.put(OrdersdetailsController());

    return Scaffold(
      appBar: UAppBar(
        title: Text(
          'Orders Details',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: GetBuilder<OrdersdetailsController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: AppPadding.screenPadding,
            child: Column(
              children: [
                //Map
                AppOrderuserMap(),
                const SizedBox(height: AppSizes.spaceBtwSections),
                //profile info
                AppProfileInfo(),
                const SizedBox(height: AppSizes.spaceBtwItems),
                //order info
                AppOrderInfo(),
                const SizedBox(height: AppSizes.spaceBtwSections),
                //approve button
                AppElevatedButton(
                  onPressed: () => Get.to(() => OrderTripScreen()),
                  child: Text("Approve"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
