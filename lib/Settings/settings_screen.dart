import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:u_matter/Components/appbar.dart';
import 'package:u_matter/Details%20Page/details_controller.dart';
import 'package:u_matter/Home/home_controller.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/correct_ellipis.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';
import 'package:u_matter/Utilities/primary_button.dart';
import 'package:u_matter/Utilities/secondary_button.dart';
import 'package:u_matter/Utilities/text_field.dart';

import '../Utilities/dropdown_selector.dart';

class SettingsScreen extends GetView<HomeController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsC = Get.put<DetailsController>(DetailsController());
    detailsC.age.text = controller.age.toString();
    detailsC.weight.text = controller.weight.toString();
    detailsC.height.text = controller.height.toString();
    detailsC.gender.value = controller.gender.value;
    return Scaffold(
      appBar: umatterAppBar(
        transparent: true,
        enableBackButton: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Profile and settings',
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            sizeBox(30, 0),
            Center(
              child: Hero(
                tag: 'profileImg',
                child: Material(
                  type: MaterialType.transparency,
                  child: CircleAvatar(
                    backgroundColor: Get.theme.curveBG,
                    radius: 28,
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(
                          controller.authController.profileUrl.value),
                      radius: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Hero(
                  tag: 'userName',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      controller.authController.userName.value.capitalize!
                          .useCorrectEllipsis(),
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.theme.kTitleTextStyle,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                controller.authController.emailAddress.value,
                style: Get.theme.kSubTitleTextStyle,
              ),
            ),
            Form(
              key: detailsC.formKey,
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
                      controller: detailsC.age,
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
                      controller: detailsC.weight,
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
                      controller: detailsC.height,
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
                        list: detailsC.genderList),
                  ),
                  primaryButton(
                      label: "Update your data",
                      icon: Icons.send_rounded,
                      onPress: () {
                        if (detailsC.formKey.currentState!.validate()) {
                          detailsC.setAndCreateAccount();
                        }
                      }),
                  secondaryButton(
                      label: 'Log out',
                      dark: true,
                      icon: Icons.logout_rounded,
                      onPress: () => controller.authController.signOut())
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
