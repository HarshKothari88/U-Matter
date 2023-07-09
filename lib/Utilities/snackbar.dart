

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_matter/Themes/themes.dart';

void setSnackBar(String title, String message,
    {int seconds = 3,
    SnackPosition? position,
    bool? progressIndicator,
    bool? dismissible,
    Widget? icon,
    LinearGradient? gradient,
    bool? pulse}) {
  Get.snackbar(title, message,
      duration: Duration(seconds: seconds),
      snackPosition: position,
      shouldIconPulse: pulse,
      margin: const EdgeInsets.all(10),
      isDismissible: dismissible,
      backgroundGradient: gradient,
      colorText: Get.theme.btnTextCol,
      icon: icon,
      titleText: Text(
        title,
        style: GoogleFonts.quicksand(fontWeight: FontWeight.w800, fontSize: 16),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      backgroundColor: Get.theme.curveBG.withOpacity(0.7),
      showProgressIndicator: progressIndicator,
      snackStyle: SnackStyle.FLOATING);
}
