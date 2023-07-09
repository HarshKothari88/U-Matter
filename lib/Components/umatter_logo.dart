import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_matter/Themes/themes.dart';

Widget UMatterLogo({bool displayLeft = false, bool small = false}) {
  return Row(
    mainAxisAlignment:
        displayLeft ? MainAxisAlignment.start : MainAxisAlignment.center,
    mainAxisSize: displayLeft ? MainAxisSize.max : MainAxisSize.min,
    children: [
      // Image.asset(
      //   'assets/images/main/logo.png',
      //   height: 35,
      // ),
      SvgPicture.asset(
        'assets/images/logo.svg',
        height: small ? 30 : 50,
      ),
      Text(
        '  Matter',
        style: Get.theme.kTitleTextStyle,
      )
    ],
  );
}
