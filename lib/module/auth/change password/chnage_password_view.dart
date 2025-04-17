import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/custome_widgets/text_field_widget.dart';
import 'package:nexus_app/module/auth/change%20password/change_password_controller.dart';
import 'package:nexus_app/theme/style.dart';

class ChangePassworView extends StatelessWidget {
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

  ChangePassworView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Style.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(
              controller: controller.oldPasswordController,
              hintText: 'Enter Old Password',
              //   obscureText: true,
            ),
            const SizedBox(height: 15),
            AppTextField(
              controller: controller.newPasswordController,
              hintText: 'Enter New Password',
              //    obscureText: true,
            ),
            const SizedBox(height: 15),
            AppTextField(
              controller: controller.confirmPasswordController,
              hintText: 'Confirm New Password',
              //     obscureText: true,
            ),
            const Spacer(),
            Obx(() {
              return controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: controller.changePassword,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Style.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
