import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:u_matter/Home/home.dart';
import 'package:u_matter/Model/user_model.dart';

import '../Data/firebase_var.dart';

class DetailsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final age = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();
  var gender = ''.obs;

  List<String> genderList = ['Male', 'Female'];

  final _auth = FirebaseAuth.instance;
  final _userCollection =
      FirebaseFirestore.instance.collection(DBPathName.users);

  Future<void> setAndCreateAccount() async {
    final userData = UserModel(
        name: _auth.currentUser!.displayName,
        age: int.parse(age.text),
        gender: gender.value,
        weight: int.parse(weight.text),
        height: int.parse(height.text));
    _userCollection
        .doc(_auth.currentUser!.uid)
        .set(userData.toJson())
        .then((value) => {Get.off(() => HomeScreen())});
  }

  Future<void> updateData() async {
    final userData = UserModel(
        name: _auth.currentUser!.displayName,
        age: int.parse(age.text),
        gender: gender.value,
        weight: int.parse(weight.text),
        height: int.parse(height.text));
    _userCollection
        .doc(_auth.currentUser!.uid)
        .set(userData.toJson(), SetOptions(merge: true))
        .then((value) => {Get.off(() => const HomeScreen())});
  }
}
