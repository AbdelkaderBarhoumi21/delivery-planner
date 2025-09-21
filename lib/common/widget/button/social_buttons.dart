import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppSocialButtons extends StatelessWidget {
  const AppSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(AppImages.googleIcon, () {}),
        SizedBox(width: AppSizes.spaceBtwItems),
        buildButton(AppImages.facebookIcon, () {}),
      ],
    );
  }
}

Container buildButton(String image, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.grey),
      borderRadius: BorderRadius.circular(100),
    ),
    child: IconButton(
      onPressed: onPressed,
      icon: Image.asset(image, height: AppSizes.iconMd, width: AppSizes.iconMd),
    ),
  );
}
