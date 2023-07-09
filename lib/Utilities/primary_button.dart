import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_matter/Themes/themes.dart';

Widget primaryButton(
    {required String label,
    required IconData icon,
    required VoidCallback onPress}) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: TextButton.icon(
      onPressed: onPress,
      style: TextButton.styleFrom(
        foregroundColor: Get.theme.colorPrimaryDark,
        padding: const EdgeInsets.all(15),
        fixedSize: Size.fromWidth(Get.size.width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Get.theme.colorPrimary,
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
