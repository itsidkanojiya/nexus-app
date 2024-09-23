import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/books_model.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/services/getStorage_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookController extends GetxController {
  RxString selected = 'GSEB'.obs;
  BookModel? bookmodel;
  SubjectModel? subjectmodel;
  RxBool isLoading = false.obs;
  RxBool isBookLoading = false.obs;
  var selectedBook = Rx<Books?>(null);
  RxMap<String, double> downloadProgress = <String, double>{}.obs;

  GetStorageServices? getStorageServices;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    getStorageServices = GetStorageServices();
    isLoading(true);

    subjectmodel = await BookRepository().getSubject();

    isLoading(false);
  }

  void getBooks(String subject) async {
    isBookLoading(true);
    bookmodel = await BookRepository().getBooks(subject);
    isBookLoading(false);
  }

  // Download progress tracking

  // Method to check if file is downloaded
  Future<bool> isFileDownloaded(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    return File(filePath).existsSync();
  }

  // Method to open a downloaded PDF file
  Future<void> openPDF(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      if (await File(filePath).exists()) {
        // await OpenFile.open(
        //     filePath); // Open the PDF using the default PDF viewer
      } else {
        Get.snackbar("Error", "File not found");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to open file");
    }
  }

  // Method to delete a downloaded PDF file
  Future<void> deletePDF(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    if (file.existsSync()) {
      await file.delete();
    }
  }

  // Method to download the PDF file

  Future<void> downloadPDF(String url, String fileName) async {
    try {
      // Create a Dio instance
      Dio dio = Dio();

      // Get the directory where we want to save the file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      // Download the file and track the download progress
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            // Update download progress in percentage
            downloadProgress[url] = (receivedBytes / totalBytes) * 100;
            //   update(); // To update the UI
          }
        },
      );

      // downloadProgress[url] = 100; // Download complete
      Get.snackbar(
          "Download Complete", "File has been downloaded to $filePath");
      Get.to(
        SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: SfPdfViewer.file(File(filePath)),
          ),
        ),
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to download file: $e");
    }
  }
}
