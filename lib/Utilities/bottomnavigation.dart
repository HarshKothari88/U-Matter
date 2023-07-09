// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:srmverse/Activities/Home/homepage_controller.dart';

// class BottomNavBar extends GetView<HomePageController> {
//   const BottomNavBar({Key? key,this.keepTransparent=true}) : super(key: key);
//   final bool keepTransparent;
//   @override
//   Widget build(BuildContext context) {
//     return ClipRect(
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
//         child: Container(
//           color: keepTransparent?Colors.transparent:null,
//           child: Obx(
//             () => BottomNavigationBar(
//                 elevation: 0,
//                 backgroundColor: Colors.transparent,
//                 type: BottomNavigationBarType.fixed,
//                 onTap: controller.bottomBarOnTap,
//                 currentIndex: controller.bottomBarIndex.value,
//                 showUnselectedLabels: false,
//                 items: [
//                   const BottomNavigationBarItem(
//                       icon: Icon(Icons.grade_outlined),
//                       activeIcon: Icon(Icons.grade_rounded),
//                       label: 'Home'),
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Get.isDarkMode
//                           ? Icons.bolt_outlined
//                           : Icons.dark_mode_outlined,
//                     ),
//                     activeIcon: Icon(
//                       Get.isDarkMode
//                           ? Icons.bolt_rounded
//                           : Icons.dark_mode_rounded,
//                     ),
//                     label: Get.isDarkMode ? 'Light' : 'Dark',
//                   ),
//                   const BottomNavigationBarItem(
//                       icon: Icon(Icons.school_outlined),
//                       activeIcon: Icon(Icons.school_rounded),
//                       label: 'Academia'),
//                   const BottomNavigationBarItem(
//                       icon: Icon(Icons.settings_outlined),
//                       activeIcon: Icon(Icons.settings_rounded),
//                       label: 'Settings'),
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
// }