import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppSignupForm extends StatelessWidget {
  const AppSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            //first name
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: AppTexts.firstName,
                ),
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwInputFields),
            //last name
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: AppTexts.lastName,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwInputFields),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.direct_right),
            labelText: AppTexts.email,
          ),
        ),
        SizedBox(height: AppSizes.spaceBtwInputFields),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.call),
            labelText: AppTexts.phoneNumber,
          ),
        ),
        SizedBox(height: AppSizes.spaceBtwInputFields),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.password_check),
            labelText: AppTexts.password,
          ),
        ),
        SizedBox(height: AppSizes.spaceBtwInputFields / 2),
        AppPrivacyPolicyChekcBox(),
        SizedBox(height: AppSizes.spaceBtwItems),
        AppElevatedButton(
          onPressed: () => Get.to(() => VerifyEmailScreen()),
          child: Text(AppTexts.createAccount),
        ),
      ],
    );
  }
}
