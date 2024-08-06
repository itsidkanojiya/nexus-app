import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/custome_widgets/text_field_widget.dart';
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/module/paper/create%20paper/add%20details/add_paper_details_controller.dart';
import 'package:nexus_app/module/paper/create%20paper/add%20question/questions_view.dart';
import 'package:nexus_app/services/auth_service.dart';
import 'package:nexus_app/theme/loaderScreen.dart';
import 'package:nexus_app/theme/style.dart';

class AddPaperDetailsScreen extends StatelessWidget {
  AddPaperDetailsScreen({
    super.key,
  });
  final formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  var controller = Get.isRegistered<AddPaperDetailsController>()
      ? Get.find<AddPaperDetailsController>()
      : Get.put(AddPaperDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Paper Details"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(2, 10, 0, 3.0),
                  child: Text(
                    'School Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
                AppTextField(
                  maxLine: 1,
                  controller: controller.schoolNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add school name';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(2, 12, 0, 3.0),
                  child: Text(
                    'School Address',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
                AppTextField(
                  maxLine: 1,
                  controller: controller.schoolAddressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add school address';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(2, 12, 0, 3.0),
                  child: Text(
                    'Upload School Logo',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
                Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                          alignment: Alignment.center,
                          child: controller.schoolLogo.value == null
                              ? InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      enableDrag: false,
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          color: Colors.white,
                                        ),
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                                leading: const Icon(
                                                    Icons.photo_library),
                                                title: const Text('Gallery'),
                                                onTap: () async {
                                                  controller.schoolLogo.value =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  Get.back();
                                                }),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_camera),
                                              title: const Text('Camera'),
                                              onTap: () async {
                                                controller.schoolLogo.value =
                                                    await picker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload_outlined,
                                          color: Colors.grey, size: 40),
                                      Text(
                                        "Upload",
                                      )
                                    ],
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      barrierColor: Colors.red[50],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      enableDrag: false,
                                      Container(
                                        height: 120,
                                        color: Colors.grey,
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                                leading: const Icon(
                                                    Icons.photo_library),
                                                title: const Text('Gallery'),
                                                onTap: () async {
                                                  controller.schoolLogo.value =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  Get.back();
                                                }),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_camera),
                                              title: const Text('Camera'),
                                              onTap: () async {
                                                controller.schoolLogo.value =
                                                    await picker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.file(
                                            File(controller
                                                .schoolLogo.value!.path),
                                            fit: BoxFit.fill,
                                            height: 80,
                                            width: 80,
                                          )),
                                      const Positioned(
                                          right: 0,
                                          top: 10,
                                          child: Icon(Icons.camera_alt_outlined,
                                              color: Colors.blue, size: 20))
                                    ],
                                  ),
                                )),
                    )),
                const Padding(
                  padding: EdgeInsets.fromLTRB(2, 10, 0, 3.0),
                  child: Text(
                    'Grade',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: DropdownButtonFormField<String>(
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
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
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 10, 0, 3.0),
                  child: RichText(
                      text: const TextSpan(
                          text: 'Paper timing',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                          children: <TextSpan>[
                        TextSpan(
                            text: ' (add with Hours or minutes)',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            children: <TextSpan>[])
                      ])),
                ),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay pickedTime = (await showTimePicker(
                      context: context,
                      initialTime: controller.selectedTime.value,
                    ))!;
                    if (pickedTime != controller.selectedTime.value) {
                      controller.selectedTime.value = pickedTime;
                    }
                    // setState(() {});
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: (controller.selectedTime == null)
                          ? Row(
                              children: [
                                Obx(
                                  () => Text(
                                    AppService().timeOfDayToString(
                                        controller.selectedTime.value),
                                    // dateSelected ?? '',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.5),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                    AppService().timeOfDayToString(
                                        controller.selectedTime.value),
                                    // dateSelected ?? '',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.5),
                                  ),
                                ),
                              ],
                            )),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(2, 12, 0, 3.0),
                  child: Text(
                    'Date',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      controller.dateSelected.value = await showDatePicker(
                            context: context,
                            lastDate: DateTime(2050, 9, 7, 17, 30),
                            firstDate: DateTime.now(),
                            initialDate: DateTime.now(),
                          ) ??
                          DateTime.now();

                      // setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Obx(() => (controller.dateSelected == null)
                          ? const Row(
                              children: [
                                Text(
                                  'dd/mm/yyyy',
                                  // dateSelected ?? '',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(controller.dateSelected.value ??
                                          DateTime.now())
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5),
                                ),
                              ],
                            )),
                    )),
                const Padding(
                  padding: EdgeInsets.fromLTRB(2, 12, 0, 3.0),
                  child: Text(
                    'Select Board',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: DropdownButtonFormField<Board>(
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a board';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
                          hint: const Text('Select a board'),
                          value: controller.selectedBoard.value,
                          onChanged: (Board? newValue) {
                            controller.selectedBoard.value = newValue;
                          },
                          items: controller.boardModel?.boards?.map((board) {
                                return DropdownMenuItem<Board>(
                                  value: board,
                                  child: Text(board.name ?? ''),
                                );
                              }).toList() ??
                              [],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (controller.schoolLogo.value?.path != null) {
                        bool next = await controller.addPaperDetails(context);
                        if (next == true) {
                          Get.offAll(AddQuestionView());
                        }
                      }
                      Loader().onError(msg: 'Please add school logo');
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 50,
                    // width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Style.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600 // Set the font size
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
