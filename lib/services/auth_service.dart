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
  static RxString userType = 'student'.obs;
  static final storage = GetStorage();

  // Get the token directly as it is stored
  static String? get token => storage.read('token');
  static int? get id => storage.read('id');

  // Retrieve the user ID
  static int? get userId {
    final storedUser = storage.read('userModel');
    if (storedUser != null) {
      final userMap = jsonDecode(storedUser);
      return UserModel.fromJson(userMap).user?.id;
    }
    return null;
  }
}
