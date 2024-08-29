import 'package:flutter/material.dart';
import 'package:nexus_app/module/assignment/view%20assignment/view_assignment.dart';
import 'package:nexus_app/module/home/create_view.dart';
import 'package:nexus_app/module/home/home_page.dart';
import 'package:nexus_app/module/paper/view%20paper/view_paper.dart';
import 'package:nexus_app/module/profile/profile_page.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        const HomeView(),
        const ViewPaperScreen(),
        const CreateView(),
        const ViewAssignmentScreen(),
        const ProfilePage(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: Style.bg_color,
          inactiveColorPrimary: Style.secondary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.paste_rounded),
          title: ("Paper"),
          activeColorPrimary: Style.bg_color,
          inactiveColorPrimary: Style.secondary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add, color: Style.secondary),
          title: ("Create"),
          activeColorPrimary: Style.bg_color,
          inactiveColorPrimary: Style.secondary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.assignment_outlined),
          title: ("Assignment"),
          activeColorPrimary: Style.bg_color,
          inactiveColorPrimary: Style.secondary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          activeColorPrimary: Style.bg_color,
          inactiveColorPrimary: Style.secondary,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),

      backgroundColor: Style.primary, // Default is Style.secondary.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.

      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        colorBehindNavBar: Style.secondary,
      ),

      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}
