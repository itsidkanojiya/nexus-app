import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/favourite/fav_books_controller.dart';
import 'package:nexus_app/theme/style.dart';

class FavBooksPage extends StatefulWidget {
  const FavBooksPage({super.key});

  @override
  State<FavBooksPage> createState() => _FavBooksPageState();
}

class _FavBooksPageState extends State<FavBooksPage> {
  FavBooksController controller = Get.put(FavBooksController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Style.bg_color,
      appBar: AppBar(
          elevation: 0,
          bottom: const PreferredSize(
              preferredSize: Size(0, 5),
              child: Divider(
                color: Colors.grey,
                height: 1.5,
                thickness: 2.5,
              )),
          backgroundColor: Style.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Downloaded Books',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          )),
      body: (controller.favBookList.isEmpty)
          ? const Center(
              child: Text('No Favourite Books'),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 7),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(1, 2), // Shadow position (x, y)
                            blurRadius: 1.0, // Spread of the shadow
                            spreadRadius: 1.0, // Offset of the shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/book.png',
                        fit: BoxFit.fill,
                        height: 50,
                      ),
                      trailing: const Icon(
                        Icons.delete_outline_outlined,
                        size: 30,
                        color: Style.primary,
                      ),
                      title: const Text('Books Name'),
                      subtitle: const Text('Auther Name'),
                      // Add other widgets or customization as needed
                    ),
                  );
                },
              ),
            ),
    ));
  }
}
