import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/rounded_image.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/brand_title_verify_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_price.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_title_text.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppProductCardHorizantal extends StatelessWidget {
  const AppProductCardHorizantal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
        color: dark ? AppColors.darkerGrey : AppColors.light,
      ),
      child: Row(
        children: [
          //left portion
          AppRoundedContainer(
            height: 120,
            padding: EdgeInsets.all(AppSizes.sm),
            backgroundColor: dark ? AppColors.dark : AppColors.white,
            child: Stack(
              children: [
                //thumbnail
                SizedBox(
                  height: 120,
                  width: 120,
                  child: AppRoundedImage(imageUrl: AppImages.productImage15),
                ),
                //favorite button
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
                    backgroundColor: Colors.transparent,
                    icon: Iconsax.heart5,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          //right portion
          SizedBox(
            width: 172.0,
            // height: 100,
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSizes.sm,
                top: AppSizes.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //product title
                      AppProductTitleText(
                        title: 'Blue bata shoes',
                        smallSize: true,
                      ),
                      SizedBox(height: AppSizes.spaceBtwItems / 2),
                      //product brand
                      AppBrandTitleVerifyIcon(title: 'Bata'),
                    ],
                  ),
                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AppProductPriceText(price: '65'),
                      ), //add button
                      Container(
                        width: AppSizes.iconLg * 1.2,
                        height: AppSizes.iconLg * 1.2,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              AppSizes.productImageRadius,
                            ),
                          ),
                        ),
                        child: Icon(Iconsax.add, color: AppColors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
