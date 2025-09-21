import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/layouts/grid_layout.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/products_card/product_vertical_card.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class AppSortableProducts extends StatelessWidget {
  const AppSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //filter field
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ['Name', 'Lower Price', 'Higher price', 'Sale', 'Newest']
              .map((filter) {
                return DropdownMenuItem(
                  value: filter,
                  child: Text(filter),
                );
              })
              .toList(),
          onChanged: (value) {},
        ),
        SizedBox(height: AppSizes.spaceBtwSections),
        //products 
        AppGridLayout(
          itemCount: 10,
          itemBuilder: (context, index) => AppProductCardVertical(),
        ),
      ],
    );
  }
}