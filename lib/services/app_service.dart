import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/models/user_model.dart';

class AppService extends GetxService {
  static Rx<UserModel?> userModel = Rx<UserModel?>(null);
  static RxInt indexValue = 0.obs;
  static RxInt subTeacherIndex = 0.obs;
  static RxInt analysisIndex = 0.obs;
  static RxInt subQuetionIndex = 0.obs;
  static RxString userType = 'student'.obs;
  static final storage = GetStorage();

  // Get the token directly as it is stored
  static String? get token => storage.read('token');
  static int? get id => storage.read('id');
  static int? get paper_id => storage.read('paper_id');
  static int? get assignment_id => storage.read('assignment_id');

  String timeOfDayToString(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  TimeOfDay stringToTimeOfDay(String time) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(time));
  }

  DateTime stringToDate(String dateString) {
    try {
      // Adjust the format according to your date string format
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.parse(dateString);
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now(); // Return current date if parsing fails
    }
  }
}
