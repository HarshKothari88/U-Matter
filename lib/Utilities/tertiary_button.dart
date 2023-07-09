import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_matter/Themes/themes.dart';

Widget tertiaryButton(
    {required String label,
    required Widget icon,
    required VoidCallback onPress}) {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0, right: 22),
    child: TextButton.icon(
      onPressed: onPress,
      style: TextButton.styleFrom(
        foregroundColor: Get.theme.colorPrimaryDark,
        padding: const EdgeInsets.all(8),
        fixedSize: Size.fromWidth(Get.size.width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Get.theme.colorPrimary,
      ),
      icon: icon,
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
