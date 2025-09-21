import 'package:flutter_ecommerce_app_v2/utils/constants/enums.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/rounded_image.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/brand_title_verify_icon.dart';

class AppBrandCard extends StatelessWidget {
  const AppBrandCard({super.key, this.showBorder = true,this.onTap});
  final bool showBorder;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: AppRoundedContainer(
        height: AppSizes.brandCardHeight,
        // width: AppSizes.brandCardWidth,
        showBorder: showBorder,
        padding: const EdgeInsets.all(AppSizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //Brand Image
            Flexible(
              child: AppRoundedImage(
                imageUrl: AppImages.bataLogo,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Brand Name verify icon
                  AppBrandTitleVerifyIcon(
                    title: 'Bata',
                    brandTextSizes: TextSizes.large,
                  ),
                  //Text product number
                  Text(
                    '172 products',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
