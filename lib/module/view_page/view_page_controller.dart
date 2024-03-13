import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ViewBookPageController extends GetxController {
  RxString pageNumber = '0'.obs, totalpages = '-'.obs;
  RxBool isLoading = false.obs;

// @override
//   void onInit() {

//     super.onInit();
//   }

  Future<Uint8List> fetchPdf(String filePath) async {
    isLoading = true.obs;
    print(isLoading.value);
    http.Response response =
        await http.get(Uri.parse(filePath));
    Uint8List pdfData = response.bodyBytes;
    isLoading = false.obs;
    
    print(isLoading.value);
    return pdfData;
  }
}
