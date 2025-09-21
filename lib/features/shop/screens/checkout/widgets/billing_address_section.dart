import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppBillingAddressSection extends StatelessWidget {
  const AppBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //billing address heading
        AppSectionHeading(
          title: 'Billing Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),

        Text(
          "Abdelkader Barhoumi",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),

        Row(
          children: [
            Icon(Icons.phone, size: AppSizes.iconSm, color: AppColors.darkGrey),
            SizedBox(width: AppSizes.spaceBtwItems),
            Text("+216 204488963"),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          children: [
            Icon(
              Icons.location_history,
              size: AppSizes.iconSm,
              color: AppColors.darkGrey,
            ),
            SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(
              child: Text("Cite El Khadra, Rue 8504, Tunis", softWrap: true),
            ),
          ],
        ),
      ],
    );
  }
}
