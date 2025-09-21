import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/cart/cart_counter_icon.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
class AppHomeAppBar extends StatelessWidget {
  const AppHomeAppBar({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return UAppBar(
      //title - subtitle
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title 
          Text(
            AppTexts.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: AppColors.grey),
          ),
          //subtitle
          Text(
            AppTexts.homeAppbarSubTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: AppColors.white),
          ),
        ],
      ),
      actions: [AppCartCounterIcon()],
    );
  }
}
