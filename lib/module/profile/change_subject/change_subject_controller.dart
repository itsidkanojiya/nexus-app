import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/repository/profile_repository.dart';
import 'package:nexus_app/services/app_service.dart';
import 'package:nexus_app/theme/loaderScreen.dart';

class ChangeSubjectController extends GetxController {
  Rx<SubjectModel?> subjectModel = Rx<SubjectModel?>(null);
  RxInt? selectedSubjectId = RxInt(0);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }

  void fetchSubjects() async {
    isLoading(true);
    try {
      subjectModel.value = await BookRepository().getSubject();
    } catch (e) {
      Loader().onError(msg: "Failed to fetch subjects");
    }
    isLoading(false);
  }

  void selectSubject(int id) {
    selectedSubjectId?.value = id;
  }

  void submitSubjectChange() async {
    if (selectedSubjectId?.value == 0) {
      Loader().onError(msg: "Please select a subject");

      return;
    }

    isLoading(true);

    final success = await ProfileRepository().requestSubjectChange(
      newSubject: selectedSubjectId!.value.toString(),
    );

    if (success) {
      selectedSubjectId?.value = 0;
    }

    isLoading(false);
  }
}
