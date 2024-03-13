import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/module/auth/signup/signup_controller.dart';
import 'package:nexus_app/repository/auth_repository.dart';
import 'package:nexus_app/theme/style.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key, required this.type});
  String type;
  var controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Style.bg_color,
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          textfieldWidget(
            controller: controller.name,
            hinttext: 'Full Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          textfieldWidget(
            controller: controller.email,
            hinttext: 'Email',
            validator: (value) {
              final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value ?? "");
              if (value!.isEmpty) {
                return 'Please enter your chapter number';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 236, 236),
                  borderRadius: BorderRadius.circular(5),
                  border:
                      const Border(bottom: BorderSide(color: Style.bg_color))),
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.phone,
                controller: controller.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Number',
                    hintStyle: TextStyle(color: Colors.grey[700])),
              ),
            ),
          ),
          (type == 'student')
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Text(
                        ' Choose Standard:',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Style.textfield_color),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration.collapsed(
                                      hintText: ''),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a standard';
                                    }
                                    return null;
                                  },
                                  value: controller.selectedStandard.value,
                                  onChanged: (String? newStandard) {
                                    if (newStandard != null) {
                                      controller.selectedStandard.value =
                                          newStandard;
                                    }
                                  },
                                  items: controller.standardLevels
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                )
              : const SizedBox(),
          (type == 'teacher')
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Text(
                        ' Choose Subject:',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Style.textfield_color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: DropdownButtonFormField<Subjects>(
                                decoration: const InputDecoration.collapsed(
                                    hintText: ''),
                                hint: const Text('Select a Subject'),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a subject';
                                  }
                                  return null;
                                },
                                value: controller.selectedSubject.value,
                                onChanged: (Subjects? newValue) {
                                  controller.selectedSubject.value = newValue;
                                },
                                items: controller.subjectModel?.subjects
                                        ?.map((board) {
                                      return DropdownMenuItem<Subjects>(
                                        value: board,
                                        child: Text(board.name ?? ''),
                                      );
                                    }).toList() ??
                                    [],
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                )
              : const SizedBox(),
          textfieldWidget(
            controller: controller.school,
            hinttext: 'School Name',
            validator: (value) {
              return null;
            },
          ),
          textfieldWidget(
            controller: controller.password,
            hinttext: 'Password',
            validator: (value) {
              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
              if (value!.isEmpty) {
                return 'Please enter password';
              } else {
                if (!regex.hasMatch(value)) {
                  return 'Must contain at least 1 uppercase, 1 lowercase, and 1 numeric character. Minimum 8 characters';
                } else {
                  return null;
                }
              }
            },
          ),
        ]),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              if (type == 'student') {
                var map = {
                  'user_type': 'student',
                  "name": controller.name.text,
                  "email": controller.email.text,
                  "number": controller.number.text,
                  "std": controller.selectedStandard.value,
                  "school": controller.school.text,
                  "password": controller.password.text,
                };
                print(map);
                await AuthRepository().signup(map);
              }
              if (type == 'teacher') {
                var map = {
                  'user_type': 'teacher',
                  "name": controller.name.text,
                  "email": controller.email.text,
                  "number": controller.number.text,
                  "subject": controller.selectedSubject.value.toString(),
                  "school": controller.school.text,
                  "password": controller.password.text,
                };
                print(map);
                await AuthRepository().signup(map);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: [
                      Style.bg_color,
                      Color.fromARGB(255, 237, 202, 145),
                    ])),
                child: const Center(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class textfieldWidget extends StatelessWidget {
  textfieldWidget(
      {super.key,
      required this.hinttext,
      required this.validator,
      required this.controller});
  String? hinttext;
  String? Function(String?)? validator;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 237, 236, 236),
            borderRadius: BorderRadius.circular(5),
            border: const Border(bottom: BorderSide(color: Style.bg_color))),
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              hintStyle: TextStyle(color: Colors.grey[700])),
        ),
      ),
    );
  }
}
