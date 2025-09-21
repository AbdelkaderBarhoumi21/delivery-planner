import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
class AppRoundedImage extends StatelessWidget {
  const AppRoundedImage({
    required this.imageUrl,
    this.borderRadius = AppSizes.md,
    this.isNetworkImage = false,
    this.applyImageRadius = true,
    this.width,
    this.height,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.onTap,
    super.key,
  });
  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl),
            fit: fit,
          ),
        ),
      ),
    );
  }
}
