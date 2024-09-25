import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/module/assignment/create%20assignment/pdf%20generate/assignment_pdf_generator.dart';
import 'package:nexus_app/module/assignment/view%20assignment/edit%20assignment/details/edit_assignment_details.dart';
import 'package:nexus_app/module/assignment/view%20assignment/edit%20assignment/details/edit_assignment_details_controller.dart';
import 'package:nexus_app/module/assignment/view%20assignment/view_assignment_controller.dart';
import 'package:nexus_app/services/app_service.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewAssignmentScreen extends StatefulWidget {
  const ViewAssignmentScreen({super.key});

  @override
  State<ViewAssignmentScreen> createState() => _ViewAssignmentScreenState();
}

class _ViewAssignmentScreenState extends State<ViewAssignmentScreen> {
  var controller = Get.put(ViewAssignmentController());
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Style.bg_color,
          appBar: AppBar(
            toolbarHeight: isSearch ? 150 : 80,
            leading: const SizedBox(),
            flexibleSpace: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.to(() => const ProfilePage());
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 0, top: 2),
                    //     child: CircleAvatar(
                    //       radius: 22,
                    //       backgroundImage: const NetworkImage(
                    //         'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                    //       ),
                    //       backgroundColor: Colors.grey[300],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 80,
                      child: Center(
                          child: Text(
                        'Worksheet History',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                    // SizedBox(
                    //   child: (isSearch == false)
                    //       ? IconButton(
                    //           padding: const EdgeInsets.all(10),
                    //           style: ButtonStyle(
                    //             backgroundColor:
                    //                 MaterialStateProperty.all(Style.primary),
                    //           ),
                    //           icon: const Icon(
                    //             Icons.search,
                    //             color: Style.secondary,
                    //           ),
                    //           onPressed: () {
                    //             setState(() {
                    //               isSearch = true;
                    //             });
                    //           },
                    //         )
                    //       : IconButton(
                    //           icon: const Icon(Icons.close),
                    //           style: ButtonStyle(
                    //             backgroundColor:
                    //                 MaterialStateProperty.all(Colors.white),
                    //           ),
                    //           onPressed: () {
                    //             setState(() {
                    //               isSearch = false;
                    //             });
                    //           },
                    //         ),
                    // ),
                  ],
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                (isSearch == true)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ]),
            ]),
            elevation: 9.0,
            shadowColor: Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            backgroundColor: Style.secondary,
          ),
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
                                itemCount: controller.assignmentHistoryModel
                                        ?.history?.length ??
                                    1, // Add an item count
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Style.card,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ContainerWidget(
                                              text: 'Date:- ',
                                              text2: controller
                                                      .assignmentHistoryModel
                                                      ?.history?[index]
                                                      .date ??
                                                  '',
                                            ),
                                            const Spacer(),
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Style.primary2),
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
                                                                style: Style
                                                                    .tableTitle,
                                                              ),
                                                            ),
                                                            content: SizedBox(
                                                                height: 150,
                                                                child: Lottie.asset(
                                                                    'assets/waiting.json')),
                                                            actions: [
                                                              Text(
                                                                "Nexus is crafting your PDF magic. Please wait...",
                                                                style: Style
                                                                    .tableTitle,
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
                                                                    .assignmentHistoryModel
                                                                    ?.history?[
                                                                        index]
                                                                    .id);

                                                        controller.fetchPaperData(
                                                            AppService
                                                                    .paper_id ??
                                                                0);
                                                        final pdf =
                                                            await AssignmentPDFGenerator(
                                                                    controller
                                                                        .paperData
                                                                        .value)
                                                                .generatePDF();
                                                        controller.pdfBytes
                                                                .value =
                                                            await pdf.save();
                                                        Get.back();
                                                        // Navigate to PDF preview screen using Get.to
                                                        Get.to(
                                                          SafeArea(
                                                            child: Scaffold(
                                                              appBar: AppBar(
                                                                toolbarHeight:
                                                                    isSearch
                                                                        ? 150
                                                                        : 80,
                                                                leading:
                                                                    const SizedBox(),
                                                                flexibleSpace:
                                                                    Column(
                                                                        children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            // GestureDetector(
                                                                            //   onTap: () {
                                                                            //     Get.to(() => const ProfilePage());
                                                                            //   },
                                                                            //   child: Padding(
                                                                            //     padding: const EdgeInsets.only(left: 0, top: 2),
                                                                            //     child: CircleAvatar(
                                                                            //       radius: 22,
                                                                            //       backgroundImage: const NetworkImage(
                                                                            //         'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                                                                            //       ),
                                                                            //       backgroundColor: Colors.grey[300],
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                            SizedBox(
                                                                              height: 80,
                                                                              child: Center(
                                                                                  child: Text(
                                                                                'Worksheet',
                                                                                style: GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.bold),
                                                                              )),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            (isSearch == true)
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(12.0),
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                          child: const TextField(
                                                                                            decoration: InputDecoration(
                                                                                              hintText: 'Search',
                                                                                              prefixIcon: Icon(Icons.search),
                                                                                              border: InputBorder.none,
                                                                                              contentPadding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Container(
                                                                                              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                                                                              width: MediaQuery.of(context).size.width * 0.28,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                : const SizedBox(),
                                                                          ]),
                                                                    ]),
                                                                elevation: 9.0,
                                                                shadowColor:
                                                                    Colors
                                                                        .black,
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .vertical(
                                                                    bottom: Radius
                                                                        .circular(
                                                                            20),
                                                                  ),
                                                                ),
                                                                backgroundColor:
                                                                    Style
                                                                        .secondary,
                                                              ),
                                                              body: Obx(() =>
                                                                  Stack(
                                                                      children: [
                                                                        SfPdfViewer
                                                                            .memory(
                                                                          controller
                                                                              .pdfBytes
                                                                              .value,
                                                                        ),
                                                                        Positioned(
                                                                          bottom:
                                                                              10,
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width, // Full width of the screen
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                ElevatedButton(
                                                                                  child: const Row(
                                                                                    children: [
                                                                                      Icon(Icons.download),
                                                                                      SizedBox(
                                                                                        width: 3,
                                                                                      ),
                                                                                      Text('Download')
                                                                                    ],
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    controller.downloadPDF();
                                                                                  },
                                                                                ),
                                                                                ElevatedButton(
                                                                                  child: const Row(
                                                                                    children: [
                                                                                      Icon(Icons.remove_red_eye_sharp),
                                                                                      SizedBox(
                                                                                        width: 3,
                                                                                      ),
                                                                                      Text('Show Answer')
                                                                                    ],
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    controller.showAnswers.value = !controller.showAnswers.value;
                                                                                    controller.generateAndShowPDF();
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ])),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: const Icon(Icons
                                                          .remove_red_eye)),
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                                    .assignmentHistoryModel
                                                                    ?.history?[
                                                                        index]
                                                                    .id);
                                                        print(
                                                            'marks${controller.assignmentHistoryModel?.history?[index].questions?.mcq?.marks}');
                                                        Get.delete<
                                                            EditAssignmentDetailsController>();
                                                        Get.to(
                                                            binding:
                                                                BindingsBuilder(
                                                                    () {
                                                          Get.put(
                                                              EditAssignmentDetailsController());
                                                        }),
                                                            preventDuplicates:
                                                                false,
                                                            EditAssignmentDetailsScreen(),
                                                            arguments: {
                                                              'mcq': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .questions
                                                                  ?.mcq
                                                                  ?.marks,
                                                              'short': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .questions
                                                                  ?.short
                                                                  ?.marks,
                                                              'long': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .questions
                                                                  ?.long
                                                                  ?.marks,
                                                              'one_two': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .questions
                                                                  ?.onetwo
                                                                  ?.marks,
                                                              'blanks': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .questions
                                                                  ?.blanks
                                                                  ?.marks,
                                                              'selectedQuestion':
                                                                  controller.extractQuestionIds(controller
                                                                      .assignmentHistoryModel
                                                                      ?.history?[
                                                                          index]
                                                                      .questions),
                                                              'schoolName': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .schoolName,
                                                              'schoolAddress':
                                                                  controller
                                                                      .assignmentHistoryModel
                                                                      ?.history?[
                                                                          index]
                                                                      .address,
                                                              'standard': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .std
                                                                  .toString(),
                                                              'timing': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .timing,
                                                              'schoolLogoUrl':
                                                                  controller
                                                                      .assignmentHistoryModel
                                                                      ?.history?[
                                                                          index]
                                                                      .logo,
                                                              'date': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .date,
                                                              'division': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .division,
                                                              'board': controller
                                                                  .assignmentHistoryModel
                                                                  ?.history?[
                                                                      index]
                                                                  .board,
                                                            });
                                                      },
                                                      child: const Icon(
                                                          Icons.edit)),
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
                                                        .assignmentHistoryModel
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
                                                          .assignmentHistoryModel
                                                          ?.history?[index]
                                                          .schoolName ??
                                                      '',
                                                  style: Style.tableTitle,
                                                ),
                                                Text(
                                                  controller
                                                          .assignmentHistoryModel
                                                          ?.history?[index]
                                                          .address ??
                                                      '',
                                                  style: GoogleFonts.aBeeZee(
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
                                                        .assignmentHistoryModel
                                                        ?.history?[index]
                                                        .std
                                                        .toString() ??
                                                    ''),
                                            ContainerWidget(
                                              text: 'Subject:- ',
                                              text2: controller
                                                      .assignmentHistoryModel
                                                      ?.history?[index]
                                                      .subject ??
                                                  '',
                                            ),
                                            ContainerWidget(
                                              text: 'Timing:- ',
                                              text2: controller
                                                      .assignmentHistoryModel
                                                      ?.history?[index]
                                                      .timing ??
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
          )),
    );
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
            color: color ?? Style.background),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                text ?? 'Date:- ',
                style: Style.tableSubtitle,
              ),
              Text(
                text2 ?? '22-23-00',
                style: Style.labelStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
