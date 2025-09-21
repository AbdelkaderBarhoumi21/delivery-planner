import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppSingleAddress extends StatelessWidget {
  const AppSingleAddress({super.key, required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return AppRoundedContainer(
      width: double.infinity,
      backgroundColor: isSelected
          ? AppColors.primary.withValues(alpha: 0.5)
          : Colors.transparent,
      borderColor: isSelected
          ? Colors.transparent
          : dark
          ? AppColors.darkerGrey
          : AppColors.grey,

      showBorder: true,
      padding: EdgeInsets.all(AppSizes.md),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Name user
              Text(
                'Abdelkader barhoumi',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSizes.spaceBtwItems / 2),

              //Phone number
              Text(
                '+216201447889',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSizes.spaceBtwItems / 2),
              //address
              Text(
                'Cite el khadra, Rue 8504 ,Tunis',
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          if (isSelected)
            Positioned(
              bottom: 0,
              top: 0,
              right: 6,

              child: Icon(Iconsax.tick_circle5),
            ),
        ],
      ),
    );
  }
}
