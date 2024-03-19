import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/module/auth/signup/signup_controller.dart';
import 'package:nexus_app/repository/auth_repository.dart';
import 'package:nexus_app/theme/style.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key, required this.type});
  String type;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  var controller = Get.put(SignUpController());
  late TabController _tabController;

  void _handleTabChange() {
    // Access the current index of the TabController
    controller.currentIndex = _tabController.index.obs;
    // Do something with the current index
    print('Current index:${controller.currentIndex}');
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabBarView = TabBarView(
      controller: _tabController,
      children: [
        Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 237, 236, 236),
                            borderRadius: BorderRadius.circular(12),
                            border: const Border(
                                bottom: BorderSide(color: Style.bg_color))),
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
                    //
                    (widget.type == 'teacher')
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
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
                                        child:
                                            DropdownButtonFormField<Subjects>(
                                          decoration:
                                              const InputDecoration.collapsed(
                                                  hintText: ''),
                                          hint: const Text('Select a Subject'),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select a subject';
                                            }
                                            return null;
                                          },
                                          value:
                                              controller.selectedSubject.value,
                                          onChanged: (Subjects? newValue) {
                                            controller.selectedSubject.value =
                                                newValue;
                                          },
                                          items: controller
                                                  .subjectModel?.subjects
                                                  ?.map((board) {
                                                return DropdownMenuItem<
                                                    Subjects>(
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
                    const SizedBox(
                      height: 5,
                    ),
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
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 20.0, // Spacing between columns
                mainAxisSpacing: 15.0, // Spacing between rows
              ),
              // itemCount: controller.boardModel?.boards?.length,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
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
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(controller.boardModel
                                          ?.boards?[index].coverLink ??
                                      '')),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.boardModel?.boards?[index].name ?? '-',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 20.0, // Spacing between columns
                mainAxisSpacing: 15.0, // Spacing between rows
              ),
              // itemCount: controller.boardModel?.boards?.length,
              itemCount: controller.standardLevels.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Style.bg_color),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   height: 100,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //         image: NetworkImage(controller.boardModel
                          //                 ?.boards?[index].coverLink ??
                          //             '')),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.standardLevels[index] ?? '-',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                );
              }),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
              child: Center(
                  child: Text(
                'Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(23, 8, 20, 3),
              child: Text(
                'Please Enter The OTP Sent To Your Device.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            textfieldWidget(
                hinttext: 'Enter OTP Here',
                validator: (value) {
                  if (value == null) {
                    return 'Please select a standard';
                  }
                  return null;
                },
                controller: controller.otp),
          ],
        )
      ],
    );
    return Scaffold(
      //   backgroundColor: Style.bg_color,
      appBar: AppBar(
        title: const Text('Registration'),
        bottom: PreferredSize(
          preferredSize: const Size(10, 30),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Container(
                child: const Text('Sign_up'),
              ),
              Container(
                child: const Text('Board'),
              ),
              Container(
                child: const Text('Standard'),
              ),
              Container(
                child: const Text('OTP'),
              )
            ],
            dividerColor: Style.bg_color,
            indicatorColor: Colors.black,
          ),
        ),
      ),
      body: tabBarView,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              if (_tabController.index == 3) {
                if (widget.type == 'student') {
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
                if (widget.type == 'teacher') {
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
              } else {
                _tabController.animateTo(_tabController.index + 1);

                _tabController.addListener(_handleTabChange);
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
                child: Center(
                    child: (controller.currentIndex?.value == 3)
                        ? const Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
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
        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 237, 236, 236),
            borderRadius: BorderRadius.circular(12),
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

// (widget.type == 'student')
//     ? Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 20.0,
//             ),
//             child: Text(
//               ' Choose Standard:',
//               style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700),
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
          // Obx(() => Padding(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 20.0,
          //       ),
          //       child: Container(
          //         width: 80,
          //         height: 40,
          //         decoration: BoxDecoration(
          //             borderRadius:
          //                 BorderRadius.circular(10),
          //             color: Style.textfield_color),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 10),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child:
          //                 DropdownButtonFormField<String>(
          //               decoration:
          //                   const InputDecoration.collapsed(
          //                       hintText: ''),
          //               validator: (value) {
          //                 if (value == null) {
          //                   return 'Please select a standard';
          //                 }
          //                 return null;
          //               },
          //               value: controller
          //                   .selectedStandard.value,
          //               onChanged: (String? newStandard) {
          //                 if (newStandard != null) {
          //                   controller.selectedStandard
          //                       .value = newStandard;
          //                 }
          //               },
          //               items: controller.standardLevels
          //                   .map<DropdownMenuItem<String>>(
          //                       (String value) {
          //                 return DropdownMenuItem<String>(
          //                   value: value,
          //                   child: Text(value),
          //                 );
          //               }).toList(),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )),
//         ],
//       )
//     : const SizedBox(),
