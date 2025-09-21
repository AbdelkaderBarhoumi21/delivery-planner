import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/screens/success_screen.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/login/login_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/device_helpers.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //Image
              Image.asset(
                AppImages.mailSentImage,
                height: AppDeviceHelpers.getScreenHeight(context) * 0.4,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),

              //title
              Text(
                AppTexts.verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //email
              Text(
                "Abdelkader@gmail.com",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //subtitle
              Text(
                textAlign: TextAlign.center,
                AppTexts.verifyEmailSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              //continiue button
              SizedBox(height: AppSizes.spaceBtwItems),
              AppElevatedButton(
                onPressed: () => Get.to(
                  () => SuccessScreen(
                    title: AppTexts.accountCreatedTitle,
                    subTitle: AppTexts.accountCreatedSubTitle,
                    image: AppImages.accountCreatedImage,
                    onTap: () {},
                  ),
                ),
                child: Text(AppTexts.Continue),
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //resend email button
              SizedBox(
                width: AppDeviceHelpers.getScreenWidth(context),
                child: TextButton(
                  onPressed: () {},
                  child: Text(AppTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
