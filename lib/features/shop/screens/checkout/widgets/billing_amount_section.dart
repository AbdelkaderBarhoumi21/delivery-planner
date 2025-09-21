import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppBillingAmountSection extends StatelessWidget {
  const AppBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Subtotal",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            Text("\$343", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        //shopping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Shopping fee",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            Text("\$35", style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        //Tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Tax fee",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            Text("\$3", style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems),
        //Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Order Total",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            Text("\$8856.0", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
