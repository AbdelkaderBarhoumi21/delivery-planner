import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app_v2/env.dart';
import 'package:flutter_ecommerce_app_v2/features/authentication/controllers/auth/authentication_controller.dart';
import 'package:flutter_ecommerce_app_v2/my_app.dart';
import 'package:flutter_ecommerce_app_v2/data/services/hive_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.init();
  await GetStorage.init();
  await HiveService.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(AuthController());
  debugPrint('[Env] flavor=${Env.flavor}  codTolerance=${Env.codTolerance}');

  runApp(const MyApp());
}
