import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/rounded_image.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/brand_title_verify_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_price.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_title_text.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/product_details/product_details_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppProductCardVertical extends StatelessWidget {
  const AppProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen()),
      child: Container(
        width: 180,

        // padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          // boxShadow: AppShadow.verticalProductShadow,
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
          color: dark ? AppColors.darkerGrey : AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //thumbail favorite button and discount tag
            AppRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  //thumbail
                  Center(
                    child: AppRoundedImage(imageUrl: AppImages.productImage15),
                  ),
                  //discount tag
                  Positioned(
                    top: 12.0,
                    child: AppRoundedContainer(
                      radius: AppSizes.sm,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sm,
                        vertical: AppSizes.xs,
                      ),
                      child: Text(
                        '20%',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: AppColors.black),
                      ),
                    ),
                  ),
                  //Favorite button
                  Positioned(
                    right: 0,
                    top: 0,
                    child: AppCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwItems / 2),
            //Details
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  AppProductTitleText(
                    title: 'Blue Bata Shoes',
                    smallSize: true,
                  ),
                  SizedBox(height: AppSizes.spaceBtwItems / 2),
                  //product brand
                  AppBrandTitleVerifyIcon(title: 'Bata'),
                ],
              ),
            ),
            Spacer(),
            //product price - add button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppSizes.sm),
                  child: AppProductPriceText(price: '65'),
                ),
                //add button
                Container(
                  width: AppSizes.iconLg * 1.2,
                  height: AppSizes.iconLg * 1.2,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.cardRadiusMd),
                      bottomRight: Radius.circular(AppSizes.productImageRadius),
                    ),
                  ),
                  child: Icon(Iconsax.add, color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
