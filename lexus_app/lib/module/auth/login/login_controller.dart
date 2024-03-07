import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lexus_app/module/home/home_page.dart';

class LoginController extends GetxController {
  var emailText = TextEditingController();
  var passwordText = TextEditingController();
  void login() async {
    var map = {
      'number': emailText.text.toString(),
      'password': passwordText.text.toString()
    };
    Get.to(const HomeView());
    // await AuthRepository().signIn(map);
  }
}
