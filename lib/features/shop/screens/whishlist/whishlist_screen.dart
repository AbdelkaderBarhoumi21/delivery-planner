import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/layouts/grid_layout.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/products/products_card/product_vertical_card.dart';
import 'package:flutter_ecommerce_app_v2/navigation_menu.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class WhishlistScreen extends StatelessWidget {
  const WhishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text(
          'Whishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          AppCircularIcon(
            backgroundColor: Colors.transparent,
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: AppGridLayout(
            itemCount: 10,
            itemBuilder: (context, index) {
              return AppProductCardVertical();
            },
          ),
        ),
      ),
    );
  }
}
