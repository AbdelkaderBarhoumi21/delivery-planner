import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/navigation_menu.dart';
import 'package:get/get.dart';

import 'package:flutter_ecommerce_app_v2/features/authentication/controllers/auth/authentication_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/screens/login/login_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // 👇 Utilise les DEUX flags
      home: Obx(() {
        if (auth.isFirstTime) return const OnboardingScreen();
        if (auth.isLoggedIn) return const NavigationMenu();
        return const LoginScreen();
      }),
    );
  }
}
