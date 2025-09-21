import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: OnboardingScreen(),
    );
  }
}
