import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/cart/cart_item.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/cart/product_quantity_add_remove.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_price.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/checkout/checkout_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      //appbar
      appBar: UAppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      //body
      body: Padding(
        padding: AppPadding.screenPadding,
        child: AppCartItems(showAddRemoveButtons: true),
      ),
      //bottom navigation checkout button
      bottomNavigationBar: Padding(
        padding: AppPadding.screenPadding,
        child: AppElevatedButton(
          onPressed: () => Get.to(() => CheckoutScreen()),
          child: Text('Checkout \$2500'),
        ),
      ),
    );
  }
}
