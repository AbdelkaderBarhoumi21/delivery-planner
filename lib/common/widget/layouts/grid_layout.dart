import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppGridLayout extends StatelessWidget {
  const AppGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent =268.8,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSizes.gridViewSpacing,
        crossAxisSpacing: AppSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
