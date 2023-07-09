import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_matter/Auth/auth_controller.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';

import '../Components/umatter_logo.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizeBox(50, 0),
            Center(child: UMatterLogo()),
            sizeBox(50, 0),
            Text(
              "Hey, Let's Get Started by,",
              style: Get.theme.kTitleTextStyle,
            ),
            SvgPicture.asset('assets/images/auth.svg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: TextButton.icon(
                  onPressed: () => {controller.signInWithGoogle()},
                  style: TextButton.styleFrom(
                      fixedSize:
                          Size.fromWidth(MediaQuery.of(context).size.width),
                      backgroundColor: Get.isDarkMode
                          ? const Color.fromARGB(255, 66, 133, 244)
                          : const Color.fromARGB(255, 249, 249, 249),
                      foregroundColor: Get.theme.dayNight,
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Get.isDarkMode ? Colors.white : null,
                      ),
                      child: Image.asset(
                        'assets/images/g-logo.png',
                        height: 30,
                      ),
                    ),
                  ),
                  label: Text(
                    'Sign in with Google',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'By signing in you agree to our terms and conditions',
                style: Get.theme.kSmallTextStyle,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      )),
    );
  }
}
