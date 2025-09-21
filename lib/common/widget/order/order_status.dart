import 'package:flutter_ecommerce_app_v2/common/widget/order/order_title_verify_icon.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/enums.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/rounded_image.dart';
import 'package:iconsax/iconsax.dart';

class AppCardOrderStatus extends StatelessWidget {
  const AppCardOrderStatus({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.imageUrl,
    required this.orderStatus,
    required this.orderStatusNumber,
    this.iconData = Iconsax.verify,
  });
  final bool showBorder;
  final VoidCallback? onTap;
  final String orderStatus;
  final String orderStatusNumber;
  final String imageUrl;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppRoundedContainer(
        height: AppSizes.brandCardHeight,
        width: 120,
        showBorder: showBorder,
        padding: const EdgeInsets.all(AppSizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //Brand Image
            Flexible(
              child: AppRoundedImage(
                imageUrl: imageUrl,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Brand Name verify icon
                  AppOrderTitleVerifyIcon(
                    title: orderStatus,
                    brandTextSizes: TextSizes.large,
                    iconData: iconData,
                  ),
                  //Text product number
                  Text(
                    '$orderStatusNumber products',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
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
