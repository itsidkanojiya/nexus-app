import 'package:get/get.dart';
import 'package:lexus_app/repository/auth_repository.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  Future<void> checkLogin() async {
    AuthRepository().verifyToken();
  }
}
