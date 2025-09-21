import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class AppCircularIcon extends StatelessWidget {
  const AppCircularIcon({
    super.key,
    required this.icon,
    this.size = AppSizes.iconMd,
    this.backgroundColor,
    this.onPressed,
    this.height,
    this.width,
    this.color,
  });

  final double? width, height, size;
  final IconData? icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: (backgroundColor != null)
            ? backgroundColor
            : dark
            ? AppColors.dark.withValues(alpha: 0.9)
            : AppColors.light.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
