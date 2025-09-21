import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/products_card/product_card_hroizantal.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      //appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          "Sports",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //sub category heading section
              AppSectionHeading(title: 'Sports Shoes', onPressed: () {}),
              SizedBox(height: AppSizes.spaceBtwItems / 2),
              //horizantal product card
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AppProductCardHorizantal();
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: AppSizes.spaceBtwItems / 2),
                  itemCount: 5,
                ),
              ),
              //sub category heading section
              AppSectionHeading(title: 'Track suits', onPressed: () {}),
              SizedBox(height: AppSizes.spaceBtwItems / 2),
              //horizantal product card
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AppProductCardHorizantal();
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: AppSizes.spaceBtwItems / 2),
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
