import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:u_matter/Components/appbar.dart';
import 'package:u_matter/Home/home_controller.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:u_matter/Utilities/bottom_sheet.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';
import 'package:u_matter/Utilities/loading.dart';
import 'package:u_matter/Utilities/primary_button.dart';
import 'package:u_matter/Utilities/secondary_button.dart';
import 'package:u_matter/Utilities/text_field.dart';

class CommunityScreen extends GetView<HomeController> {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getFollowList();
    return Scaffold(
      appBar: umatterAppBar(
        transparent: true,
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
                  'New posts',
                  style: Get.theme.kTitleTextStyle,
                ),
              ),
              StreamBuilder(
                  stream: controller.postCollection.snapshots(),
                  builder: (c, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          if (snapshot.data!.size == 0)
                            Center(
                              child: Text(
                                'No Posts 🤧',
                                style: Get.theme.kTitleTextStyle,
                              ),
                            ),
                          ...snapshot.data!.docs.map((DocumentSnapshot e) {
                            String img = e['img']!;
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ListTile(
                                tileColor: Get.theme.curveBG.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
CircleAvatar(
                                        radius: 20,
                                        foregroundImage:
                                            NetworkImage(e['profileImg']!),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(e['name']!,
                                                style: Get
                                                    .theme.kSubTitleTextStyle),
                                            Text(
                                              e['time']!,
                                              style:
                                                  Get.theme.kVerySmallTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                      ],),
                                      if (e['uid'] !=
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                        Obx(() => (controller
                                                    .follow.isNotEmpty &&
                                                controller.follow
                                                    .where(
                                                        (p0) => p0 == e['uid']!)
                                                    .isNotEmpty)
                                            ? Text(
                                                'Following',
                                                style: Get.theme.kSmallTextStyle
                                                    .copyWith(
                                                        color: Colors.blue),
                                              )
                                            : Align(
                                                alignment: Alignment.topRight,
                                                child: TextButton.icon(
                                                    onPressed: () => {
                                                          controller.followUser(
                                                              e['uid']!)
                                                        },
                                                    icon: const Icon(Icons.add),
                                                    label: Text(
                                                      'Follow',
                                                      style: Get.theme
                                                          .kSmallTextStyle,
                                                    )),
                                              ))
                                    ]),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (img.isNotEmpty)
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/logo.png',
                                              image: e['img']!),
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(e['caption']!,
                                          style: Get.theme.kSubTitleTextStyle),
                                    ),
                                    TextButton.icon(
                                        onPressed: () {
                                          int likes = e['likes']!;
                                          controller.updateLikes(
                                              e.reference.id, likes += 1);
                                        },
                                        icon:
                                            const Icon(Icons.favorite_rounded),
                                        label: Text(
                                          "${e['likes']!} Likes",
                                          style: Get.theme.kSmallTextStyle,
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }
                    return const Loader();
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: FloatingActionButton(
          onPressed: () {
            var picUploaded = false.obs;
            bottomSheetWidget(
                Column(
                  children: [
                    sizeBox(20, 0),
                    Text(
                      "Upload a post",
                      style: Get.theme.kSubTitleTextStyle,
                    ),
                    sizeBox(20, 0),
                    Form(
                      key: controller.postFormKey,
                      child: Column(
                        children: [
                          textField(
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return "Please enter the caption";
                                }
                                return null;
                              },
                              controller: controller.postTitle,
                              icon: Icons.title,
                              label: "Caption"),
                          secondaryButton(
                              label: "Upload a image",
                              icon: Icons.post_add,
                              onPress: () => {
                                    controller.imgFromGallery().then(
                                        (value) => picUploaded.value = true)
                                  }),
                          Obx(() => picUploaded.value
                              ? Image.file(controller.photo!)
                              : sizeBox(0, 0)),
                          primaryButton(
                              label: "Upload",
                              icon: Icons.file_upload,
                              onPress: () => {controller.uploadPost()}),
                        ],
                      ),
                    ),
                  ],
                ),
                initialChild: 0.5);
          },
          elevation: 0,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
