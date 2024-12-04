// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/assignment/create%20assignment/add%20details/add_assignment_details.dart';
import 'package:nexus_app/module/auth/unauthorized_view.dart';
import 'package:nexus_app/module/auth/unverified_view.dart';
import 'package:nexus_app/module/home/book/book_std_view.dart';
import 'package:nexus_app/module/home/home_controller.dart';
import 'package:nexus_app/module/home/solution/solution_std_view.dart';
import 'package:nexus_app/module/paper/create%20paper/add%20details/add_paper_details.dart';
import 'package:nexus_app/module/profile/profile_page.dart';
import 'package:nexus_app/theme/style.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController controller;
  bool isSearch = false;
  List<Map<String, dynamic>> gridItems = [];

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    // Initialize gridItems here
    gridItems = [
      {
        'icon': 'assets/book1.png',
        'title': 'NCERT Books',
        'page': const BookStdView(board: 'NCERT'),
      },
      {
        'icon': 'assets/solution.png',
        'title': 'NCERT Books Solution',
        'page': const SolutionStdView(board: 'NCERT'),
      },
      {
        'icon': 'assets/book3.png',
        'title': 'State Board Book',
        'page': const BookStdView(board: 'STATE BOARD'),
      },
      {
        'icon': 'assets/solution1.png',
        'title': 'State Board Book Solution',
        'page': const SolutionStdView(board: 'STATE BOARD'),
      },
      {
        'icon': 'assets/paper.png',
        'title': 'Create Paper',
        'onTap': () => _handleNavigation(AddPaperDetailsScreen()),
      },
      {
        'icon': 'assets/assignment1.png',
        'title': 'Create Worksheet',
        'onTap': () => _handleNavigation(AddAssignmentDetailsScreen()),
      },
    ];
  }

  void _handleNavigation(Widget page) {
    controller.checkUserAuthorization(() {
      if (controller.user?.userType == 'student') {
        // Redirect to unauthorized page if userType is student
        Get.to(() => const UnauthorizedView());
      } else if (controller.user?.isVerified == 1) {
        // Navigate to the intended page if the teacher is verified
        Get.to(page);
      } else {
        // If the teacher is not verified, redirect to UnverifiedPage
        Get.to(() => const UnverifiedView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Style.bg_color,
        appBar: AppBar(
          toolbarHeight: isSearch ? 150 : 80,
          leading: const SizedBox(),
          flexibleSpace: Column(
            children: [
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
                        child: Container(
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
                      )
                    : const SizedBox(),
              ]),
            ],
          ),
          elevation: 9.0,
          shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          backgroundColor: Style.secondary,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.0, // Adjust this for the aspect ratio
            ),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              final item = gridItems[index];
              return _buildGridItem(
                onTap: item['onTap'] ??
                    () {
                      Get.to(item['page']);
                    },
                icon: item['icon'],
                title: item['title'],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
      {required String icon,
      required String title,
      required Function()? onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  icon,
                  height: 80.0,
                  width: 80.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
