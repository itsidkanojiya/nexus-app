import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/repository/auth_repository.dart';
import 'package:nexus_app/services/app_service.dart';

class OtpController extends GetxController {
  var isResendButtonEnabled = false.obs;
  var countdown = 90.obs;
  var otp = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  void resendOtp() {
    if (isResendButtonEnabled.value) {
      startCountdown();
      AuthRepository().resendOtp();
    }
  }

  void startCountdown() {
    isResendButtonEnabled.value = false;
    countdown.value = 90;
    Future.delayed(const Duration(seconds: 1), updateCountdown);
  }

  Future<bool> verifyOtp() async {
    var map = {
      "email": AppService.id.toString(),
      "otp": otp.text,
    };
    return AuthRepository().verifyOtp(map);
  }

  void updateCountdown() {
    if (countdown.value > 0) {
      countdown.value--;
      Future.delayed(const Duration(seconds: 1), updateCountdown);
    } else {
      isResendButtonEnabled.value = true;
    }
  }
}
