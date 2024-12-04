import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nexus_app/models/paper_history.dart';
import 'package:nexus_app/models/question_model.dart';
import 'package:nexus_app/repository/paper_repository.dart';
import 'package:nexus_app/services/app_service.dart';

class AddQuestionController extends GetxController {
  var questions = <QuestionModel>[].obs;
  RxBool isLoading = false.obs;
  var questionTypeMarks = <String, int>{}.obs;
  var pdfBytes = Rx<Uint8List>(Uint8List(0));
  var paperData =
      HistoryModel().obs; // Use PaperHistoryModel instead of History

  final allQuestions = <QuestionModel>[];
  var selectedQuestionType = 'All'.obs;
  var questionTypes = [
    'All',
    'MCQ',
    'Fill in the blanks',
    'True & false',
    'One two line questions',
    'Short question',
    'Long question'
  ];

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);
    questions.value = await PaperRepository().getQuestions();
    isLoading(false);
    allQuestions.addAll(questions.value);
    initializeSelections();
  }

  var questionSelection = <QuestionModel, bool>{}.obs;
  var answerVisibility = <QuestionModel, bool>{}.obs;

  final Map<String, String> typeDisplayNames = {
    'mcq': 'MCQ',
    'blanks': 'Fill in the blanks',
    'true_false': 'True & false',
    'one_two_line': 'One two line questions',
    'short': 'Short question',
    'long': 'Long question',
    'all': 'All',
  };

  void updateQuestions(List<QuestionModel> allQuestions) {
    this.allQuestions.addAll(allQuestions);
    questions.value = allQuestions;
    initializeSelections();
  }

  void initializeSelections() {
    for (var question in allQuestions) {
      questionSelection[question] = false;
      answerVisibility[question] = false;
    }
  }

  void setQuestionTypeMarks(String type, int marks) {
    // Reverse lookup the key from the display name
    String? questionTypeKey = typeDisplayNames.keys
        .firstWhere((k) => typeDisplayNames[k] == type, orElse: () => '');
    questionTypeMarks[questionTypeKey] = marks;
  }

  void changeQuestionType(String newType) {
    selectedQuestionType.value = newType;
    switch (newType) {
      case 'All':
        questions.value = allQuestions.toList();
      case 'MCQ':
        questions.value = allQuestions.where((q) => q.type == 'mcq').toList();
        break;
      case 'Fill in the blanks':
        questions.value =
            allQuestions.where((q) => q.type == 'blanks').toList();
        break;
      case 'True & false':
        questions.value =
            allQuestions.where((q) => q.type == 'true_false').toList();
        break;
      case 'One two line questions':
        questions.value =
            allQuestions.where((q) => q.type == 'one_two_line').toList();
        break;
      case 'Short question':
        questions.value = allQuestions.where((q) => q.type == 'short').toList();
        break;
      case 'Long question':
        questions.value = allQuestions.where((q) => q.type == 'long').toList();
        break;
      default:
        questions.value = allQuestions;
        break;
    }
  }

  void toggleQuestionSelection(QuestionModel question, bool value) {
    questionSelection[question] = value;
  }

  void toggleAnswerVisibility(QuestionModel question, bool value) {
    answerVisibility[question] = value;
  }

  int getSelectedQuestionCount() {
    return questionSelection.values.where((selected) => selected).length;
  }

  Map<String, int> getSelectedQuestionTypeCount() {
    Map<String, int> typeCount = {
      'mcq': 0,
      'blanks': 0,
      'true_false': 0,
      'one_two_line': 0,
      'short': 0,
      'long': 0,
    };
    for (var question in questionSelection.keys) {
      if (questionSelection[question] == true) {
        String type = question.type ?? '';
        if (typeCount.containsKey(type)) {
          typeCount[type] = (typeCount[type] ?? 0) + 1;
        }
      }
    }
    return typeCount;
  }

  Map<String, String> getDisplayTypeCount() {
    Map<String, int> typeCount = getSelectedQuestionTypeCount();
    Map<String, String> displayCount = {};
    typeCount.forEach((key, value) {
      if (typeDisplayNames.containsKey(key) && value > 0) {
        displayCount[typeDisplayNames[key]!] = value.toString();
      }
    });
    return displayCount;
  }

  Map<String, dynamic> generateSelectedQuestionsJson() {
    Map<String, dynamic> selectedQuestions = {
      "questions": [],
      "id": AppService.paper_id.toString(),
    };

    Map<String, List<int>> groupedQuestions = {};

    for (var question in questionSelection.keys) {
      if (questionSelection[question] == true) {
        String type = question.type ?? 'unknown';
        if (!groupedQuestions.containsKey(type)) {
          groupedQuestions[type] = [];
        }
        groupedQuestions[type]!
            .add(question.id ?? 0); // Assuming question has an 'id' field
      }
    }

    groupedQuestions.forEach((type, ids) {
      selectedQuestions["questions"].add({
        type: {
          "question": ids,
          "marks": questionTypeMarks[type] ?? 0, // Get the marks for the type
        }
      });
    });

    return selectedQuestions;
  }

  Future<bool> addQuestions() async {
    return await PaperRepository().addQuestion(generateSelectedQuestionsJson());
  }

  void fetchPaperData(int paperId) async {
    try {
      paperData.value = await PaperRepository().getPaper(paperId) ??
          HistoryModel(); // Fetch PaperHistoryModel
      print('${paperData.value.history?[0].address}');
    } catch (e) {
      print('Failed to load paper: $e');
    }
  }

  Future<void> createPdf(HistoryModel historyModel, bool showAnswers) async {
    try {
      // Create header details
      History history = historyModel.history!.first;

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
