import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';

class AppCircularContainer extends StatelessWidget {
  const AppCircularContainer({
    super.key,
    this.height = 400,
    this.width = 400,
    this.radius = 400,
    this.backgroundColor = AppColors.white,
    this.padding,
    this.margin,
    this.child,
  });

  final double height, width, radius;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
