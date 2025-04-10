import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/repository/auth_repository.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/services/app_service.dart';

class SignUpController extends GetxController {
  // Models
  SubjectModel? subjectModel;
  BoardModel? boardModel;

  // Observables
  var selectedUserType = ''.obs; // "student" or "teacher"
  var selectedSubject = Rx<Subjects?>(null);
  var selectedStandard = 1.obs; // Dynamic selection of standard (1–10)
  RxBool isLoading = false.obs;
  RxInt currentIndex = 0.obs;
  RxInt selectedBoards = 0.obs;
  var isResendButtonEnabled = false.obs;
  var isPasswordVisible = false.obs;

  // Controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final std = TextEditingController();
  final school = TextEditingController();
  final password = TextEditingController();
  final number = TextEditingController();
  final subject = TextEditingController();
  final otp = TextEditingController();

  // Form and UI Keys
  final formKey = GlobalKey<FormState>();
  final countdown = 90.obs;

  // Data
  final List<int> standardLevels =
      List.generate(10, (index) => index + 1); // Standards 1–10

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Fetch Subjects and Boards
  void fetchData() async {
    isLoading.value = true;
    try {
      subjectModel = await BookRepository().getSubject();

      boardModel = await BookRepository().getBoards();
    } finally {
      isLoading.value = false;
    }
  }

  // Countdown Logic for OTP Resend
  void startCountdown() {
    isResendButtonEnabled.value = false;
    countdown.value = 90;
    Future.delayed(const Duration(seconds: 1), updateCountdown);
  }

  void updateCountdown() {
    if (countdown.value > 0) {
      countdown.value--;
      Future.delayed(const Duration(seconds: 1), updateCountdown);
    } else {
      isResendButtonEnabled.value = true;
    }
  }

  void resendOtp() {
    if (isResendButtonEnabled.value) {
      startCountdown();
      AuthRepository().resendOtp();
    }
  }

  Future<bool> checkUser() async {
    var map = {
      "email": email.text,
      "number": number.text,
    };
    return await AuthRepository().checkUser(map);
  }

  Future<bool> signUp() async {
    var map = {
      "name": name.text,
      "email": email.text,
      "number": number.text,
      "user_type": selectedUserType.value,
      "std":
          selectedUserType.value == 'student' ? selectedStandard.value : null,
      "school": school.text,
      "password": password.text,
      if (selectedUserType.value == 'teacher')
        "subject": selectedSubject.value?.name,
    };
    return await AuthRepository().signup(map);
  }

  Future<bool> verifyOtp() async {
    var map = {
      "email": AppService.id,
      "otp": otp.text,
    };
    return await AuthRepository().verifyOtp(map);
  }

  // Toggle User Type
  void toggleUserType(String userType) {
    selectedUserType.value = userType;
    if (userType == 'teacher') {
      fetchData(); // Fetch subjects for teachers
    }
  }
}
