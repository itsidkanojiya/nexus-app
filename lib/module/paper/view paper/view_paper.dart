import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_app/module/paper/create%20paper/pdf%20generate/pdf_generator.dart';
import 'package:nexus_app/module/paper/view%20paper/view_paper_controller.dart';
import 'package:nexus_app/services/app_service.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPaperScreen extends StatefulWidget {
  const ViewPaperScreen({super.key});

  @override
  State<ViewPaperScreen> createState() => _ViewPaperScreenState();
}

class _ViewPaperScreenState extends State<ViewPaperScreen> {
  var controller = Get.put(ViewPaperoller());

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
                        'Paper History',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
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
                                itemCount: controller
                                        .paperHistoryModel?.history?.length ??
                                    1,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Style.card,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ContainerWidget(
                                                text: 'Date:- ',
                                                text2: controller
                                                        .paperHistoryModel
                                                        ?.history?[index]
                                                        .date ??
                                                    '',
                                              ),
                                              const Spacer(),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Style.primary2,
                                                ),
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
                                                      controller
                                                              .pdfBytes.value =
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
                                                                            height:
                                                                                80,
                                                                            child: Center(
                                                                                child: Text(
                                                                              'Paper',
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
                                                                  Colors.black,
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
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width, // Full width of the screen
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
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
                                                    child: const Icon(
                                                        Icons.remove_red_eye),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Style.primary,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      // Your onTap logic here
                                                    },
                                                    child:
                                                        const Icon(Icons.edit),
                                                  ),
                                                ),
                                              ),
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
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                              .paperHistoryModel
                                                              ?.history?[index]
                                                              .schoolName ??
                                                          '',
                                                      style: Style.tableTitle,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      controller
                                                              .paperHistoryModel
                                                              ?.history?[index]
                                                              .address ??
                                                          '',
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        fontSize: 14,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
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
                                                    '',
                                              ),
                                              ContainerWidget(
                                                text: 'Subject:- ',
                                                text2: controller
                                                        .paperHistoryModel
                                                        ?.history?[index]
                                                        .subject ??
                                                    '',
                                              ),
                                              ContainerWidget(
                                                text: 'Timing:- ',
                                                text2: controller
                                                        .paperHistoryModel
                                                        ?.history?[index]
                                                        .timing ??
                                                    '',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
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
                style: Style.fillStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
