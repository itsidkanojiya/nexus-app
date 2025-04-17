import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/custome_widgets/text_field_widget.dart';
import 'package:nexus_app/module/profile/edit_profile_controller.dart';
import 'package:nexus_app/theme/style.dart';

class EditProfilePage extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Style.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(
              controller: controller.nameController,
              hintText: 'Enter Name',
            ),
            const SizedBox(height: 15),
            AppTextField(
              controller: controller.schoolController,
              hintText: 'Enter School Name',
            ),
            // const SizedBox(height: 15),
            // AppTextField(
            //   controller: controller.stdController,
            //   hintText: 'Enter Standard',
            // ),
            const Spacer(),
            Obx(() {
              return controller.isLoading.value
                  ? SizedBox()
                  : GestureDetector(
                      onTap: controller.updateProfile,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Style.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Save Changes',
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
