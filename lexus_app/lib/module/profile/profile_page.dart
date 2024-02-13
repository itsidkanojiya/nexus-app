import 'package:flutter/material.dart';
import 'package:lexus_app/theme/style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Style.bg_color,
      appBar: AppBar(
        backgroundColor: Style.primary,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout_outlined,
                size: 25,
              )),
        ],
        bottom: const PreferredSize(
            preferredSize: Size(0, 0),
            child: Divider(
              height: 0,
              thickness: 1.6,
              color: Colors.black87,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: const BoxDecoration(
              // color: Color(0xff820000),
              color: Style.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0.0, 1.0), // Shadow position (x, y)
                  blurRadius: 3.0, // Spread of the shadow
                  spreadRadius: 1.0, // Offset of the shadow
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Name \n',
                    style: TextStyle(
                        color: Style.secondary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'email@gmail.com\n',
                        style: TextStyle(
                          height: 1.5,
                          color: Style.secondary,
                          fontSize: 16.0,
                        ),
                      ),
                      TextSpan(
                        text: 'School Name\n',
                        style: TextStyle(
                          height: 1.5,
                          color: Style.secondary,
                          fontSize: 15.0,
                        ),
                      ),
                      TextSpan(
                        text: 'Standard:- 12th',
                        style: TextStyle(
                          height: 1.5,
                          color: Style.secondary,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white24),
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 15, 0),
            child: Text('Your Self',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ),
          const Divider(
            endIndent: 15,
            indent: 15,
            color: Colors.grey,
          ),
          Container(
              height: 50,
              margin:
                  const EdgeInsets.only(top: 5, bottom: 0, right: 15, left: 15),
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, right: 15, left: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              // Set the width of the container

              child: const Row(
                children: [
                  Icon(
                    Icons.person_4_outlined,
                    color: Style.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text('Edit Profile',
                        style: TextStyle(
                            color: Style.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Style.primary,
                  ),
                ],
              )),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 15, 0),
            child: Text('About Us',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ),
          const Divider(
            endIndent: 15,
            indent: 15,
            color: Colors.grey,
          ),
          Container(
              height: 50,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 0, right: 15, left: 15),
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, right: 15, left: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              // Set the width of the container

              child: const Row(
                children: [
                  Icon(
                    Icons.person_4_outlined,
                    color: Style.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text('About Us',
                        style: TextStyle(
                            color: Style.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Style.primary,
                  ),
                ],
              )),
          Container(
              height: 50,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 0, right: 15, left: 15),
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, right: 15, left: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              // Set the width of the container

              child: const Row(
                children: [
                  Icon(
                    Icons.person_4_outlined,
                    color: Style.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text('Feedback',
                        style: TextStyle(
                            color: Style.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Style.primary,
                  ),
                ],
              )),
          Container(
              height: 50,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 0, right: 15, left: 15),
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, right: 15, left: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              // Set the width of the container

              child: const Row(
                children: [
                  Icon(
                    Icons.person_4_outlined,
                    color: Style.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text('Terms And Policy',
                        style: TextStyle(
                            color: Style.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Style.primary,
                  ),
                ],
              )),
        ]),
      ),
    ));
  }
}
