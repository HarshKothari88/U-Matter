import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:u_matter/Components/appbar.dart';
import 'package:u_matter/Home/home_controller.dart';
import 'package:u_matter/Shopping%20Screen/cart_screen.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/loading.dart';
import 'package:u_matter/Utilities/primary_button.dart';
import 'package:u_matter/Utilities/secondary_button.dart';

class ShoppingScreen extends GetView<HomeController> {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: umatterAppBar(transparent: true, actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/coin.svg',
                width: 20,
              ),
              Obx(
                () => Text(
                  "  ${controller.coinController.coins.value}",
                  style: Get.theme.kSmallTextStyle,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(
            Icons.local_mall_outlined,
            color: Get.theme.btnTextCol,
          ),
        )
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Shop products',
                  style: Get.theme.kTitleTextStyle,
                ),
              ),
              FutureBuilder(
                  future: controller.getProducts(),
                  builder: (c, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          ...snapshot.data!.map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                tileColor: Get.theme.curveBG.withOpacity(0.5),
                                title: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/images/logo.png",
                                    image: e.img!,
                                    height: 200,
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      e.title!,
                                      style: Get.theme.kSubTitleTextStyle,
                                    ),
                                    primaryButton(
                                        label: "Buy for ${e.price!} Coins",
                                        icon: Icons.adjust_outlined,
                                        onPress: () => {}),
                                    secondaryButton(
                                        label: "Add to cart",
                                        dark: true,
                                        icon: Icons.local_mall_rounded,
                                        onPress: () =>
                                            {controller.addToCart(title: e.title!,img: e.img!,price: e.price!)}),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Loader();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
