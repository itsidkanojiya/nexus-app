import 'package:get/get.dart';
import 'package:nexus_app/models/question_model.dart';

class QuestionController extends GetxController {
  var questions = <QuestionModel>[].obs;
  var selectedQuestionType = 'MCQ'.obs;
  var questionTypes = [
    'MCQ',
    'Fill in the blanks',
    'True & false',
    'One two line questions',
    'Short question',
    'Long question'
  ];

  var questionSelection = <QuestionModel, bool>{}.obs;
  var answerVisibility = <QuestionModel, bool>{}.obs;
  final allQuestions = <QuestionModel>[];

  final Map<String, String> typeDisplayNames = {
    'mcq': 'MCQ',
    'blanks': 'Fill in the blanks',
    'true_false': 'True & false',
    'one_two_line': 'One two line questions',
    'short': 'Short question',
    'long': 'Long question',
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

  void changeQuestionType(String newType) {
    selectedQuestionType.value = newType;
    switch (newType) {
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
}
