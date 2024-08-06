import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/repository/paper_repository.dart';

class CreateAssignmentControlller extends GetxController {
  Rx<int> activeStep = 0.obs;
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
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);
    boardModel = await BookRepository().getBoards();
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
    //   "division": divisionController.text,
    var map = {
      "school_name": schoolNameController.text,
      "std": selectedStandard.value,
      "timing": formattedTime,
      "date": formattedDate,
      "day": DateFormat('EEEE').format(dateSelected.value),
      "address": schoolAddressController.text,
      "board": selectedBoard.value?.name.toString(),
      "subject": 'test',
      "uid": 12,
      "division": "djk",
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
