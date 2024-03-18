import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/boards_mode.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/repository/book_repository.dart';

class SignUpController extends GetxController {
  var selectedStandard = '1'.obs;
  SubjectModel? subjectModel;
  var selectedSubject = Rx<Subjects?>(null);
  BoardModel? boardModel;
  RxBool isLoading = false.obs;
  RxInt? currentIndex;
  var name = TextEditingController();
  var email = TextEditingController();
  var user_type = TextEditingController();
  var std = TextEditingController();
  var school = TextEditingController();
  var password = TextEditingController();
  var number = TextEditingController();
  var subject = TextEditingController();
  var otp = TextEditingController();
  late TabController _tabController;

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
    subjectModel = await BookRepository().getSubject();
    boardModel = await BookRepository().getBoards();
    print('${boardModel?.boards?.length ?? '!!!!!!!'}##########');
  }
}
