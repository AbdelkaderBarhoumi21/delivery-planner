import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/brand_title_text.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/enums.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class AppBrandTitleVerifyIcon extends StatelessWidget {
  const AppBrandTitleVerifyIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = AppColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: AppBrandTitleText(
            title: title,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSizes: brandTextSizes,
            color: textColor,
          ),
        ),
        SizedBox(width: AppSizes.xs),
        Icon(Iconsax.verify5, color: iconColor, size: AppSizes.iconXs),
      ],
    );
  }
}
