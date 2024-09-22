import 'package:get/get.dart';
import 'package:nexus_app/models/paper_history.dart';
import 'package:nexus_app/models/question_model.dart';
import 'package:nexus_app/repository/assignment_repository.dart';
import 'package:nexus_app/repository/paper_repository.dart';
import 'package:nexus_app/services/app_service.dart';

class AddAssignmentQuestionController extends GetxController {
  var questions = <QuestionModel>[].obs;
  RxBool isLoading = false.obs;
  var questionTypeMarks = <String, int>{}.obs;
  var assignmentData =
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
      "id": AppService.assignment_id.toString(),
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

  void fetchAssignmentData(int assignmentId) async {
    try {
      assignmentData.value =
          await AssignmentRepository().getAssignment(assignmentId) ??
              HistoryModel(); // Fetch PaperHistoryModel
      print('${assignmentData.value.history?[0].date}');
    } catch (e) {
      print('Failed to load assignment: $e');
    }
  }
}
