import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:u_matter/Components/appbar.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen(
      {super.key, required this.img, required this.title, required this.desc});
  final String img;
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: umatterAppBar(enableBackButton: true),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              img,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Chip(
                  backgroundColor: Get.theme.curveBG,
                  label: Text('Trend ⭐', style: Get.theme.kSmallTextStyle)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                title,
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                desc,
                style: Get.theme.kSubTitleTextStyle,
              ),
            ),
            sizeBox(30, 0),
          ],
        ),
      )),
    );
  }
}
