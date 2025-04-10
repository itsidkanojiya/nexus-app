import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/custome_widgets/custom_button_widget.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/module/auth/signup/signup_controller.dart';
import 'package:nexus_app/services/app_service.dart';
import 'package:nexus_app/theme/style.dart';

class SignUpView extends StatelessWidget {
  SignUpView({
    super.key,
  });

  final SignUpController controller = Get.put(SignUpController());
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _signupContent(),
                const SizedBox(
                    height:
                        100), // Add spacing to avoid overlapping with the bottom bar
              ],
            ),
          ),
          // Fixed Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              color: Colors.white, // Background color for the bottom bar
              child: CustomButton(
                text: 'Submit',
                onTap: () async {
                  if (controller.formKey.currentState!.validate()) {
                    controller.signUp();
                  }
                },
                startColor: Style.bg_color,
                endColor: const Color.fromARGB(255, 237, 202, 145),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signupContent() {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
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
                const pattern =
                    r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                final regex = RegExp(pattern);

                return value!.isNotEmpty && !regex.hasMatch(value)
                    ? 'Enter a valid email address'
                    : null;
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 236, 236),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      const Border(bottom: BorderSide(color: Style.bg_color)),
                ),
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
                    hintStyle: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            textfieldWidget(
              controller: controller.school,
              hinttext: 'School Name',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your school name';
                }
                return null;
              },
            ),
            Obx(
              () => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        AppService.userType.value =
                            'student'; // Update the reactive variable
                      },
                      child: Container(
                        height: 170,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Style.bg_color,
                          border: AppService.userType.value == 'student'
                              ? Border.all(color: Colors.blue, width: 2)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/student.png'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Student',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        AppService.userType.value = 'teacher';
                      },
                      child: Container(
                        height: 170,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Style.bg_color,
                          border: AppService.userType.value == 'teacher'
                              ? Border.all(color: Colors.blue, width: 2)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/teacher.png'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Teacher',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => (AppService.userType.value == 'student')
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            ' Choose Standard:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Style.textfield_color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: DropdownButtonFormField<int>(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    hint: const Text('Select a Standard'),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a standard';
                                      }
                                      return null;
                                    },
                                    value: controller.selectedStandard.value,
                                    onChanged: (int? newValue) {
                                      controller.selectedStandard.value =
                                          newValue ?? 1;
                                    },
                                    items: List.generate(10, (index) {
                                      final standard = index +
                                          1; // Generate standards from 1 to 10
                                      return DropdownMenuItem<int>(
                                        value: standard,
                                        child: Text(standard.toString()),
                                      );
                                    }),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            ' Choose Subject:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                      controller.selectedSubject.value =
                                          newValue;
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
                        const SizedBox(height: 10),
                      ],
                    ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 236, 236),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      const Border(bottom: BorderSide(color: Style.bg_color)),
                ),
                child: Obx(
                  () => TextFormField(
                    obscureText: !controller.isPasswordVisible.value,
                    controller: controller.password,
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (!regex.hasMatch(value)) {
                          return 'Must contain at least 1 uppercase, 1 lowercase, and 1 numeric character. Minimum 8 characters';
                        }
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isPasswordVisible.value =
                              !controller.isPasswordVisible.value;
                        },
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
          child: Center(
              child: SizedBox(
                  height: 150, child: Lottie.asset('assets/otp.json'))),
        ),
        const Center(
          child: Text(
            'Verification',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(23, 8, 20, 3),
          child: Center(
            child: Text(
              'Please Enter The OTP Sent To Your Device.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        OtpTextField(
          fieldWidth: 50,
          numberOfFields: 6,
          borderColor: Style.bg_color,
          showFieldAsBox: true,
          onCodeChanged: (String code) {
            // Handle validation or checks here
          },
          onSubmit: (String verificationCode) {
            controller.otp.text = verificationCode;
          },
        ),
        const SizedBox(height: 20),
        Center(
          child: Obx(() => ElevatedButton(
                onPressed: controller.isResendButtonEnabled.value
                    ? controller.resendOtp
                    : null,
                child: controller.isResendButtonEnabled.value
                    ? const Text('Resend OTP')
                    : Text('Resend OTP in ${controller.countdown.value} sec'),
              )),
        ),
      ],
    );
  }
}

class textfieldWidget extends StatelessWidget {
  const textfieldWidget({
    super.key,
    required this.hinttext,
    required this.validator,
    required this.controller,
  });
  final String? hinttext;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 237, 236, 236),
          borderRadius: BorderRadius.circular(12),
          border: const Border(bottom: BorderSide(color: Style.bg_color)),
        ),
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}
