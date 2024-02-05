import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString selected = 'GSEB'.obs;

  void setSelected(String value) {
    selected.value = value;
  }

  List<String> dropdownValues = [
    'GSEB',
    'NCERT',
    'MSHB',
    // Add more options as needed
  ];
}
