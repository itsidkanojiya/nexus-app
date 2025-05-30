import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nexus_app/models/paper_history.dart';
import 'package:nexus_app/repository/paper_repository.dart';
import 'package:printing/printing.dart';

class ViewPaperoller extends GetxController {
  HistoryModel? paperHistoryModel;
  var isLoading = false.obs;

  var paperData = History().obs;
  var showAnswers = false.obs;
  var pdfBytes = Rx<Uint8List>(Uint8List(0));

  Future<void> generateAndShowPDF() async {
    isLoading(true);
    await createPdf(paperData.value, showAnswers.value);
    isLoading(false);
  }

  // Call this method to generate the initial PDF
  void generateInitialPDF() {
    generateAndShowPDF();
  }

  Future<void> downloadPDF() async {
    // Ensure the PDF is generated first
    if (pdfBytes.value.isNotEmpty) {
      try {
        // Use GetX or any other storage mechanism to download the file.
        final pdfName = "paper_${paperData.value.id}.pdf"; // Naming the PDF
        final result =
            await Printing.sharePdf(bytes: pdfBytes.value, filename: pdfName);

        // Handle download success/failure, if required.
        print("Failed to download PDF.");
      } catch (e) {
        print("Error downloading PDF: $e");
      }
    } else {
      print("No PDF to download. Generate it first.");
    }
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

  Future<void> createPdf(History history, bool showAnswers) async {
    try {
      // Create header details
      Map<String, dynamic> headerDetails = {
        "logo": history.logo ??
            "https://nexuspublication.com/logos/Nexus%20Logo%20png-01.png", // Replace with your logo
        "school_name": history.schoolName ?? "Example School",
        "address": history.address ?? "1234 School St, City, Country",
        "std": history.std.toString(),
        "day": history.day ?? "Monday",
        "subject": history.subject ?? "Mathematics",
        "date": history.date ?? "2024-10-17",
        "timing": history.timing ?? "10:00 AM - 12:00 PM",
      };

      // Create questions list dynamically
      Map<String, dynamic> questionsList = {};

      // List of question types we are handling
      List<String> questionTypes = [
        "mcq",
        "short",
        "long",
        "onetwo",
        "blanks",
        "true_false"
      ];

      for (String type in questionTypes) {
        var questions = history.questions?.toJson()[type]['questions'];

        if (questions != null && questions.isNotEmpty) {
          List<Map<String, dynamic>> formattedQuestions = [];

          questions.forEach((q) {
            Map<String, dynamic> formattedQuestion = {
              "question": q['question'],
              if (q['options'] != null) "options": q['options'], // For MCQs
              if (q['answer'] != null && showAnswers)
                "answer": q['answer'], // Show answer if the flag is true
              "marks": q['marks'] ?? 0
            };
            formattedQuestions.add(formattedQuestion);
          });

          // Add to questions list
          questionsList[type] = {
            "questions": formattedQuestions,
          };
        }
      }

      // Final transformed JSON
      Map<String, dynamic> transformedJson = {
        "headerDetails": headerDetails,
        "questionsList": questionsList,
        "showAnswers": showAnswers
      };
      print(transformedJson);
      pdfBytes.value = await PaperRepository().getPaperPdf(transformedJson);
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
