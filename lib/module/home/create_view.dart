// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/assignment/create%20assignment/add%20details/add_assignment_details.dart';
import 'package:nexus_app/module/home/home_controller.dart';
import 'package:nexus_app/module/paper/create%20paper/add%20details/add_paper_details.dart';
import 'package:nexus_app/module/profile/profile_page.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:nexus_app/utils/custome_card.dart';

class CreateView extends StatefulWidget {
  const CreateView({super.key});

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  var controller = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());
  bool isSearch = false;
  final List<String> imageUrls = [
    "assets/assignment1.png",

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      'What do you want to create?',
                      style: Style.tableTitle,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        imagePath: "assets/assignment1.png",
                        onTap: () {
                          Get.to(AddPaperDetailsScreen());
                        },
                        title: 'Paper',
                      ),
                      CustomCard(
                        imagePath: "assets/paper.png",
                        onTap: () {
                          Get.to(AddAssignmentDetailsScreen());
                        },
                        title: 'Worksheet',
                      )
                    ],
                  ),
                ],
              ),
            )));
  }
}
