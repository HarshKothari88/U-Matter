import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:u_matter/Components/umatter_logo.dart';
import 'package:u_matter/Themes/themes.dart';

PreferredSizeWidget umatterAppBar({
  bool left = true,
  List<Widget>? actions,
  bool transparent = false,
  bool enableBackButton=false,
}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: enableBackButton,
    leading: enableBackButton?IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios_new,color: Get.theme.btnTextCol,)):null,
    actions: actions,
    flexibleSpace: transparent
        ? ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          )
        : null,
    title: Hero(
        tag: "svLogo",
        child: Material(
            type: MaterialType.transparency,
            child: UMatterLogo(displayLeft: left, small: true))),
  );
}
