import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/models/paper_history.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/repository/paper_repository.dart';
import 'package:nexus_app/repository/profile_repository.dart';
import 'package:nexus_app/services/app_service.dart';

class EditAssignmentDetailsController extends GetxController {
  Rx<int> activeStep = 0.obs;
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController schoolAddressController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  var selectedBoard = Rx<Board?>(null);
  List<int>? selectedQuestion;
  RxInt? mcqMark = 0.obs;
  RxInt? shortMark = 0.obs;
  RxInt? longMark = 0.obs;
  RxInt? truefalseMark = 0.obs;
  RxInt? blanksMark = 0.obs;
  RxInt? onetwoMark = 0.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  TextEditingController selectedTime = TextEditingController();
  BoardModel? boardModel;
  RxBool isLoading = false.obs;
  RxBool isNameEmpty = false.obs;
  RxBool isAddEmpty = false.obs;
  RxBool isBoardEmpty = false.obs;
  RxString? initialLogoUrl = RxString('');
  Rxn<XFile> schoolLogo = Rxn<XFile>(null);
  var paperData = HistoryModel().obs;
  var selectedStandard = '1'.obs;
  var selectedType = 'MCQ'.obs;

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
  void onReady() async {
    super.onReady();
    isLoading(true);
    clearForm();
    boardModel = await BookRepository().getBoards();
    final arguments = Get.arguments;
    if (arguments != null) {
      initializeData(arguments);
    }
    isLoading(false);
  }

  void initializeData(Map<String, dynamic> arguments) {
    initialLogoUrl?.value = arguments['schoolLogoUrl'];
    mcqMark?.value = arguments['mcq'];

    shortMark?.value = arguments['short'];
    longMark?.value = arguments['long'];
    //truefalseMark?.value = arguments['true_false'];
    blanksMark?.value = arguments['blanks'];
    onetwoMark?.value = arguments['one_two'];
    initialLogoUrl?.value = arguments['schoolLogoUrl'];
    selectedQuestion = arguments['selectedQuestion'];
    schoolNameController.text = arguments['schoolName'] ?? '';
    schoolAddressController.text = arguments['schoolAddress'] ?? '';
    selectedStandard.value = arguments['standard'] ?? '';
    selectedTime.text = arguments['timing'] ?? '';
    selectedDate.value = AppService().stringToDate(arguments['date'] ?? '');

    selectedBoard.value = boardModel?.boards?.firstWhere(
      (element) => element.name == arguments['board'],
      orElse: () => Board(),
    );
  }

  Future<bool> editAssignmentDetails(BuildContext context) async {
    final timeFormat = DateFormat('h:mm'); // For example, 3:00
    final dateFormat = DateFormat('yyyy-MM-dd'); // For example, 2024-05-31
    var user = await ProfileRepository().getUser();
    // Format the timing and date
    String formattedDate = dateFormat.format(selectedDate.value);
    if (schoolLogo.value?.path == null) {
      var map = {
        "school_name": schoolNameController.text,
        "std": selectedStandard.value,
        "timing": selectedTime.text,
        "date": formattedDate,
        "day": DateFormat('EEEE').format(selectedDate.value),
        "address": schoolAddressController.text,
        "board": selectedBoard.value?.name.toString(),
        "subject": user?.subject.toString(),
        "uid": AppService.id,
        "id": AppService.paper_id,
        'logo': initialLogoUrl?.value
      };
      return await PaperRepository().editPaperDetails(map, null);
    } else {
      var map = {
        "school_name": schoolNameController.text,
        "std": selectedStandard.value,
        "timing": selectedTime.text,
        "date": formattedDate,
        "day": DateFormat('EEEE').format(selectedDate.value),
        "address": schoolAddressController.text,
        "board": selectedBoard.value?.name.toString(),
        "subject": user?.subject.toString(),
        "uid": AppService.id,
        "id": AppService.paper_id,
      };
      return await PaperRepository()
          .editPaperDetails(map, schoolLogo.value?.path);
    }
    // Create the map with all the necessary fields

    // Print the map for debugging

    // Determine the path of the logo
  }

  void clearForm() {
    schoolNameController.clear();
    schoolAddressController.clear();
    selectedStandard.value = '';
  }
}
