import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/circular_images.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/brand_title_verify_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_price.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_title_text.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppProductMetaData extends StatelessWidget {
  const AppProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //price title stock and brand
        //sale tag price old and new price share butto
        Row(
          children: [
            AppRoundedContainer(
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
            SizedBox(width: AppSizes.spaceBtwItems),

            //sale price
            Text(
              "\$250",
              style: Theme.of(context).textTheme.titleSmall!.apply(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems),
            //actual price
            AppProductPriceText(price: '150', isLarge: true),
            Spacer(),
            //share button
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        //product title
        AppProductTitleText(title: "Apple iPhone 11"),
        SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        //product status
        Row(
          children: [
            AppProductTitleText(title: "Status"),
            SizedBox(width: AppSizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        //product brand image with title
        Row(
          children: [
            //brand image
            AppCircularImage(
              padding: 0,
              image: AppImages.bataLogo,
              width: 32.0,
              height: 32.0,
            ),
            SizedBox(width: AppSizes.spaceBtwItems),
            //brand card
            AppBrandTitleVerifyIcon(title: 'Apple'),
          ],
        ),
      ],
    );
  }
}
