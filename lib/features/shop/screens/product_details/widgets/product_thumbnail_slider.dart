import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/rounded_image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppProductThumbnailAndSlider extends StatelessWidget {
  const AppProductThumbnailAndSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      color: dark ? AppColors.darkerGrey : AppColors.light,
      child: Stack(
        children: [
          //image thumnail
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.productImageRadius * 2),
              child: Center(
                child: Image(image: AssetImage(AppImages.productImage4a)),
              ),
            ),
          ),
          //image slider
          Positioned(
            left: AppSizes.defaultSpace,
            right: 0,
            bottom: 20,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: AppSizes.spaceBtwItems),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,

                itemCount: 6,
                itemBuilder: (context, index) => AppRoundedImage(
                  width: 80,
                  padding: EdgeInsets.all(AppSizes.sm),
                  border: Border.all(color: AppColors.primary),
                  backgroundColor: dark ? AppColors.dark : AppColors.light,
                  imageUrl: AppImages.productImage2,
                ),
              ),
            ),
          ),
          //App bar back arrow favorite icon
          UAppBar(
            showBackArrow: true,
            actions: [AppCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
          ),
        ],
      ),
    );
  }
}
