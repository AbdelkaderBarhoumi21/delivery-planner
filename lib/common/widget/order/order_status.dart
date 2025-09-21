import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:iconsax/iconsax.dart';

class AppCardOrderStatus extends StatelessWidget {
  const AppCardOrderStatus({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.orderStatus,
    required this.orderStatusNumber,
    this.iconData = Iconsax.verify,
  });
  final bool showBorder;
  final VoidCallback? onTap;
  final String orderStatus;
  final String orderStatusNumber;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppRoundedContainer(
        height: 100,
        width: 120,
        showBorder: showBorder,
        padding: const EdgeInsets.all(AppSizes.sm),
        backgroundColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "27",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(Icons.done),
                  Text(
                    "Pending",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
