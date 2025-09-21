import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class AppPrivacyPolicyChekcBox extends StatelessWidget {
  const AppPrivacyPolicyChekcBox({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value) {}),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(text: '${AppTexts.iAgreeTo} '),
              TextSpan(
                text: '${AppTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: dark ? AppColors.white : AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? AppColors.white : AppColors.primary,
                ),
              ),
              TextSpan(text: '${AppTexts.and} '),
              TextSpan(
                text: '${AppTexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: dark ? AppColors.white : AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? AppColors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
