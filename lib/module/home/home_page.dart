// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/home/book_view.dart';
import 'package:nexus_app/module/home/home_controller.dart';
import 'package:nexus_app/module/profile/profile_page.dart';
import 'package:nexus_app/theme/style.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var controller = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());
  bool isSearch = false;
  final List<String> imageUrls = [
    "assets/book1.png",
    "assets/book2.png",
    "assets/book3.png",
    "assets/book4.png",
    "assets/book5.png",
    "assets/book6.png"
    // Add more image URLs as needed
  ];
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
      body: Obx(() => (controller.isLoading.value)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 20.0, // Spacing between columns
                          mainAxisSpacing: 15.0, // Spacing between rows
                        ),
                        // itemCount: controller.boardModel?.boards?.length,
                        itemCount: controller.subjectmodel?.subjects?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final randomImageUrl =
                              imageUrls[Random().nextInt(imageUrls.length)];
                          return GestureDetector(
                            onTap: () {
                              Get.to(BookView(
                                Subject: controller
                                        .subjectmodel?.subjects?[index].name
                                        .toString() ??
                                    '',
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(randomImageUrl)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.subjectmodel?.subjects?[index]
                                              .name ??
                                          '-',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )),
    ));
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
