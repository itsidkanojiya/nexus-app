import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/module/auth/login/otp_controller.dart';
import 'package:nexus_app/theme/style.dart';

import '../../../custome_widgets/custom_button_widget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final OtpController controller = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 5),
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: CustomButton(
              text: 'Continue',
              onTap: () async {
                controller.verifyOtp();
              },
              startColor: Style.bg_color,
              endColor: const Color.fromARGB(255, 237, 202, 145),
            ),
          ),
        ],
      ),
    );
  }
}
