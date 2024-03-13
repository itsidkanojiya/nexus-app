import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/auth/signup/signup_view.dart';
import 'package:nexus_app/theme/style.dart';

class SelectUserView extends StatelessWidget {
  const SelectUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Select Type :-',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(SignUpView(type: 'student'));
                  },
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Style.bg_color),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/student.png'))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Student',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(SignUpView(type: 'teacher'));
                  },
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Style.bg_color),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/teacher.png'))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Teacher',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
