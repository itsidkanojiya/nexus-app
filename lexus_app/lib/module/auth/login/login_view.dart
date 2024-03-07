import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexus_app/module/auth/login/login_controller.dart';
import 'package:lexus_app/theme/style.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  var controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bg_color,
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset("assets/logo.png", height: 200),
          Form(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.emailText,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.passwordText,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  label: const Text('Login'),
                  icon: const Icon(Icons.abc),
                  onPressed: () {
                    controller.login();
                  },
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
