import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/books_model.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/services/getStorage_services.dart';
import 'package:nexus_app/theme/loaderScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SolutionController extends GetxController {
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

  void getSolution(String subject, String std, String boardId) async {
    isBookLoading(true);
    bookmodel = await BookRepository().getSolution(subject, std, boardId);
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
        Loader().onError(msg: "File not found");
      }
    } catch (e) {
      Loader().onError(msg: "Failed to open file");
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

  Future<void> downloadPDF(
      BuildContext context, String url, String fileName) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Downloading...',
      progressType: ProgressType.valuable,
    );

    try {
      Dio dio = Dio();
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            double progress = (receivedBytes / totalBytes) * 100;
            downloadProgress[fileName] = progress;
            pd.update(value: progress.toInt()); // Update progress dialog value
          }
        },
      );

      pd.close(); // Close the dialog after download completes
      Loader().onSuccess(msg: "Download Complete");

      await openPDF(fileName); // Automatically open after download
    } catch (e) {
      pd.close(); // Close the dialog if error occurs
      Loader().onError(msg: "Failed to download file: $e");
    }
  }
}
