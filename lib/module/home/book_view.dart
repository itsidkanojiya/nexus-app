// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_app/module/chatgpt/chatgpt_page.dart';
import 'package:nexus_app/module/home/home_controller.dart';
import 'package:nexus_app/module/paper/create_paper.dart';
import 'package:nexus_app/module/profile/profile_page.dart';
import 'package:nexus_app/module/view_page/view_book_page.dart';
import 'package:nexus_app/theme/style.dart';

class BookView extends StatefulWidget {
  BookView({super.key, required this.Subject});
  String Subject;
  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  var controller = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());
  bool isSearch = false;

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
          toolbarHeight: isSearch ? 150 : 80,
          leading: const SizedBox(),
          flexibleSpace: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ProfilePage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 2),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                        ),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Image.asset('assets/logo.png'),
                  ),
                  SizedBox(
                    child: (isSearch == false)
                        ? IconButton(
                            padding: const EdgeInsets.all(10),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Style.primary),
                            ),
                            icon: const Icon(
                              Icons.search,
                              color: Style.secondary,
                            ),
                            onPressed: () {
                              setState(() {
                                isSearch = true;
                              });
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Style.bg_color),
                            ),
                            onPressed: () {
                              setState(() {
                                isSearch = false;
                              });
                            },
                          ),
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
                              color: Style.bg_color,
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
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                width: MediaQuery.of(context).size.width * 0.28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  // color: Colors.white,
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
        body: Obx(() => (controller.isBookLoading == true)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                    child: GridView.builder(
                      itemCount: controller.bookmodel?.books?.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 330,
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 20.0, // Spacing between columns
                        mainAxisSpacing: 15.0, // Spacing between rows
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(ViewBookPage(
                                docPath: controller
                                        .bookmodel?.books?[index].pdfLink ??
                                    '',
                                docName: controller
                                        .bookmodel?.books?[index].chapterName ??
                                    ''));
                          },
                          child: Card(
                            elevation: 5,
                            child: SizedBox(
                                child: Stack(
                              children: [
                                Positioned(
                                    child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: SizedBox(
                                        height: 230,
                                        child: Image.network(
                                          controller.bookmodel?.books?[index]
                                                  .coverLink ??
                                              '',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          controller.bookmodel?.books?[index]
                                                  .chapterName ??
                                              '',
                                          style: Style.tableSubtitle,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      height: 23,
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0)),
                                          color: Style.primary),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            "Chapter No:- ${controller.bookmodel?.books?[index].chapterNo}" ??
                                                '',
                                            style: GoogleFonts.nunito(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            )),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 15),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const CreatePaper());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: const Color(0xff74AA9C),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_to_photos_rounded,
                                size: 24,
                                color: Style.secondary,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Create Paper',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.to(() => const ChatPage());
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff74AA9C),
            ),
            child: const Icon(
              Icons.wechat_rounded,
              size: 30,
              color: Style.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String coverImage;

  Book({
    required this.title,
    required this.author,
    required this.coverImage,
  });
}
