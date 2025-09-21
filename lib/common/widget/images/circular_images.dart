import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppCircularImage extends StatelessWidget {
  const AppCircularImage({
    super.key,
    this.fit,
    required this.image,
    this.isNetworkImage = false,
    this.showBorder = false,
    this.overlayColor,
    this.backgroundColor,
    this.borderColor = AppColors.primary,
    this.width = 56,
    this.height = 56,
    this.borderWidth = 1.0,
    this.padding = AppSizes.sm,
  });

  final BoxFit? fit;
  final double borderWidth;
  final String image;
  final bool isNetworkImage, showBorder;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Color borderColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (dark ? AppColors.dark : AppColors.light),
        borderRadius: BorderRadius.circular(100),
        border: showBorder
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  color: overlayColor,
                )
              : Image(fit: fit, color: overlayColor, image: AssetImage(image)),
        ),
      ),
    );
  }
}
