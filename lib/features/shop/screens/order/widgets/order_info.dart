import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/orderdetails_controller.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:intl/intl.dart';

class AppOrderInfo extends StatelessWidget {
  const AppOrderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final c = OrdersdetailsController.instance;
    final fmtMoney = NumberFormat.simpleCurrency(decimalDigits: 2);
    final fmtDate  = DateFormat('dd MMM yyyy');

    return AppRoundedContainer(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Ligne statut / ETA / distance ---
          Row(
            children: [
              const Icon(Iconsax.car),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.status == 'Delivered' ? 'Delivered' : 'On the way',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  Text('Shipping: ${fmtDate.format(c.shippingDate)}',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    c.etaText,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: AppColors.primary),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  Text('${c.distanceKm.toStringAsFixed(1)} KM',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwItems),
          DottedLine(dashLength: 2, dashGapLength: 2, dashColor: AppColors.grey),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // --- Détails commande ---
          Text("Order", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),

          _kv(context, "Weight", "${c.weightKg.toStringAsFixed(1)} kg"),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          _kv(context, "Volume", "${c.volumeM3.toStringAsFixed(2)} m³"),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          _kv(context, "Payment Method", c.paymentMethod),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          _kv(context, c.firstItemName, "x${c.firstItemQty}"),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),

          DottedLine(dashLength: 2, dashGapLength: 2, dashColor: AppColors.grey),
          const SizedBox(height: AppSizes.spaceBtwItems),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Price", style: Theme.of(context).textTheme.titleMedium),
              Text(
                c.paymentMethod == 'COD'
                    ? fmtMoney.format(c.codAmount)
                    : fmtMoney.format(0),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(BuildContext ctx, String k, String v) {
    return Row(
      children: [
        Text(k, style: Theme.of(ctx).textTheme.labelSmall),
        const Spacer(),
        Text(v, style: Theme.of(ctx).textTheme.labelMedium),
      ],
    );
  }
}
