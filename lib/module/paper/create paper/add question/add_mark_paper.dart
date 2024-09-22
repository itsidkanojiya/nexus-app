import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'question_controller.dart';

class AddMarksPage extends StatelessWidget {
  var controller = Get.isRegistered<AddQuestionController>()
      ? Get.find<AddQuestionController>()
      : Get.put(AddQuestionController());

  AddMarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Marks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                final displayTypeCount = controller.getDisplayTypeCount();
                final selectedQuestionTypeCount =
                    controller.getSelectedQuestionTypeCount();

                return DataTable(
                  dataRowHeight: 80,
                  columns: const [
                    DataColumn(label: Text('Question\nType')),
                    DataColumn(label: Text('Selected\nQuestions')),
                    DataColumn(label: Text('Marks')),
                  ],
                  rows: displayTypeCount.entries.map((entry) {
                    final questionTypeKey =
                        controller.typeDisplayNames.keys.firstWhere(
                      (k) => controller.typeDisplayNames[k] == entry.key,
                      orElse: () => '',
                    );
                    final marks = questionTypeKey.isNotEmpty
                        ? controller.questionTypeMarks[questionTypeKey]
                                ?.toString() ??
                            ''
                        : '';

                    final TextEditingController marksController =
                        TextEditingController(text: marks);

                    return DataRow(
                      cells: [
                        DataCell(Text(entry.key,
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                        DataCell(Text(entry.value)),
                        DataCell(SizedBox(
                          width: 60,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: marksController,
                              decoration: InputDecoration(
                                hintText: 'Enter marks',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onEditingComplete: () {
                                final newMarks =
                                    int.tryParse(marksController.text) ?? 0;
                                controller.setQuestionTypeMarks(
                                    entry.key, newMarks);
                              },
                            ),
                          ),
                        )),
                      ],
                    );
                  }).toList()
                    ..add(
                      DataRow(
                        cells: [
                          const DataCell(Text('Total',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(
                            selectedQuestionTypeCount.values
                                .fold<int>(0, (prev, element) => prev + element)
                                .toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataCell(Text(
                            controller.questionTypeMarks.values
                                .fold<int>(0, (prev, element) => prev + element)
                                .toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
