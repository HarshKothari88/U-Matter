import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:u_matter/Details%20Page/details_controller.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';
import 'package:u_matter/Utilities/dropdown_selector.dart';
import 'package:u_matter/Utilities/text_field.dart';

import '../Components/appbar.dart';
import '../Utilities/primary_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<DetailsController>(DetailsController());
    return Scaffold(
      appBar: umatterAppBar(left: false),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/check.svg',
                height: 200,
              ),
            ),
            Text(
              'Fill this basic fitness data',
              style: Get.theme.kTitleTextStyle,
            ),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  sizeBox(20, 0),
                  textField(
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please enter your age";
                        }
                        return null;
                      },
                      controller: controller.age,
                      icon: Icons.face_outlined,
                      label: 'Your Age',
                      keyboard: TextInputType.number),
                  textField(
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please enter your weight";
                        }
                        return null;
                      },
                      controller: controller.weight,
                      icon: Icons.scale_outlined,
                      label: 'Your Weight in Kgs',
                      keyboard: TextInputType.number),
                  textField(
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please enter your Height";
                        }
                        return null;
                      },
                      controller: controller.height,
                      icon: Icons.height_outlined,
                      label: 'Your Height in Cms',
                      keyboard: TextInputType.number),
                  Obx(
                    () => dropDownSelector(
                        hint: 'Gender',
                        onChanged: (v) {
                          controller.gender.value = v;
                        },
                        value: controller.gender.value,
                        list: controller.genderList),
                  ),
                  primaryButton(
                      label: "Submit and create account",
                      icon: Icons.send_rounded,
                      onPress: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.setAndCreateAccount();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
