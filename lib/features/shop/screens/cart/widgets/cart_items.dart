import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/cart/cart_item.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/cart/product_quantity_add_remove.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_price.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppCartItems extends StatelessWidget {
  const AppCartItems({super.key, required this.showAddRemoveButtons});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSizes.spaceBtwSections),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          children: [
            //cart item
            AppCartItem(),
            if (showAddRemoveButtons) SizedBox(height: AppSizes.spaceBtwItems),
            //price counter button
            if (showAddRemoveButtons)
              Row(
                children: [
                  //extra space at left
                  SizedBox(width: 70.0),
                  //App Product Quantity With Add Remove
                  AppProductQuantityWithAddRemove(),
                  //App product price text
                  Spacer(),
                  AppProductPriceText(price: "323"),
                ],
              ),
          ],
        );
      },
    );
  }
}
