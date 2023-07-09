// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeExtension on ThemeData {
  Color get colorPrimary => brightness == Brightness.dark
      ? Color.fromARGB(255, 155, 218, 255)
      : Color.fromARGB(255, 155, 218, 255);
  Color get colorPrimaryDark => brightness == Brightness.dark
      ? Color.fromARGB(255, 0, 78, 112)
      : Color.fromARGB(255, 0, 78, 112);
  Color get green => brightness == Brightness.dark
      ? const Color(0xff04EF47)
      : const Color(0xff04EF47);
  Color get adColor => brightness == Brightness.dark
      ? const Color(0xff000000)
      : const Color(0xffffffff);
  Color get dayNight => brightness == Brightness.dark
      ? const Color(0xffffffff)
      : const Color(0xff000000);
  Color get btnTextCol => brightness == Brightness.dark
      ? const Color(0xe8e9e9e9)
      : const Color(0xff494646);
  Color get menu_opener_color => brightness == Brightness.dark
      ? const Color(0xe2232323)
      : const Color(0xe3e3e3e3);
  Color get sheetColor => brightness == Brightness.dark
      ? const Color(0xff232323)
      : const Color(0xf0ffffff);
  Color get curveBG => brightness == Brightness.dark
      ? const Color(0x8D4A4A48)
      : const Color(0xB4F1F1F1);
  Color get barrierColor => brightness == Brightness.dark
      ? const Color(0xA4353534)
      : const Color(0xA4353534);
  Color get mainGStartCol => const Color(0xff66DA40);
  Color get mainGEndCol => const Color(0xff0F9FCF);

  Color get materialColor2 => const Color(0xff9BF6FF);
  Color get materialColorDark2 => const Color(0xff006670);
  Color get materialColor3 => const Color(0xffA0C4FF);
  Color get materialColorDark3 => const Color(0xff013180);
  Color get materialColor4 => const Color(0xffbdb2ff);
  Color get materialColorDark4 => const Color(0xff42368a);
  Color get materialColor5 => const Color(0xffFFC6FF);
  Color get materialColorDark5 => const Color(0xff800180);
  Color get materialColor6 => const Color(0xffFFADAD);
  Color get materialColorDark6 => const Color(0xff873232);
  Color get materialColor7 => const Color(0xffFFD6A5);
  Color get materialColorDark7 => const Color(0xff785123);
  Color get materialColor8 => const Color(0xfff6f8ba);
  Color get materialColorDark8 => const Color(0xff8E9200);
  Color get materialColor9 => const Color(0xfff694c1);
  Color get materialColorDark9 => const Color(0xff8c0342);

  TextStyle get kTitleTextStyle => GoogleFonts.nunito(
      fontWeight: FontWeight.w700, color: btnTextCol, fontSize: 25);
  TextStyle get kSubTitleTextStyle =>
      GoogleFonts.quicksand(fontSize: 17, fontWeight: FontWeight.w700);
  TextStyle get kSmallTextStyle =>
      GoogleFonts.nunito(fontWeight: FontWeight.w700, color: btnTextCol);
  TextStyle get kVerySmallTextStyle =>
      GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 10, color: btnTextCol);
  TextStyle get kBigTextStyle => GoogleFonts.nunito(
      fontWeight: FontWeight.w800, color: btnTextCol, fontSize: 40);
}

class Themes {
  static final light = ThemeData.light().copyWith(
    // backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xffffffff),
            statusBarIconBrightness: Brightness.dark)),
    scaffoldBackgroundColor: const Color(0xffffffff),
    // textTheme: TextTheme(headline1: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w800,color: Theme.of(context).btnTextCol),headline2: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.w600),headline3: GoogleFonts.quicksand(fontSize: 14,fontWeight: FontWeight.w600))
  );
  static final dark = ThemeData.dark().copyWith(
    // backgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xf2161616),
            statusBarIconBrightness: Brightness.light)),
    scaffoldBackgroundColor: const Color(0xff161616),
  );
}
