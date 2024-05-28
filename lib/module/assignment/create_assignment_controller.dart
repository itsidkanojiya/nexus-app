import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexus_app/models/boards_mode.dart';
import 'package:nexus_app/repository/book_repository.dart';

class CreateAssignmentControlller extends GetxController {
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController schoolAddressController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController paperTimingController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController divisionController = TextEditingController();

  var selectedBoard = Rx<Board?>(null);
  Rx<DateTime> dateSelected = DateTime.now().obs;
  Rx<TimeOfDay> timeOfDay = const TimeOfDay(hour: 0, minute: 00).obs;
  BoardModel? boardModel;
  RxBool isLoading = false.obs;
  Rxn<XFile> aadharImage = Rxn<XFile>(null);
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

  String timeOfDayToString(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void fetchData() async {
    isLoading(true);
    boardModel = await BookRepository().getBoards();
    isLoading(false);
  }
}
