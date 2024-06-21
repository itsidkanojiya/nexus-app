import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/custome_widgets/text_field_widget.dart';
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/models/question_model.dart';
import 'package:nexus_app/module/paper/create_paper_controller.dart';
import 'package:nexus_app/module/paper/questions_view.dart';
import 'package:nexus_app/theme/loaderScreen.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'pdf_generator.dart';

class CreatePaper extends StatefulWidget {
  const CreatePaper({super.key});

  @override
  State<CreatePaper> createState() => _CreatePaperState();
}

class _CreatePaperState extends State<CreatePaper>
    with SingleTickerProviderStateMixin {
  int activeStep = 2;
  final pdfGen = PDFGenerator(
    subject: 'Maths',
    schoolLogoUrl:
        'https://nexuspublication.com/logos/Nexus%20Logo%20png-01.png',
    schoolName: 'Knowledge High School',
    schoolAddress: 'Anand, Gujarat',
    grade: '1',
    date: DateTime.now(),
    time: TimeOfDay.now(),
    questions: [
      QuestionModel(
          question: 'What is the chemical formula for water?',
          type: 'mcq',
          options: ['H2O', 'CO2', 'NaCl', 'HCl']),
      QuestionModel(
        question: 'What is the chemical formula for water?',
        type: 'short',
        // options: ['H2O', 'CO2', 'NaCl', 'HCl']
      ),
      // Add more questions here
    ],
  );
  Future<Uint8List> _createPdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Container(
              width: double.infinity,
              child: pw.Column(children: [
                pw.Text('Testing First PDF'),
                pw.Container(
                  width: 250,
                  height: 1.5,
                ),
              ]));
        }));
    return pdf.save();
  }

  final formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  var controller = Get.isRegistered<CreatePaperController>()
      ? Get.find<CreatePaperController>()
      : Get.put(CreatePaperController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Style.secondary,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Style.secondary),
            elevation: 0,
            backgroundColor: Style.primary,
            title: const Text(
              'Generate Question Paper',
              style: TextStyle(color: Style.secondary),
            ),
            bottom: const TabBar(
              labelColor: Style.secondary,
              indicatorColor: Style.secondary,
              tabs: [
                Tab(text: 'Paper Details'),
                Tab(text: 'Add Questions'),
                Tab(text: 'Preview'),
              ],
            ),
          ),
          body: Builder(builder: (context) {
            TabController? tabController = DefaultTabController.of(context);
            return TabBarView(
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 1.8),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: controller.schoolLogo.value == null
                                        ? InkWell(
                                            onTap: () {
                                              Get.bottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                ),
                                                enableDrag: false,
                                                Container(
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    color: Colors.white,
                                                  ),
                                                  child: Wrap(
                                                    children: <Widget>[
                                                      ListTile(
                                                          leading: const Icon(
                                                              Icons
                                                                  .photo_library),
                                                          title: const Text(
                                                              'Gallery'),
                                                          onTap: () async {
                                                            controller
                                                                    .schoolLogo
                                                                    .value =
                                                                await picker.pickImage(
                                                                    source: ImageSource
                                                                        .gallery);
                                                            Get.back();
                                                          }),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons.photo_camera),
                                                        title: const Text(
                                                            'Camera'),
                                                        onTap: () async {
                                                          controller.schoolLogo
                                                                  .value =
                                                              await picker.pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                    Icons.cloud_upload_outlined,
                                                    color: Colors.grey,
                                                    size: 40),
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
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                ),
                                                enableDrag: false,
                                                Container(
                                                  height: 120,
                                                  color: Colors.grey,
                                                  child: Wrap(
                                                    children: <Widget>[
                                                      ListTile(
                                                          leading: const Icon(
                                                              Icons
                                                                  .photo_library),
                                                          title: const Text(
                                                              'Gallery'),
                                                          onTap: () async {
                                                            controller
                                                                    .schoolLogo
                                                                    .value =
                                                                await picker.pickImage(
                                                                    source: ImageSource
                                                                        .gallery);
                                                            Get.back();
                                                          }),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons.photo_camera),
                                                        title: const Text(
                                                            'Camera'),
                                                        onTap: () async {
                                                          controller.schoolLogo
                                                                  .value =
                                                              await picker.pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);
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
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.file(
                                                      File(controller.schoolLogo
                                                          .value!.path),
                                                      fit: BoxFit.fill,
                                                      height: 80,
                                                      width: 80,
                                                    )),
                                                const Positioned(
                                                    right: 0,
                                                    top: 10,
                                                    child: Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        color: Colors.blue,
                                                        size: 20))
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.8),
                                borderRadius: BorderRadius.circular(10)),
                            child: Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 1.8),
                                    borderRadius: BorderRadius.circular(10)),
                                child: (controller.selectedTime == null)
                                    ? Row(
                                        children: [
                                          Obx(
                                            () => Text(
                                              controller.timeOfDayToString(
                                                  controller
                                                      .selectedTime.value),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(
                                            () => Text(
                                              controller.timeOfDayToString(
                                                  controller
                                                      .selectedTime.value),
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
                                controller.dateSelected.value =
                                    await showDatePicker(
                                          context: context,
                                          lastDate:
                                              DateTime(2050, 9, 7, 17, 30),
                                          firstDate: DateTime.now(),
                                          initialDate: DateTime.now(),
                                        ) ??
                                        DateTime.now();

                                // setState(() {});
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 1.8),
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    Obx(() => (controller.dateSelected == null)
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                DateFormat('dd/MM/yyyy')
                                                    .format(controller
                                                            .dateSelected
                                                            .value ??
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.8),
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
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    hint: const Text('Select a board'),
                                    value: controller.selectedBoard.value,
                                    onChanged: (Board? newValue) {
                                      controller.selectedBoard.value = newValue;
                                    },
                                    items: controller.boardModel?.boards
                                            ?.map((board) {
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
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (controller.schoolLogo.value?.path != null) {
                                  controller.addPaperDetails(context);
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
                                      fontWeight:
                                          FontWeight.w600 // Set the font size
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
                ////Tab 2
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Stack(
                    children: [
                      QuestionView(
                        allQuestions: controller.questions,
                      ),
                      const SizedBox(
                        height: 75,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            tabController.index = 2;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Style.primary,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    offset:
                                        Offset(1, 2), // Shadow position (x, y)
                                    blurRadius: 1.0, // Spread of the shadow
                                    spreadRadius: 1.0, // Offset of the shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // //?? Tab No.3 ??//-------------------------------------------------------------------------
                // GestureDetector(
                //   onTap: () {
                //     makePdf();
                //   },
                //   child: const Center(child: Text('generate')),
                // )
                PdfPreview(
                  build: (format) =>
                      pdfGen.generatePDF().then((pdf) => pdf.save()),
                  allowPrinting: true,
                  allowSharing: true,
                  canChangePageFormat: false,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
