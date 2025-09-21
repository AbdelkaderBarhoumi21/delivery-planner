import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/login_signup/form_divider.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/login/widgets/login_formfield.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/social_buttons.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //header
              //title & subtitle
              AppLoginHeader(),
              SizedBox(height: AppSizes.spaceBtwSections),

              //form
              AppLoginForm(),
              SizedBox(height: AppSizes.spaceBtwSections),

              //divider
              AppFormDivider(title: AppTexts.orSignInWith),
              SizedBox(height: AppSizes.spaceBtwSections),
              //footer
              //social Button
              AppSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
