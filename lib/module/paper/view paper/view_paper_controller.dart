import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nexus_app/models/paper_history.dart';
import 'package:nexus_app/module/paper/create%20paper/pdf%20generate/pdf_generator.dart';
import 'package:nexus_app/repository/paper_repository.dart';

class ViewPaperoller extends GetxController {
  PaperHistoryModel? paperHistoryModel;
  var isLoading = false.obs;

  var paperData = History().obs;
  var showAnswers = false.obs;
  var pdfBytes = Rx<Uint8List>(Uint8List(0));

  Future<void> generateAndShowPDF() async {
    final pdf = await PDFGenerator(
      paperData.value ?? History(),
      showAnswers: showAnswers.value, // Pass the switch state
    ).generatePDF();
    pdfBytes.value = await pdf.save();
  }

  // Call this method to generate the initial PDF
  void generateInitialPDF() {
    generateAndShowPDF();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchPaperHistory();
    super.onInit();
  }

  void fetchPaperHistory() async {
    isLoading(true);
    paperHistoryModel = await PaperRepository().getPaperHistory();
    isLoading(false);
  }

  void fetchPaperData(int paperId) async {
    try {
      var data = paperHistoryModel?.history?.firstWhere(
          (element) => element.id == paperId,
          orElse: () => History()); // Fetch a single History or null
      paperData(data); // Assign History to paperData
    } catch (e) {
      print('Failed to load paper: $e');
    } finally {}
  }

  List<int> extractQuestionIds(Questions? questions) {
    List<int> questionIds = [];

    if (questions != null) {
      // Check and extract IDs from MCQ questions
      if (questions.mcq != null && questions.mcq!.questions != null) {
        questionIds
            .addAll(questions.mcq!.questions!.map((q) => q.id!).toList());
      }

      // Check and extract IDs from Short questions
      if (questions.short != null && questions.short!.questions != null) {
        questionIds
            .addAll(questions.short!.questions!.map((q) => q.id!).toList());
      }

      // Check and extract IDs from Long questions
      if (questions.long != null && questions.long!.questions != null) {
        questionIds
            .addAll(questions.long!.questions!.map((q) => q.id!).toList());
      }

      // Check and extract IDs from OneTwo questions
      if (questions.onetwo != null && questions.onetwo!.questions != null) {
        questionIds
            .addAll(questions.onetwo!.questions!.map((q) => q.id!).toList());
      }

      // Check and extract IDs from Blanks questions
      if (questions.blanks != null && questions.blanks!.questions != null) {
        questionIds
            .addAll(questions.blanks!.questions!.map((q) => q.id!).toList());
      }
    }

    return questionIds;
  }
}
