import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/auth/splash/splash_controller.dart';
import 'package:nexus_app/services/app_service.dart';
import 'package:nexus_app/theme/style.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  var authController = Get.isRegistered<AppService>()
      ? Get.find<AppService>()
      : Get.put(AppService());
  var controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bg_color,
      body: Center(child: Image.asset("assets/logo.png", height: 300)),
    );
  }
}
