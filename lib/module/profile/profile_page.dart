import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/auth/change%20password/chnage_password_page.dart';
import 'package:nexus_app/module/auth/login/login_view.dart';
import 'package:nexus_app/module/profile/edit_profile.dart';
import 'package:nexus_app/module/profile/profile_controller.dart';
import 'package:nexus_app/services/app_service.dart';
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
                SizedBox(
                  height: 80,
                  child: Center(
                      child: Text(
                    'Profile',
                    style: Style.appBarTitle,
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
      body: Obx(
        () => (controller.isLoading.value == true)
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Style.secondary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name
                              ProfileInfoRow(
                                label: 'Name',
                                value: controller.user?.name ?? '',
                              ),
                              const SizedBox(height: 10),
                              // Email
                              ProfileInfoRow(
                                label: 'Email',
                                value: controller.user?.email ?? '',
                              ),
                              const SizedBox(height: 10),
                              // School Name
                              ProfileInfoRow(
                                label: 'Mobile Number',
                                value: controller.user?.number ?? '',
                              ),
                              const SizedBox(height: 10),
                              ProfileInfoRow(
                                label: 'School Name',
                                value: controller.user?.school ?? '',
                              ),
                              const SizedBox(height: 10),
                              // Standard
                              ProfileInfoRow(
                                label: 'Standard',
                                value: controller.user?.std.toString() ?? '',
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
                        ProfileOption(
                          icon: Icons.person_4,
                          color: Style.primary,
                          name: 'Edit Profile',
                          onTap: () {
                            Get.to(EditProfilePage());
                          },
                        ),
                        ProfileOption(
                          icon: Icons.lock_outline_rounded,
                          color: Style.primary,
                          name: 'Change Password',
                          onTap: () {
                            Get.to(ChangePasswordPage());
                          },
                        ),
                        ProfileOption(
                          icon: Icons.logout,
                          color: const Color.fromARGB(255, 196, 54, 44),
                          name: 'Logout',
                          onTap: () async {
                            await AppService.storage.write('token', '');
                            Get.to(LoginView());
                          },
                        ),
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
                        ProfileOption(
                          icon: Icons.people,
                          color: Style.primary,
                          name: 'About Us',
                          onTap: () {},
                        ),
                        ProfileOption(
                          icon: Icons.policy,
                          color: Style.primary,
                          name: 'Terms And Policy',
                          onTap: () {},
                        ),
                      ]),
                ),
              ),
      ),
    ));
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onTap;
  final Color color;
  final double borderRadius;
  final double height;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.name,
    required this.onTap,
    this.color = Colors.grey,
    this.borderRadius = 8.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          '$label:- ',
          style: const TextStyle(
            color: Style.primary, // Use your primary color
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // Value
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
