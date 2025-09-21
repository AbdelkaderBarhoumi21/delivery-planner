import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/product_details/widgets/product_thumbnail_slider.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: SingleChildScrollView(
        child: Column(
          children: [
            //product image with slider
            AppProductThumbnailAndSlider(),
            //product details
            Padding(
              padding: AppPadding.screenPadding,
              child: Column(
                children: [
                  //price title stock and brand
                  AppProductMetaData(),
                  SizedBox(height: AppSizes.spaceBtwSections),
                  //price title stock brand
                  //attributes
                  AppProductAttributes(),
                  SizedBox(height: AppSizes.spaceBtwSections),

                  //checkout button
                  AppElevatedButton(onPressed: () {}, child: Text("Checkout")),
                  SizedBox(height: AppSizes.spaceBtwSections),

                  //descroption
                  AppSectionHeading(
                    title: 'Description',
                    showActionsButtons: false,
                  ),
                  SizedBox(height: AppSizes.spaceBtwItems),
                  ReadMoreText(
                    'This a product of iphone 11 with 512 GB ,This a product of iphone 11 with 512 GB,This a product of iphone 11 with 512 GB,This a product of iphone 11 with 512 GB',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),

      //bottom navigation
      bottomNavigationBar: AppBottomAddToCart(),
    );
  }
}
