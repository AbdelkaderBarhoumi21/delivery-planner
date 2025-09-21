import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';

class AppShadow {
  AppShadow._();
  static List<BoxShadow> searchBarShadow = [
    BoxShadow(
      color: AppColors.black.withValues(alpha: 0.1),
      spreadRadius: 2.0,
      blurRadius: 4.0,
    ),
  ];
  static List<BoxShadow> verticalProductShadow = [
    BoxShadow(
      color: AppColors.darkGrey.withValues(alpha: 0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2),
    ),
  ];
}
