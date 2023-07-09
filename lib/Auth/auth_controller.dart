import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:u_matter/Details%20Page/details_screen.dart';
import 'package:u_matter/Home/home.dart';

import '../Data/firebase_var.dart';
import '../Utilities/snackbar.dart';
import 'authscreen.dart';

class AuthController extends GetxController {
  var userName = ''.obs;
  var emailAddress = ''.obs;
  var profileUrl = ''.obs;
  var uID = ''.obs;

  final _auth = FirebaseAuth.instance;

  final _userCollection =
      FirebaseFirestore.instance.collection(DBPathName.users);

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => {createDBForNewUser()});
    } on FirebaseAuthException catch (e) {
      debugPrint('FIREBASE AUTH ERROR: ${e.message}');
      setSnackBar('Auth Error: ${e.code}', 'Something went wrong');
    }
  }

  Future createDBForNewUser() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(DBPathName.users);

    bool docExists = await validateUserDocExist(_auth.currentUser!.uid);
    if (GetStorage().read('givenIntro') ?? false) {
      GetStorage().write('givenIntro', true);
    }
    if (docExists) {
      Get.off(() => const HomeScreen());
      debugPrint("DOC EXISTS");
      return;
    } else {
      Get.off(() => DetailsScreen());
    }
  }

  Future<bool> validateUserDocExist(String docID) async {
    try {
      var doc = await _userCollection.doc(docID).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  void getUserDetails() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        // ID of the provider (google.com, apple.cpm, etc.)
        // final provider = providerProfile.providerId;

        // UID specific to the provider
        final uid = providerProfile.uid;

        // Name, email address, and profile photo URL
        final name = providerProfile.displayName;
        final email = providerProfile.email;
        final profilePhoto = providerProfile.photoURL;

        uID.value = uid.toString();
        userName.value = name.toString();
        emailAddress.value = email.toString();
        profileUrl.value = profilePhoto.toString();

        debugPrint(
            "THE USER VALUE IS:  ${userName.value} ${emailAddress.value} ${profileUrl.value}");
      }
    } else {
      debugPrint('User is not logged in ${user?.providerData}');
    }
  }

  // void userActivityListener() {
  //   FirebaseAuth.instance.userChanges().listen((User? user) {
  //     if (user == null) {
  //       Get.off(() => const WebStrakeAuth());
  //     }
  //   });
  // }

  Future<void> signOut() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
    googleUser?.clearAuthCache();
  }

  Future<void> delAccount() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.delete();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().disconnect();
      googleUser?.clearAuthCache();
    }
  }

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.off(() => HomeScreen());
      } else {
        Get.off(() => const AuthScreen());
      }
    });
    super.onInit();
  }
}
