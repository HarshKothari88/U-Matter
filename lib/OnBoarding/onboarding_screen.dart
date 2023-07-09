import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:u_matter/Auth/authscreen.dart';
import 'package:u_matter/Home/home.dart';

import '../Components/umatter_logo.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: GoogleFonts.nunito(
          textStyle:
              const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      showBackButton: true,
      done: Text('Done',
          style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward_ios_rounded),
      back: const Icon(Icons.arrow_back_ios),
      skipOrBackFlex: 0,
      nextFlex: 0,
      onDone: () => {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            Get.off(() => HomeScreen());
          } else {
            Get.off(() => const AuthScreen());
          }
        }),
      },
      globalHeader: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UMatterLogo(),
              ],
            ),
          ),
        ),
      ),
      animationDuration: 600,
      pages: [
        PageViewModel(
          title: "Welcome to U-Matter",
          body:
              "A innovative lifestyle app and a comprehensive solution for individuals seeking to improve their overall well-being",
          image: SvgPicture.asset(
            'assets/images/welcome.svg',
            height: 220,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Your Fitness tracker",
          body:
              "This app will help you calculate your fitness data for your well-being",
          image: SvgPicture.asset(
            'assets/images/gym.svg',
            height: 200,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn about lifestyles",
          body:
              "A in-app news section which lets you stay updated on new lifestyles method",
          image: SvgPicture.asset(
            'assets/images/edu.svg',
            height: 200,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Productivity tracker",
          body: "This app also lets you set goals and track your productivity",
          image: SvgPicture.asset(
            'assets/images/prod.svg',
            height: 220,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Healthy-Shopping",
          body:
              "You can earn coins from completing your tasks and by playing games and shop them",
          image: SvgPicture.asset(
            'assets/images/health.svg',
            height: 220,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Community Sharing",
          body: "Share your journey with others and help the community",
          image: SvgPicture.asset(
            'assets/images/beach.svg',
            height: 200,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "You are awesome!! 👀🔥",
          body: "Lesssgooo ----->",
          image: SvgPicture.asset(
            'assets/images/surf.svg',
            height: 180,
          ),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
