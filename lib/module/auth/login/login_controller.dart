import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nexus_app/repository/auth_repository.dart';

class LoginController extends GetxController {
  var emailText = TextEditingController();
  var passwordText = TextEditingController();
  var obscureText = true.obs;

  void toggleObscureText() {
    obscureText.toggle();
  }

  void login() async {
    var map = {
      'number': emailText.text.toString(),
      'password': passwordText.text.toString()
    };

    await AuthRepository().signIn(map);

    emailText.clear();
    passwordText.clear();
  }
}
