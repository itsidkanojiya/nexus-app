import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/profile/profile_controller.dart';
import 'package:nexus_app/theme/style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

bool isSearch = false;
var controller = Get.isRegistered<ProfileController>()
    ? Get.find<ProfileController>()
    : Get.put(ProfileController());

class _ProfilePageState extends State<ProfilePage> {
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
                    'Profile',
                    style: Style.appBarTitle,
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
                          height: 20,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(
              child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1547721064-da6cfb341d50') // Replace with your image asset
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: InfoButton(
                text: 'Edit Profile',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AboutUsPage()),
                  // );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ReadOnlyTextField(
              labeleText: 'Name',
              initialValue: 'Siddharth Kanojiya',
            ),
            const SizedBox(
              height: 20,
            ),
            const ReadOnlyTextField(
              labeleText: 'Email',
              initialValue: 'webappsidkanojiya@gmail.com',
            ),
            const SizedBox(
              height: 20,
            ),
            const ReadOnlyTextField(
              labeleText: 'Std',
              initialValue: '8',
            ),
            const SizedBox(
              height: 20,
            ),
            const ReadOnlyTextField(
              labeleText: 'Subject',
              initialValue: 'English',
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   decoration: const BoxDecoration(
            //     color: Style.secondary,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black26,
            //         offset: Offset(0.0, 1.0), // Shadow position (x, y)
            //         blurRadius: 3.0, // Spread of the shadow
            //         spreadRadius: 1.0, // Offset of the shadow
            //       ),
            //     ],
            //   ),
            //   padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       RichText(
            //         text: TextSpan(
            //           text:
            //               '${AppService.userModel.value?.user ?? 'Siddharth Kanojiya'}\n',
            //           style: Style.appBarTitle,
            //           children: const <TextSpan>[
            //             TextSpan(
            //               text: 'webappsidkanojiya@gmail.com\n',
            //               style: TextStyle(
            //                 height: 1.5,
            //                 color: Colors.black,
            //                 fontSize: 16.0,
            //               ),
            //             ),
            //             TextSpan(
            //               text: 'Knowledge High School\n',
            //               style: TextStyle(
            //                 height: 1.5,
            //                 color: Colors.black,
            //                 fontSize: 15.0,
            //               ),
            //             ),
            //             TextSpan(
            //               text: 'Standard:- 12th',
            //               style: TextStyle(
            //                 height: 1.5,
            //                 color: Colors.black,
            //                 fontSize: 15.0,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       const CircleAvatar(
            //           radius: 40,
            //           backgroundImage: NetworkImage(
            //               'https://images.unsplash.com/photo-1547721064-da6cfb341d50') // Replace with your image asset
            //           ),
            //     ],
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(20, 20, 15, 0),
            //   child: Text('Your Self',
            //       style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500)),
            // ),
            // const Divider(
            //   endIndent: 15,
            //   indent: 15,
            //   color: Colors.grey,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(() => const EditProfilePage());
            //   },
            //   child: Container(
            //       height: 50,
            //       margin: const EdgeInsets.only(
            //           top: 5, bottom: 0, right: 15, left: 15),
            //       padding: const EdgeInsets.only(
            //           top: 0, bottom: 0, right: 15, left: 15),
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           border: Border.all(color: Colors.grey, width: 2),
            //           borderRadius: BorderRadius.circular(8)),
            //       // Set the width of the container

            //       child: const Row(
            //         children: [
            //           Icon(
            //             Icons.person_4_outlined,
            //             color: Style.primary,
            //           ),
            //           SizedBox(
            //             width: 15,
            //           ),
            //           Expanded(
            //             child: Text('Edit Profile',
            //                 style: TextStyle(
            //                     color: Style.primary,
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w600)),
            //           ),
            //           Icon(
            //             Icons.arrow_forward_ios_outlined,
            //             color: Style.primary,
            //           ),
            //         ],
            //       )),
            // ),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(20, 20, 15, 0),
            //   child: Text('About Us',
            //       style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500)),
            // ),
            // const Divider(
            //   endIndent: 15,
            //   indent: 15,
            //   color: Colors.grey,
            // ),
            // Container(
            //     height: 50,
            //     margin: const EdgeInsets.only(
            //         top: 10, bottom: 0, right: 15, left: 15),
            //     padding: const EdgeInsets.only(
            //         top: 0, bottom: 0, right: 15, left: 15),
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         border: Border.all(color: Colors.grey, width: 2),
            //         borderRadius: BorderRadius.circular(8)),
            //     // Set the width of the container

            //     child: const Row(
            //       children: [
            //         Icon(
            //           Icons.person_4_outlined,
            //           color: Style.primary,
            //         ),
            //         SizedBox(
            //           width: 15,
            //         ),
            //         Expanded(
            //           child: Text('About Us',
            //               style: TextStyle(
            //                   color: Style.primary,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w600)),
            //         ),
            //         Icon(
            //           Icons.arrow_forward_ios_outlined,
            //           color: Style.primary,
            //         ),
            //       ],
            //     )),
            // Container(
            //     height: 50,
            //     margin: const EdgeInsets.only(
            //         top: 10, bottom: 0, right: 15, left: 15),
            //     padding: const EdgeInsets.only(
            //         top: 0, bottom: 0, right: 15, left: 15),
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         border: Border.all(color: Colors.grey, width: 2),
            //         borderRadius: BorderRadius.circular(8)),
            //     // Set the width of the container

            //     child: const Row(
            //       children: [
            //         Icon(
            //           Icons.person_4_outlined,
            //           color: Style.primary,
            //         ),
            //         SizedBox(
            //           width: 15,
            //         ),
            //         Expanded(
            //           child: Text('Feedback',
            //               style: TextStyle(
            //                   color: Style.primary,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w600)),
            //         ),
            //         Icon(
            //           Icons.arrow_forward_ios_outlined,
            //           color: Style.primary,
            //         ),
            //       ],
            //     )),
            // Container(
            //     height: 50,
            //     margin: const EdgeInsets.only(
            //         top: 10, bottom: 0, right: 15, left: 15),
            //     padding: const EdgeInsets.only(
            //         top: 0, bottom: 0, right: 15, left: 15),
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         border: Border.all(color: Colors.grey, width: 2),
            //         borderRadius: BorderRadius.circular(8)),
            //     // Set the width of the container

            //     child: const Row(
            //       children: [
            //         Icon(
            //           Icons.person_4_outlined,
            //           color: Style.primary,
            //         ),
            //         SizedBox(
            //           width: 15,
            //         ),
            //         Expanded(
            //           child: Text('Terms And Policy',
            //               style: TextStyle(
            //                   color: Style.primary,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w600)),
            //         ),
            //         Icon(
            //           Icons.arrow_forward_ios_outlined,
            //           color: Style.primary,
            //         ),
            //       ],
            //     )),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Terms & Policy Link
                InfoButton(
                  text: 'About Us',
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AboutUsPage()),
                    // );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                // Terms & Policy Button
                InfoButton(
                  text: 'Terms & Policy',
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => TermsAndPolicyPage()),
                    // );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    ));
  }
}

class ReadOnlyTextField extends StatelessWidget {
  final String initialValue;
  final String labeleText;

  const ReadOnlyTextField(
      {super.key, required this.initialValue, required this.labeleText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: labeleText,
        hintText: initialValue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      controller: TextEditingController(text: initialValue),
    );
  }
}

class InfoButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const InfoButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        backgroundColor:
            // Style.primary2,
            Colors.blueGrey[800], // Muted color for a professional look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3, // Subtle shadow effect
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white, // Text color
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
