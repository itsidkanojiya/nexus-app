import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/custome_widgets/custom_button_widget.dart';
import 'package:nexus_app/module/auth/login/login_controller.dart';
import 'package:nexus_app/module/auth/login/otp_screen.dart';
import 'package:nexus_app/theme/style.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  var controller = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(children: <Widget>[
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Style.bg_color,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(100.0)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: Container(
                                margin: const EdgeInsets.only(top: 50),
                                child: Center(
                                  child: FadeInUp(
                                      duration:
                                          const Duration(milliseconds: 1200),
                                      child: Container(
                                        height: 250,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/logo.png'))),
                                      )),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Style.textfield_color,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Style.bg_color),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 247, 243, 236),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Style.bg_color))),
                                child: TextFormField(
                                  validator: (value) {
                                    final bool phoneNumberValidator =
                                        RegExp(r'^[0-9]{10}$').hasMatch(value!);
                                    final bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value);
                                    if (emailValid ||
                                        phoneNumberValidator == true) {
                                      return null;
                                    }
                                    return 'Please enter valid email or phone';
                                  },
                                  controller: controller.emailText,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email or Phone number",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[700])),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      Get.to(OtpScreen());
                                    }
                                  },
                                  text: "Send OTP"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]))));
  }
}
