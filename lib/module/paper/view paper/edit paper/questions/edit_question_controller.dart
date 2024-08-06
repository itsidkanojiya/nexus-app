import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nexus_app/models/paper_history.dart';
import 'package:nexus_app/models/question_model.dart';
import 'package:nexus_app/module/paper/create%20paper/pdf%20generate/pdf_generator.dart';
import 'package:nexus_app/repository/paper_repository.dart';
import 'package:nexus_app/services/auth_service.dart';

class EditQuestionController extends GetxController {
  var questions = <QuestionModel>[].obs;
  List<QuestionModel> selectedQuestion = [];
  RxBool isLoading = false.obs;
  var questionTypeMarks = <String, int>{}.obs;
  var paperData = PaperHistoryModel().obs;
  RxInt? mcqMark = 0.obs;
  RxInt? shortMark = 0.obs;
  RxInt? longMark = 0.obs;
  RxInt? truefalseMark = 0.obs;
  RxInt? blanksMark = 0.obs;
  RxInt? onetwoMark = 0.obs;
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
  var showAnswers = false.obs;
  var pdfBytes = Rx<Uint8List>(Uint8List(0));

  Future<void> generateAndShowPDF() async {
    final pdf = await PDFGenerator(
      paperData.value.history?[0] ?? History(),
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
    super.onInit();
    isLoading(true);
    fetchData();
  }

  void fetchData() async {
    try {
      // Start loading
      isLoading(true);

      // Fetch all questions
      questions.value = await PaperRepository().getQuestions();
      allQuestions.addAll(questions.value);

      // Process arguments if available
      final arguments = Get.arguments;
      if (arguments != null) {
        // Get the list of selected question IDs from arguments
        mcqMark?.value = arguments['mcq'];
        shortMark?.value = arguments['short'];
        longMark?.value = arguments['long'];
        //truefalseMark?.value = arguments['true_false'];
        blanksMark?.value = arguments['blanks'];
        onetwoMark?.value = arguments['one_two'];
        List<int> selectedQuestionIds = arguments['selectedQuestion'] ?? [];

        // Filter questions based on selected IDs
        selectedQuestion = allQuestions
            .where((q) => selectedQuestionIds.contains(q.id))
            .toList();

        setQuestionTypeMarks(
            typeDisplayNames['mcq'] ?? '', mcqMark?.value ?? 0);
        setQuestionTypeMarks(
            typeDisplayNames['short'] ?? '', shortMark?.value ?? 0);
        setQuestionTypeMarks(
            typeDisplayNames['long'] ?? '', longMark?.value ?? 0);
        setQuestionTypeMarks(
            typeDisplayNames['blanks'] ?? '', blanksMark?.value ?? 0);
        setQuestionTypeMarks(
            typeDisplayNames['onetwo'] ?? '', onetwoMark?.value ?? 0);
        for (var question in selectedQuestion) {
          toggleQuestionSelection(question, true);
          answerVisibility[question] = false;
        }
      }
    } finally {
      // Stop loading
      isLoading(false);
    }
  }

  var questionSelection = <QuestionModel, bool>{}.obs;
  var answerVisibility = <QuestionModel, bool>{}.obs;

  final Map<String, String> typeDisplayNames = {
    'mcq': 'MCQ',
    'blanks': 'Fill in the blanks',
    'true_false': 'True & false',
    'onetwo': 'One two line questions',
    'short': 'Short question',
    'long': 'Long question',
    'all': 'All',
  };

  void setQuestionTypeMarks(String type, int marks) {
    String? questionTypeKey = typeDisplayNames.keys
        .firstWhere((k) => typeDisplayNames[k] == type, orElse: () => '');
    questionTypeMarks[questionTypeKey] = marks;
  }

  void changeQuestionType(String newType) {
    selectedQuestionType.value = newType;
    switch (newType) {
      case 'All':
        questions.value = allQuestions.toList();
        break;
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
            allQuestions.where((q) => q.type == 'onetwo').toList();
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
      'onetwo': 0,
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
        groupedQuestions[type]!.add(question.id ?? 0);
      }
    }

    groupedQuestions.forEach((type, ids) {
      selectedQuestions["questions"].add({
        type: {
          "question": ids,
          "marks": questionTypeMarks[type] ?? 0,
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
      paperData.value = (await PaperRepository().getPaper(paperId))!;
    } catch (e) {
      print('Failed to load paper: $e');
    }
  }
}
