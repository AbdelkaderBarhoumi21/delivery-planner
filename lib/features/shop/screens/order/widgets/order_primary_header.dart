import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/primary_header_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class AppOrderPrimaryHeader extends StatelessWidget {
  const AppOrderPrimaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Total height + 20

        //Primary Header Container
        AppPrimaryHeaderContainer(
          height: AppSizes.storePrimaryHeaderHeight,
          child: UAppBar(
            title: Text(
              'Order History',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.apply(color: AppColors.white),
            ),
            actions: [Icon(Iconsax.notification)],
          ),
        ),
      ],
    );
  }
}
