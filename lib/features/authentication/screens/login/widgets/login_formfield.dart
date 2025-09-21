import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/outline_button.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/signup/signup.dart';
import 'package:flutter_ecommerce_app_v2/navigation_menu.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppLoginForm extends StatelessWidget {
  const AppLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //email
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.direct_right),
            labelText: AppTexts.email,
          ),
        ),
        SizedBox(height: AppSizes.spaceBtwInputFields),
        //password
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.password_check),
            labelText: AppTexts.password,
            suffixIcon: Icon(Iconsax.eye),
          ),
        ),
        SizedBox(height: AppSizes.spaceBtwInputFields / 2),
        //remeber me
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Text(
                  AppTexts.rememberMe,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            TextButton(
              onPressed: () => Get.to(() => ForgetPasswordScreen()),
              child: Text(
                AppTexts.forgetPassword,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwSections),
        //SignIn Button
        AppElevatedButton(
          onPressed: () => Get.to(() => NavigationMenu()),
          child: Text(AppTexts.signIn),
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        AppOutlineButton(
          onPressed: () => Get.to(SignupScreen()),
          child: Text(AppTexts.createAccount),
        ),
      ],
    );
  }
}
