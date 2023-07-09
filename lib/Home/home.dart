import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_matter/Home/home_controller.dart';
import 'package:u_matter/Main%20Screen/main_page.dart';
import 'package:u_matter/Tasks Screen/tasks_screen.dart';
import 'package:u_matter/Shopping%20Screen/shopping_screen.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:get/get.dart';
import 'package:u_matter/community/community_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());
    controller.authController.getUserDetails();
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 24,
          backgroundColor: Colors.transparent,
          border: Border.all(width: 0, color: Colors.transparent),
          activeColor: Get.theme.colorPrimaryDark,
          inactiveColor: Get.theme.colorPrimaryDark,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart_rounded),
                label: 'Shop'),
            BottomNavigationBarItem(
                icon: Icon(Icons.task_outlined),
                activeIcon: Icon(Icons.task_rounded),
                label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.forum_outlined),
                activeIcon: Icon(Icons.forum_rounded),
                label: 'Community'),
          ],
        ),
        tabBuilder: ((context, index) {
          switch (index) {
            case 0:
              return const MainScreen();
            case 1:
              return const ShoppingScreen();
            case 2:
              return const TasksScreen();
            case 3:
              return const CommunityScreen();
            default:
              return const HomeScreen();
          }
        }));
  }
}
