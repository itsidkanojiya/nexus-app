import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/custome_widgets/text_field_widget.dart';
import 'package:nexus_app/module/profile/edit_profile/edit_profile_controller.dart';
import 'package:nexus_app/theme/style.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  EditProfileController controller = EditProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Style.bg_color),
                        height: 100,
                        width: 100,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Style.primary),
                          height: 28,
                          width: 28,
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Text('Enter ')
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
                child: AppTextField(
                  controller: controller.namecontroller,
                  boxheight: 55,
                  hintText: 'Enter Your Name',
                  hintTextSize: 14,
                  fontWeight: FontWeight.normal,
                  textsize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: AppTextField(
                  controller: controller.numbercontroller,
                  boxheight: 55,
                  hintText: 'Enter Your Phone Number',
                  hintTextSize: 14,
                  fontWeight: FontWeight.normal,
                  textsize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: AppTextField(
                  controller: controller.schoolcontroller,
                  boxheight: 55,
                  hintText: 'Enter Your School Name',
                  hintTextSize: 14,
                  fontWeight: FontWeight.normal,
                  textsize: 14,
                ),
              ),
              Obx(() => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Container(
                      // width: 80,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey, // Color of the border
                            width: 2.0, // Width of the border
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField<String>(
                            decoration:
                                const InputDecoration.collapsed(hintText: ''),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a standard';
                              }
                              return null;
                            },
                            value: controller.selectedStandard.value,
                            onChanged: (String? newStandard) {
                              if (newStandard != null) {
                                controller.selectedStandard.value = newStandard;
                              }
                            },
                            items: controller.standardLevels
                                .map<DropdownMenuItem<String>>((String value) {
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
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Style.primary),
                  child: const Center(
                      child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
