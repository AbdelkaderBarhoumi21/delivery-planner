import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class AppBillingPayementSection extends StatelessWidget {
  const AppBillingPayementSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Paymenet method text
        AppSectionHeading(
          title: 'Payement Method',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          children: [
            //payment logo
            AppRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? AppColors.light : AppColors.white,
              padding: EdgeInsets.all(AppSizes.sm),
              child: Image(
                image: AssetImage(AppImages.googlePay),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems / 2),
            //payement name
            Text('Google Pay', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}
