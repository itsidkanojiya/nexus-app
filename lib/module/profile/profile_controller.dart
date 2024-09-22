import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/user_model.dart';
import 'package:nexus_app/repository/profile_repository.dart';

class ProfileController extends GetxController {
  User? user;
  RxBool isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stdController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);
    user = await ProfileRepository().getUser();

    isLoading(false);
  }
}
