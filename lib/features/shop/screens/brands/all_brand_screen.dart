import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/brand/brand_card.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/layouts/grid_layout.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/brands/brand_products_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text("Brand", style: Theme.of(context).textTheme.headlineMedium),
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //text brands
              AppSectionHeading(title: 'Brands', showActionsButtons: false),
              SizedBox(height: AppSizes.spaceBtwItems),
              //list of brand
              AppGridLayout(
                itemCount: 10,
                itemBuilder: (context, index) => AppBrandCard(onTap: ()=>Get.to(()=>BrandProductsScreen()),),
                mainAxisExtent: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
