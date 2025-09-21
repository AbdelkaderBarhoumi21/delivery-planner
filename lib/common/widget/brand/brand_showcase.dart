import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/brand/brand_card.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class AppBrandShowCase extends StatelessWidget {
  const AppBrandShowCase({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return AppRoundedContainer(
      showBorder: true,
      borderColor: AppColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.all(AppSizes.md),
      margin: EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBrandCard(showBorder: false),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: images
                .map((image) => buildBrandImage(dark, image))
                .toList(),
          ),
        ],
      ),
    );
  }
}

Widget buildBrandImage(bool dark, String image) {
  return Expanded(
    child: AppRoundedContainer(
      height: 100,
      margin: const EdgeInsets.only(right: AppSizes.sm),
      padding: const EdgeInsets.all(AppSizes.md),
      backgroundColor: dark ? AppColors.darkGrey : AppColors.light,
      child: Image(image: AssetImage(image), fit: BoxFit.contain),
    ),
  );
}
