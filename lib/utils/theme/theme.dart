import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/widgets_theme/appbar_theme.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/widgets_theme/bottom_sheet_theme.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/widgets_theme/checkbox_theme.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/widgets_theme/chip_theme.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/widgets_theme/elevated_buttom_theme.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/widgets_theme/outlined_button_theme.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/widgets_theme/text_field_theme.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/widgets_theme/text_theme.dart';

class AppTheme {
  //private constructor
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    disabledColor: AppColors.grey,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: UAppBarTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    disabledColor: AppColors.grey,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: UAppBarTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
  );
}
