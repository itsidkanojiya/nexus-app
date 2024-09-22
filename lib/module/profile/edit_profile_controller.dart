import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/repository/profile_repository.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController stdController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchProfileData();
    super.onInit();
  }

  void fetchProfileData() async {
    isLoading(true);
    var user = await ProfileRepository().getUser();
    if (user != null) {
      nameController.text = user.name ?? '';
      schoolController.text = user.school ?? '';
      stdController.text = user.std?.toString() ?? '';
    }
    isLoading(false);
  }

  void updateProfile() async {
    if (nameController.text.isEmpty ||
        schoolController.text.isEmpty ||
        stdController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all the fields");
      return;
    }

    isLoading(true);
    Map<String, dynamic> profileData = {
      'name': nameController.text,
      'school': schoolController.text,
      'std': stdController.text,
    };

    bool result = await ProfileRepository().editProfile(profileData);
    isLoading(false);

    if (result) {
      Get.snackbar("Success", "Profile updated successfully");
    } else {
      Get.snackbar("Error", "Failed to update profile");
    }
  }
}
