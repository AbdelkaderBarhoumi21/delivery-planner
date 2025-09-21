import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_app_v2/common/widget/brand/brand_showcase.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/layouts/grid_layout.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/products_card/product_vertical_card.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';

import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppCategoryTab extends StatelessWidget {
  const AppCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace,
          ),
          child: Column(
            children: [
              //brand show case
              AppBrandShowCase(
                images: [
                  AppImages.productImage45a,
                  AppImages.productImage45b,
                  AppImages.productImage46,
                ],
              ),
              AppBrandShowCase(
                images: [
                  AppImages.productImage33a,
                  AppImages.productImage33b,
                  AppImages.productImage33c,
                ],
              ),
              AppBrandShowCase(
                images: [
                  AppImages.productImage38a,
                  AppImages.productImage38b,
                  AppImages.productImage38c,
                ],
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //you migth like section heading
              AppSectionHeading(title: "You might like", onPressed: () {}),
              //grid Layouts products
              AppGridLayout(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return AppProductCardVertical();
                },
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
