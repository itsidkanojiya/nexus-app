import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/repository/auth_repository.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isLoading = false.obs;

  void changePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading(true);
    Map<String, dynamic> passwordData = {
      'old_password': oldPasswordController.text,
      'new_password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text,
    };

    bool result = await AuthRepository().changePassword(passwordData);
    isLoading(false);

    if (result) {
      Get.snackbar("Success", "Password changed successfully");
    } else {
      Get.snackbar("Error", "Failed to change password");
    }
  }
}
