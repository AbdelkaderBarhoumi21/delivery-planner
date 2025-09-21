import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/rounded_image.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/brand_title_verify_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_title_text.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class AppCartItem extends StatelessWidget {
  const AppCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        //product image
        AppRoundedImage(
          imageUrl: AppImages.productImage40,
          height: 60.0,
          width: 60.0,
          padding: EdgeInsets.all(AppSizes.sm),
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.light,
        ),
        SizedBox(width: AppSizes.spaceBtwItems),
        //brand name variation
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //brand
              AppBrandTitleVerifyIcon(title: 'iPhone'),
              //ttile
              AppProductTitleText(title: 'iPhone 11 64 GB W', maxLines: 1),
              //Variation or attributes
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Color ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: 'Green ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'Storage ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: '512 GB ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
