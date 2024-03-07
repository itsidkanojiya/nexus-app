import 'package:get/get.dart';
import 'package:lexus_app/module/auth/login/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  Future<void> checkLogin() async {
    //AuthRepository().verifyToken();
    await Future.delayed(const Duration(seconds: 2));
    Get.to(LoginView());
  }
}
