import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/forget_password/reset_passowrd_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //header
              //---title
              Text(
                AppTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwItems / 2),
              Text(
                AppTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwSections * 2),

              //---from
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppTexts.email,
                      prefixIcon: Icon(Iconsax.direct_right),
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceBtwItems),
                  AppElevatedButton(
                    onPressed: () => Get.to(() => ResetPassowrdScreen()),
                    child: Text(AppTexts.submit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
