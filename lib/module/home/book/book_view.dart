import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/custome_widgets/custom_button_widget.dart';
import 'package:nexus_app/module/home/book/book_controller.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';

class BookView extends StatefulWidget {
  final String subject;
  final String std;
  final String board;

  const BookView({
    super.key,
    required this.board,
    required this.subject,
    required this.std,
  });

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  var controller = Get.isRegistered<BookController>()
      ? Get.find<BookController>()
      : Get.put(BookController());

  @override
  void initState() {
    controller.getBooks(widget.subject, widget.std);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Style.bg_color,
        appBar: AppBar(
          title: const Text('Books'),
        ),
        body: Obx(
          () => controller.isBookLoading.value
              ? Center(
                  child: SizedBox(
                    height: 250,
                    child: Lottie.asset('assets/bookloading.json'),
                  ),
                )
              : (controller.bookmodel?.books?.isNotEmpty ?? false)
                  ? ListView.builder(
                      itemCount: controller.bookmodel?.books?.length ?? 0,
                      itemBuilder: (context, index) {
                        var book = controller.bookmodel!.books![index];
                        String pdfUrl = book.pdfLink ?? '';
                        String fileName = 'book_${book.id}.pdf';

                        return Card(
                          color: Style.card,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 90,
                                      child: Image.network(
                                        controller.bookmodel?.books?[index]
                                                .coverLink ??
                                            '',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        book.chapterName ?? 'Unknown Chapter',
                                        style: Style.tableSubtitle,
                                      ),
                                      subtitle: Text(
                                        'Chapter: ${book.chapterNo}',
                                        style: Style.tableSubtitle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DownloadButton(
                                pdfUrl: pdfUrl,
                                fileName: fileName,
                                controller: controller,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 250,
                              child: Lottie.asset('assets/emptybook.json')),
                          Text(
                            'No books here yet!',
                            style: Style.tableSubtitle,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class DownloadButton extends StatelessWidget {
  final String pdfUrl;
  final String fileName;
  final BookController controller;

  const DownloadButton({
    super.key,
    required this.pdfUrl,
    required this.fileName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.downloadProgress.containsKey(pdfUrl) &&
          controller.downloadProgress[pdfUrl]! < 100) {
        // Display progress bar
        return const SizedBox();
        // return Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: LinearProgressIndicator(
        //     value: controller.downloadProgress[pdfUrl]! / 100,
        //   ),
        // );
      } else {
        return FutureBuilder<bool>(
          future: controller.isFileDownloaded(fileName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == true) {
              // If file is downloaded, show "Open PDF" and "Delete PDF" buttons
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Open PDF',
                        duration: const Duration(milliseconds: 600),
                        onTap: () async {
                          await controller.openPDF(fileName);
                          final directory =
                              await getApplicationDocumentsDirectory();
                          final filePath = '${directory.path}/$fileName';
                          Get.to(
                            SafeArea(
                              child: Scaffold(
                                appBar: AppBar(),
                                body: PdfViewer.file(filePath),
                              ),
                            ),
                          );
                        },
                        hight: 35,
                        startColor: Style.primary,
                        endColor: Style.primary,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        text: 'Delete PDF',
                        duration: const Duration(milliseconds: 600),
                        onTap: () async {
                          await controller.deletePDF(fileName);
                        },
                        hight: 35,
                        startColor: Colors.red,
                        endColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Show "Download PDF" button
              return CustomButton(
                text: 'Download PDF',
                duration: const Duration(milliseconds: 600),
                onTap: () async {
                  await controller.downloadPDF(context, pdfUrl, fileName);
                },
                hight: 35,
                startColor: Style.primary,
                endColor: Style.primary,
              );
            }
          },
        );
      }
    });
  }
}
