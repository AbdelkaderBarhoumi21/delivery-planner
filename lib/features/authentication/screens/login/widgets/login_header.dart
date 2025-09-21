import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';

class AppLoginHeader extends StatelessWidget {
  const AppLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        //subtitle
        SizedBox(height: AppSizes.sm),
        Text(
          AppTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
