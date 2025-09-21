import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/circular_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/clipper/rounded_edge_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppPrimaryHeaderContainer extends StatelessWidget {
  const AppPrimaryHeaderContainer({
    super.key,
    required this.child,
    required this.height,
  });
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return AppRoundedEgdesContainer(
      child: Container(
        // height: AppSizes.homePrimaryHeaderHeight,
        height: height,
        color: AppColors.primary,
        child: Stack(
          children: [
            //circular container
            Positioned(
              top: -150,
              right: -160,
              child: AppCircularContainer(
                height: AppSizes.homePrimaryHeaderHeight,
                width: AppSizes.homePrimaryHeaderHeight,
                backgroundColor: AppColors.white.withValues(alpha: 0.1),
              ),
            ),
            //circular container
            Positioned(
              top: 50,
              right: -250,
              child: AppCircularContainer(
                height: AppSizes.homePrimaryHeaderHeight,
                width: AppSizes.homePrimaryHeaderHeight,
                backgroundColor: AppColors.white.withValues(alpha: 0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
