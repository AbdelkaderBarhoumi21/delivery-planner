import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/cart/cart_counter_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/textfields/search_bar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/primary_header_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
class AppStorePrimaryHeader extends StatelessWidget {
  const AppStorePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Total height + 20
        SizedBox(height: AppSizes.storePrimaryHeaderHeight + 10),
        //Primary Header Container
        AppPrimaryHeaderContainer(
          height: AppSizes.storePrimaryHeaderHeight,
          child: UAppBar(
            title: Text(
              'Store',
              style: Theme.of(context).textTheme.headlineMedium!
                  .apply(color: AppColors.white),
            ),
            actions: [AppCartCounterIcon()],
          ),
        ),
        //search bar
        AppSearchBar(),
      ],
    );
  }
}
