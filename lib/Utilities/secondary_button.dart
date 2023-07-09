import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_matter/Themes/themes.dart';

Widget secondaryButton(
    {required String label,
    required IconData icon,
    bool dark = false,
    required VoidCallback onPress}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
    child: TextButton.icon(
      onPressed: onPress,
      style: TextButton.styleFrom(
        foregroundColor: dark ? Colors.white : Get.theme.btnTextCol,
        padding: const EdgeInsets.all(15),
        fixedSize: Size.fromWidth(Get.size.width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: dark ? Colors.black87 : Get.theme.curveBG,
      ),
      icon: Icon(
        icon,
      ),
      label: Text(
        label,
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    ),
  );
}
