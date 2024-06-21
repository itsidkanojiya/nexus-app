import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/models/question_model.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/repository/paper_repository.dart';

class CreatePaperController extends GetxController {
  Rx<int> activeStep = 0.obs;
  var questions = <QuestionModel>[];
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController schoolAddressController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  var selectedBoard = Rx<Board?>(null);
  Rx<DateTime> dateSelected = DateTime.now().obs;
  Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 0, minute: 00).obs;
  BoardModel? boardModel;
  RxBool isLoading = false.obs;
  RxBool isNameEmpty = false.obs;
  RxBool isAddEmpty = false.obs;
  RxBool isBoardEmpty = false.obs;
  Rxn<XFile> schoolLogo = Rxn<XFile>(null);

  var selectedStandard = '1'.obs;
  var selectedType = 'MCQ'.obs;
  @override
  final List<String> standardLevels = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  final List<String> questionType = [
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

  String timeOfDayToString(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void fetchData() async {
    isLoading(true);
    boardModel = await BookRepository().getBoards();
    questions = await PaperRepository().getQuestions();
    isLoading(false);
  }

  Future<bool> addPaperDetails(BuildContext context) async {
    final timeFormat = DateFormat('h:mm'); // For example, 3:00
    final dateFormat = DateFormat('yyyy-MM-dd'); // For example, 2024-05-31
    DateTime convertTimeOfDayToDateTime(TimeOfDay time) {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, time.hour, time.minute);
    }

    // Format the timing and date
    String formattedTime =
        timeFormat.format(convertTimeOfDayToDateTime(selectedTime.value));
    String formattedDate = dateFormat.format(dateSelected.value);
    var map = {
      "school_name": schoolNameController.text,
      "std": selectedStandard.value,
      "timing": formattedTime,
      "date": formattedDate,
      "division": divisionController.text,
      "day": DateFormat('EEEE').format(dateSelected.value),
      "address": schoolAddressController.text,
      "board": selectedBoard.value?.name.toString(),
      "subject": 'test',
      "uid": 12,
      'division': '1'
    };
    print(map);
    return await PaperRepository().addPaperDetails(map, schoolLogo.value!.path);
  }

  ///Second Screen Controller
  var selectedQuestionType = 'MCQ'.obs;
  var searchQuery = ''.obs;
  var marks = 0.obs;

  final List<String> questionTypes = [
    'MCQ',
    'Short',
    'Long',
    'One Two Liner',
    'True False'
  ];

  void setQuestionType(String type) {
    selectedQuestionType.value = type;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setMarks(int value) {
    marks.value = value;
  }
}
