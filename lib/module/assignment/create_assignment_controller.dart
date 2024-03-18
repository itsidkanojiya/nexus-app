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
  DateTime? dateSelected;
  TimeOfDay timeOfDay = const TimeOfDay(hour: 1, minute: 10);
  BoardModel? boardModel;
  RxBool isLoading = false.obs;
  Rxn<XFile> aadharImage = Rxn<XFile>(null);
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
