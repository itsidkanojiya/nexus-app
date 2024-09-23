import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/custome_widgets/custom_button_widget.dart';
import 'package:nexus_app/module/home/book/book_controller.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';

class BookView extends StatefulWidget {
  final String Subject;

  const BookView({super.key, required this.Subject});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  var controller = Get.isRegistered<BookController>()
      ? Get.find<BookController>()
      : Get.put(BookController());

  @override
  void initState() {
    controller.getBooks(widget.Subject);
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
        body: Obx(() {
          if (controller.isBookLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: controller.bookmodel?.books?.length ?? 0,
              itemBuilder: (context, index) {
                var book = controller.bookmodel!.books![index];
                String pdfUrl = book.pdfLink ?? '';
                String fileName = 'book_${book.id}.pdf';

                return Card(
                  color: Style.card,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(book.chapterName ?? 'Unknown Chapter'),
                        subtitle: Text('Chapter: ${book.chapterNo}'),
                      ),
                      Obx(() {
                        // Show download progress if downloading
                        if (controller.downloadProgress.containsKey(pdfUrl)) {
                          return LinearProgressIndicator(
                            value: controller.downloadProgress[pdfUrl]! / 100,
                          );
                        } else {
                          return FutureBuilder<bool>(
                            future: controller.isFileDownloaded(fileName),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.data == true) {
                                // If the file is downloaded, show "Open PDF" and "Delete" buttons
                                return Column(
                                  children: [
                                    CustomButton(
                                      text: 'Open PDF',
                                      onTap: () async {
                                        await controller.openPDF(fileName);
                                        final directory =
                                            await getApplicationDocumentsDirectory();
                                        final filePath =
                                            '${directory.path}/$fileName';
                                        Get.to(
                                          SafeArea(
                                            child: Scaffold(
                                              appBar: AppBar(),
                                              body: PdfViewer.asset(filePath),
                                            ),
                                          ),
                                        );
                                      },
                                      hight: 35,
                                      startColor: Style.primary,
                                      endColor: Style.primary,
                                    ),
                                    CustomButton(
                                      text: 'Delete PDF',
                                      onTap: () async {
                                        await controller.deletePDF(fileName);
                                        setState(
                                            () {}); // Refresh UI after deletion
                                      },
                                      hight: 35,
                                      startColor: Colors.red,
                                      endColor: Colors.red,
                                    ),
                                  ],
                                );
                              } else {
                                // If the file is not downloaded, show "Download PDF" button
                                return CustomButton(
                                  text: 'Download PDF',
                                  onTap: () async {
                                    await controller.downloadPDF(
                                        pdfUrl, fileName);
                                    setState(
                                        () {}); // Refresh UI once downloaded
                                  },
                                  hight: 35,
                                  startColor: Style.primary,
                                  endColor: Style.primary,
                                );
                              }
                            },
                          );
                        }
                      }),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
