import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/device_helpers.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.onTap,
  });
  final String title, subTitle, image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //Image
              Image.asset(
                image,
                height: AppDeviceHelpers.getScreenHeight(context) * 0.4,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),

              //title
              Text(
                textAlign: TextAlign.center,
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),

              //subtitle
              Text(
                textAlign: TextAlign.center,
                subTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              //continiue button
              SizedBox(height: AppSizes.spaceBtwSections),
              AppElevatedButton(
                onPressed: onTap,
                child: Text(AppTexts.Continue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
