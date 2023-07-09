import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:u_matter/Auth/authscreen.dart';
import 'package:u_matter/Home/home.dart';
import 'package:u_matter/OnBoarding/onboarding_screen.dart';
import 'package:u_matter/Themes/theme_service.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/firebase_options.dart';
import 'package:u_matter/get_bindings.dart';

void main() {
 runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await GetStorage.init();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final appdata = GetStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 800),
      // transitionDuration: const Duration(milliseconds: 800),
      initialBinding: ControllerBindings(),
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      // getPages: [
      //   GetPage(name: '/', page: () => WebStrakeApp()),
      //   GetPage(name: '/badge', page: () => BadgeScreen()),
      //   GetPage(name: '/state', page: () => StateSelector()),
      //   GetPage(name: '/browser', page: () => WebStrakeBrowser()),
      // ],
      home: appdata.read('givenIntro') ?? false
          ? const OnBoardingScreen()
          : checkUser(),
    );
  }
}

Widget checkUser() {
  return FirebaseAuth.instance.currentUser == null
      ? const AuthScreen()
      : const HomeScreen();
}