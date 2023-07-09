import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:u_matter/Themes/themes.dart';

Widget textField(
    {required String? Function(String?) validator,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboard,
    bool obscureText=false,
    bool enableSuggestions=true,
    bool autoCorrect=true,
    required String label}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: TextFormField(
      scrollPhysics: const BouncingScrollPhysics(),
      keyboardType: keyboard,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          // color: Get.theme.btnTextCol,
        ),
        // icon: Icon(
        //   icon,
        //   color: Get.theme.btnTextCol,
        // ),
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Get.theme.curveBG)),
      ),
    ),
  );
}
