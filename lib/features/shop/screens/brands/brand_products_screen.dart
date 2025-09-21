import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/brand/brand_card.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/all_products/all_products_screen.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/sortable_products.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/brands/all_brand_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text("bata", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //brand
              AppBrandCard(),
              SizedBox(height: AppSizes.spaceBtwSections),
              //brand products
              AppSortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
