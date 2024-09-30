import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/home/book/book_subject_view.dart';
import 'package:nexus_app/module/profile/profile_page.dart';
import 'package:nexus_app/theme/style.dart';

class BookStdView extends StatefulWidget {
  final String board;
  const BookStdView({super.key, required this.board});

  @override
  State<BookStdView> createState() => _BookStdViewState();
}

class _BookStdViewState extends State<BookStdView> {
  final List<Map<String, dynamic>> classData = [
    {'classNumber': 12, 'color': Colors.purpleAccent},
    {'classNumber': 11, 'color': Colors.pinkAccent},
    {'classNumber': 10, 'color': Colors.orangeAccent},
    {'classNumber': 9, 'color': Colors.lightBlueAccent},
    {'classNumber': 8, 'color': Colors.greenAccent},
    {'classNumber': 7, 'color': Colors.purpleAccent},
    {'classNumber': 6, 'color': Colors.lightBlueAccent},
    {'classNumber': 5, 'color': Colors.orangeAccent},
    {'classNumber': 4, 'color': Colors.purpleAccent},
    {'classNumber': 3, 'color': Colors.pinkAccent},
    {'classNumber': 2, 'color': Colors.blueAccent},
    {'classNumber': 1, 'color': Colors.purpleAccent},
  ];

  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      Get.to(
                        () => const ProfilePage(),
                      );
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: classData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2, // Adjust the height of each item
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print(classData[index]['classNumber'].toString());
                  Get.to(
                    BookSubjectView(
                      board: widget.board,
                      std: classData[index]['classNumber'].toString(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: classData[index]['color'],
                        child: Text(
                          classData[index]['classNumber'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Class ${classData[index]['classNumber']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      // const Text(
                      //   'Books',
                      //   style: TextStyle(fontSize: 12),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
