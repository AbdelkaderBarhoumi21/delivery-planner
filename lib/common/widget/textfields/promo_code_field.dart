import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class AppPromoCodeField extends StatelessWidget {
  const AppPromoCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return AppRoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.only(
        left: AppSizes.md,
        right: AppSizes.sm,
        top: AppSizes.sm,
        bottom: AppSizes.sm,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 80.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                //foregroundColor contenu du button
                foregroundColor: dark
                    ? AppColors.white.withValues(alpha: 0.5)
                    : AppColors.dark.withValues(alpha: 0.5),

                side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              onPressed: () {},
              child: Text("Apply"),
            ),
          ),
        ],
      ),
    );
  }
}
