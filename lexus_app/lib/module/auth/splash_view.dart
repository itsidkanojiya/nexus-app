import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexus_app/module/auth/splash_controller.dart';
import 'package:lexus_app/services/auth_service.dart';
import 'package:lexus_app/theme/style.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);
  var authController = Get.isRegistered<AuthService>()
      ? Get.find<AuthService>()
      : Get.put(AuthService());
  var controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bg_color,
      body: Center(child: Image.asset("assets/logo.png", height: 300)),
    );
  }
}
