import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/module/profile/change_subject/change_subject_controller.dart';
import 'package:nexus_app/theme/style.dart';

class ChangeSubjectView extends StatelessWidget {
  final ChangeSubjectController controller = Get.put(ChangeSubjectController());

  ChangeSubjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Subject"),
        backgroundColor: Style.primary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SizedBox(
                height: 250, child: Lottie.asset('assets/bookloading.json')),
          );
        }

        final subjects = controller.subjectModel.value?.subjects ?? [];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Subject",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                value: controller.selectedSubjectId?.value == 0
                    ? null
                    : controller.selectedSubjectId?.value,
                hint: const Text("Choose a subject"),
                items: subjects.map((subject) {
                  return DropdownMenuItem<int>(
                    value: subject.id,
                    child: Text(subject.name ?? ''),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) controller.selectSubject(value);
                },
              ),
              const Spacer(),
              Obx(() {
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: controller.submitSubjectChange,
                        child: Container(
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
              const SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}
