import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/module/paper/create%20paper/pdf%20generate/pdf_generator.dart';
import 'package:nexus_app/module/paper/view%20paper/edit%20paper/details/edit_paper_details.dart';
import 'package:nexus_app/module/paper/view%20paper/edit%20paper/details/edit_paper_details_controller.dart';
import 'package:nexus_app/module/paper/view%20paper/view_paper_controller.dart';
import 'package:nexus_app/services/auth_service.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPaperScreen extends StatelessWidget {
  ViewPaperScreen({super.key});
  var controller = Get.put(ViewPaperoller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => controller.isLoading.value == false
              ? Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey, width: 1.8),
                        color: Colors.white,
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 10.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller
                                      .paperHistoryModel?.history?.length ??
                                  1, // Add an item count
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.grey[100],
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ContainerWidget(
                                            text: 'Date:- ',
                                            text2: controller.paperHistoryModel
                                                    ?.history?[index].date ??
                                                '',
                                          ),
                                          const Spacer(),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Style.primary),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      Get.dialog(
                                                        AlertDialog(
                                                          title: Center(
                                                            child: Text(
                                                              "Hold tight!",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          content: SizedBox(
                                                              height: 150,
                                                              child: Lottie.asset(
                                                                  'assets/waiting.json')),
                                                          actions: [
                                                            Text(
                                                              "Nexus is crafting your PDF magic. Please wait...",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                        barrierDismissible:
                                                            false, // Prevent dismissing by tapping outside
                                                      );
                                                      await AppService.storage
                                                          .write(
                                                              'paper_id',
                                                              controller
                                                                  .paperHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .id);

                                                      controller.fetchPaperData(
                                                          AppService.paper_id ??
                                                              0);
                                                      final pdf =
                                                          await PDFGenerator(
                                                                  controller
                                                                      .paperData
                                                                      .value)
                                                              .generatePDF();
                                                      final bytes =
                                                          await pdf.save();
                                                      Get.back();
                                                      // Navigate to PDF preview screen using Get.to
                                                      Get.to(
                                                        Scaffold(
                                                          appBar: AppBar(
                                                            title: const Text(
                                                                'Preview PDF'),
                                                            actions: [
                                                              Obx(() => Switch(
                                                                    value: controller
                                                                        .showAnswers
                                                                        .value,
                                                                    onChanged: (bool
                                                                        value) {
                                                                      controller
                                                                          .showAnswers
                                                                          .value = value;
                                                                      // Regenerate the PDF with the new showAnswers value
                                                                      controller
                                                                          .generateAndShowPDF();
                                                                    },
                                                                  )),
                                                            ],
                                                          ),
                                                          body: Obx(() =>
                                                              SfPdfViewer
                                                                  .memory(
                                                                controller
                                                                    .pdfBytes
                                                                    .value,
                                                              )),
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                        Icons.remove_red_eye)),
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Style.primary),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      await AppService.storage
                                                          .write(
                                                              'paper_id',
                                                              controller
                                                                  .paperHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .id);
                                                      print(
                                                          'marks${controller.paperHistoryModel?.history?[index].questions?.mcq?.marks}');
                                                      Get.delete<
                                                          EditPaperDetailsController>();
                                                      Get.to(
                                                          binding:
                                                              BindingsBuilder(
                                                                  () {
                                                        Get.put(
                                                            EditPaperDetailsController());
                                                      }),
                                                          preventDuplicates:
                                                              false,
                                                          EditPaperDetailsScreen(),
                                                          arguments: {
                                                            'mcq': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .questions
                                                                ?.mcq
                                                                ?.marks,
                                                            'short': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .questions
                                                                ?.short
                                                                ?.marks,
                                                            'long': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .questions
                                                                ?.long
                                                                ?.marks,
                                                            'one_two': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .questions
                                                                ?.onetwo
                                                                ?.marks,
                                                            'blanks': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .questions
                                                                ?.blanks
                                                                ?.marks,
                                                            'selectedQuestion':
                                                                controller.extractQuestionIds(controller
                                                                    .paperHistoryModel
                                                                    ?.history?[
                                                                        index]
                                                                    .questions),
                                                            'schoolName': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .schoolName,
                                                            'schoolAddress':
                                                                controller
                                                                    .paperHistoryModel
                                                                    ?.history?[
                                                                        index]
                                                                    .address,
                                                            'standard': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .std
                                                                .toString(),
                                                            'timing': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .timing,
                                                            'schoolLogoUrl':
                                                                controller
                                                                    .paperHistoryModel
                                                                    ?.history?[
                                                                        index]
                                                                    .logo,
                                                            'date': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .date,
                                                            'division': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .division,
                                                            'board': controller
                                                                .paperHistoryModel
                                                                ?.history?[
                                                                    index]
                                                                .board,
                                                          });
                                                    },
                                                    child:
                                                        const Icon(Icons.edit)),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                      .paperHistoryModel
                                                      ?.history?[index]
                                                      .logo ??
                                                  '',
                                              placeholder: (context, url) =>
                                                  AnimatedShimmer(
                                                width: 80,
                                                height: 80,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                        .paperHistoryModel
                                                        ?.history?[index]
                                                        .schoolName ??
                                                    '',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                controller
                                                        .paperHistoryModel
                                                        ?.history?[index]
                                                        .address ??
                                                    '',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ContainerWidget(
                                              text: 'Std:- ',
                                              text2: controller
                                                      .paperHistoryModel
                                                      ?.history?[index]
                                                      .std
                                                      .toString() ??
                                                  ''),
                                          ContainerWidget(
                                            text: 'Subject:- ',
                                            text2: controller.paperHistoryModel
                                                    ?.history?[index].subject ??
                                                '',
                                          ),
                                          ContainerWidget(
                                            text: 'Timing:- ',
                                            text2: controller.paperHistoryModel
                                                    ?.history?[index].timing ??
                                                '',
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ));
  }
}

class ContainerWidget extends StatelessWidget {
  ContainerWidget({super.key, this.color, this.text, this.text2});
  Color? color;
  String? text;
  String? text2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color ?? Style.bg_color),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                text ?? 'Date:- ',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              Text(
                text2 ?? '22-23-00',
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
