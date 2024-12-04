import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/repository/auth_repository.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/services/app_service.dart';

class SignUpController extends GetxController {
  SubjectModel? subjectModel;
  var selectedSubject = Rx<Subjects?>(null);
  BoardModel? boardModel;
  RxBool isLoading = false.obs;
  var currentIndex = 0.obs;
  var name = TextEditingController();
  var email = TextEditingController();
  var std = TextEditingController();
  var school = TextEditingController();
  var password = TextEditingController();
  var number = TextEditingController();
  var subject = TextEditingController();
  var otp = TextEditingController();
  RxInt selectedBoards = 0.obs;
  var isPasswordVisible = false.obs;
  final formKey = GlobalKey<FormState>();
  RxString selectedStandard = '1'.obs;

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
  var isResendButtonEnabled = false.obs;
  var countdown = 90.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

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

  void fetchData() async {
    isLoading.value = true;
    subjectModel = await BookRepository().getSubject();
    boardModel = await BookRepository().getBoards();
    isLoading.value = false;
  }

  Future<bool> validateStep(int stepIndex) async {
    switch (stepIndex) {
      case 0:
        //    return true;
        if (formKey.currentState!.validate()) {
          bool userExists = await checkUser();
          return userExists;
        } else {
          return false;
        }
      case 1:
        return true; // Additional validation for step 1 if needed
      case 2:
        bool signup = await signUp();
        return signup; // Additional validation for step 2 if needed
      case 3:
        bool verify = await verifyOtp();

        return verify;
      default:
        return false;
    }
  }

  Future<bool> checkUser() async {
    var map = {
      "email": email.text,
      "number": number.text,
    };
    return AuthRepository().checkUser(map);
  }

  Future<bool> signUp() async {
    // var map = {
    //   "name": 'sad',
    //   "email": 'ac+j272ad@gmail.com',
    //   "number": "98989789898",
    //   "user_type": AuthService.userType.value,
    //   "std": '2',
    //   "school": 'sada',
    //   "password": 'sdasd',
    //   "subject": user?.subject.toString(),
    // };
    // return AuthRepository().signup(map);
    var map = {
      "name": name.text,
      "email": email.text,
      "number": number.text,
      "user_type": AppService.userType.value,
      "std": selectedStandard.value,
      "school": school.text,
      "password": password.text,
      "subject": selectedSubject.value?.name,
    };
    var map2 = {
      "name": name.text,
      "email": email.text,
      "number": number.text,
      "user_type": AppService.userType.value,
      "std": selectedStandard.value,
      "school": school.text,
      "password": password.text,
    };
    print(map);
    if (AppService.userType.value == 'teacher') {
      return AuthRepository().signup(map);
    }
    return AuthRepository().signup(map2);
  }

  Future<bool> verifyOtp() async {
    var map = {
      "email": AppService.id,
      "otp": otp.text,
    };
    return AuthRepository().verifyOtp(map);
  }

  Future<void> nextStep() async {
    if (await validateStep(currentIndex.value)) {
      if (currentIndex.value < 3) {
        currentIndex.value++;
      }
      if (currentIndex.value == 3) {
        startCountdown();
      }
    }
  }
}
