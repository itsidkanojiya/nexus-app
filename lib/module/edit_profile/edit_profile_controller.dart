import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/subject_model.dart';

class EditProfileController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController schoolcontroller = TextEditingController();
  var selectedStandard = '1'.obs;
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
}
