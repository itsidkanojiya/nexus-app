import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/models/paper_history.dart';
import 'package:nexus_app/module/paper/create%20paper/pdf%20generate/pdf_generator.dart';
import 'package:nexus_app/module/paper/view%20paper/edit%20paper/questions/edit_mark_paper.dart';
import 'package:nexus_app/module/paper/view%20paper/edit%20paper/questions/edit_question_controller.dart';
import 'package:nexus_app/services/app_service.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class EditQuestionView extends StatelessWidget {
  final EditQuestionController controller = Get.put(EditQuestionController());

  EditQuestionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => controller.isLoading.value
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey, width: 1.8),
                          color: Colors.white,
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Dropdown for selecting question type
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey, width: 1.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    value:
                                        controller.selectedQuestionType.value,
                                    onChanged: (String? newType) {
                                      if (newType != null) {
                                        controller.changeQuestionType(newType);
                                      }
                                    },
                                    items: controller.questionTypes
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
                          Obx(() {
                            int selectedCount =
                                controller.getSelectedQuestionCount();
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => EditMarksPage());
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.green,
                                child: Text(
                                  '$selectedCount',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.7,
                        height: 30,
                      ),
                      // Displaying filtered questions
                      Obx(
                        () => controller.isLoading.value == false
                            ? Expanded(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap:
                                        true, // Ensure ListView takes only required space
                                    itemCount: controller.questions.length,
                                    itemBuilder: (context, index) {
                                      final question =
                                          controller.questions[index];
                                      return Card(
                                        color: Colors.blue[50],
                                        margin: const EdgeInsets.all(10.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Style.primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      '${question.subject ?? 'Unknown Subject'} - ${question.std ?? 'N/A'}',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Obx(() => GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .toggleQuestionSelection(
                                                            question,
                                                            !(controller.questionSelection[
                                                                    question] ??
                                                                false),
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: (controller
                                                                            .questionSelection[
                                                                        question] ??
                                                                    false)
                                                                ? Colors.red
                                                                : Style.primary,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Icon(
                                                              (controller.questionSelection[
                                                                          question] ??
                                                                      false)
                                                                  ? Icons.remove
                                                                  : Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                question.question ??
                                                    'No question available',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              if (question.type == 'mcq' &&
                                                  question.options != null)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: question.options!
                                                      .map((option) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Row(
                                                              children: [
                                                                Obx(() =>
                                                                    Checkbox(
                                                                      value: controller
                                                                              .questionSelection[question] ??
                                                                          false,
                                                                      onChanged:
                                                                          (value) {
                                                                        controller
                                                                            .toggleQuestionSelection(
                                                                          question,
                                                                          value ??
                                                                              false,
                                                                        );
                                                                      },
                                                                    )),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Text(option),
                                                              ],
                                                            ),
                                                          ))
                                                      .toList(),
                                                ),
                                              Row(
                                                children: [
                                                  Text('Answer',
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  Obx(() => SizedBox(
                                                        height: 25,
                                                        width: 40,
                                                        child: FittedBox(
                                                          child: Switch(
                                                            value: controller
                                                                        .answerVisibility[
                                                                    question] ??
                                                                false,
                                                            onChanged: (value) {
                                                              controller
                                                                  .toggleAnswerVisibility(
                                                                      question,
                                                                      value);
                                                            },
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              Obx(() =>
                                                  (controller.answerVisibility[
                                                                  question] ==
                                                              true &&
                                                          question.answer !=
                                                              null)
                                                      ? Text(
                                                          'Answer: ${question.answer}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                        )
                                                      : const SizedBox()),
                                              Obx(() =>
                                                  (controller.answerVisibility[
                                                                  question] ==
                                                              true &&
                                                          question.solution !=
                                                              null)
                                                      ? Text(
                                                          'Solution: ${question.solution}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                        )
                                                      : const SizedBox()),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : SizedBox(
                                child:
                                    Lottie.asset('assets/study_loading.json')),
                      ),
                      Obx(() => controller.isLoading.value == false
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  // Show loading indicator using GetX reactive state
                                  Get.dialog(
                                    AlertDialog(
                                      title: Center(
                                        child: Text(
                                          "Hold tight!",
                                          style: Style.tableTitle,
                                        ),
                                      ),
                                      content: SizedBox(
                                          height: 150,
                                          child: Lottie.asset(
                                              'assets/waiting.json')),
                                      actions: [
                                        Text(
                                          "Nexus is crafting your PDF magic. Please wait...",
                                          style: Style.tableTitle,
                                        )
                                      ],
                                    ),
                                    barrierDismissible:
                                        false, // Prevent dismissing by tapping outside
                                  );

                                  // Generate JSON and handle it as needed
                                  final selectedQuestionsJson = controller
                                      .generateSelectedQuestionsJson();
                                  print(selectedQuestionsJson);

                                  // Add questions and fetch updated paper data
                                  controller.addQuestions();
                                  controller
                                      .fetchPaperData(AppService.paper_id ?? 0);

                                  // Generate PDF
                                  final pdf = await PDFGenerator(controller
                                              .paperData.value.history?[0] ??
                                          History())
                                      .generatePDF();
                                  final bytes = await pdf.save();
                                  Get.back();
                                  // Navigate to PDF preview screen using Get.to
                                  Get.to(
                                    Scaffold(
                                      appBar: AppBar(
                                        title: const Text('Preview PDF'),
                                        actions: [
                                          Obx(() => Switch(
                                                value: controller
                                                    .showAnswers.value,
                                                onChanged: (bool value) {
                                                  controller.showAnswers.value =
                                                      value;
                                                  // Regenerate the PDF with the new showAnswers value
                                                  controller
                                                      .generateAndShowPDF();
                                                },
                                              )),
                                        ],
                                      ),
                                      body: Obx(() => SfPdfViewer.memory(
                                            controller.pdfBytes.value,
                                          )),
                                    ),
                                  );
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
                                          color: Colors
                                              .white, // Set the text color
                                          fontSize: 16.0,
                                          fontWeight: FontWeight
                                              .w600 // Set the font size
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox())
                    ],
                  ),
          ),
        ));
  }
}
