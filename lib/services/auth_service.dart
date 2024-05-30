import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nexus_app/models/user_model.dart';

class AuthService extends GetxService {
  static Rx<UserModel?> userModel = Rx<UserModel?>(null);
  static RxInt indexValue = 0.obs;
  static RxInt subTeacherIndex = 0.obs;
  static RxInt analysisIndex = 0.obs;
  static RxInt subQuetionIndex = 0.obs;
  static final storage = GetStorage();
  static String? get token =>
      storage.read('token') != null ? storage.read('token')['jwt'] : null;
  static Future<void> saveUserToStorage(UserModel user) async {
    userModel.value = user;
    await storage.write('userModel', jsonEncode(user.toJson()));
  }
}
