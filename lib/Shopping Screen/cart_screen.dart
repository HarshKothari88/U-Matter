import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:u_matter/Components/appbar.dart';
import 'package:u_matter/Home/home_controller.dart';
import 'package:u_matter/Model/product_model.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/correct_ellipis.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';
import 'package:u_matter/Utilities/loading.dart';
import 'package:u_matter/Utilities/secondary_button.dart';

class CartScreen extends GetView<HomeController> {
  const CartScreen({super.key});

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
                'Your Cart',
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            FutureBuilder(
                future: controller.getCartList(),
                builder: (c, snapshot) {
                  if (snapshot.hasData) {
                    controller.cartPrice.value = 0;
                    return Column(
                      children: [
                        if (snapshot.data!.isEmpty)
                          Center(
                            child: Text(
                              "Add some items to your cart",
                              style: Get.theme.kSubTitleTextStyle,
                            ),
                          ),
                        ...snapshot.data!.map((e) {
                          controller.cartPrice.value += e.price!;

                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(20),
                              tileColor: Get.theme.curveBG,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              leading: FadeInImage.assetNetwork(
                                placeholder: "assets/images/logo.png",
                                image: e.img!,
                                height: 50,
                              ),
                              title: Text(
                                e.title!.useCorrectEllipsis(),
                                style: Get.theme.kSmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                  onPressed: () =>
                                      {controller.deleteCart(e.id!)},
                                  icon: Icon(
                                    Icons.delete,
                                    color: Get.theme.btnTextCol,
                                  )),
                              subtitle: Row(
                                children: [
                                  sizeBox(30, 0),
                                  Text(
                                    "Price : ",
                                    style: Get.theme.kSmallTextStyle,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/coin.svg',
                                    height: 20,
                                  ),
                                  sizeBox(0, 5),
                                  Text(
                                    "${e.price!}",
                                    style: Get.theme.kSmallTextStyle,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        sizeBox(50, 0),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Obx(
                            () => controller.cartPrice.value != 0
                                ? Row(
                                    children: [
                                      Text(
                                        "Total :   ",
                                        style: Get.theme.kTitleTextStyle,
                                      ),
                                      SvgPicture.asset(
                                        'assets/images/coin.svg',
                                        height: 30,
                                      ),
                                      sizeBox(0, 10),
                                      Obx(
                                        () => Text(
                                          controller.cartPrice.value.toString(),
                                          style: Get.theme.kTitleTextStyle,
                                        ),
                                      ),
                                    ],
                                  )
                                : sizeBox(0, 0),
                          ),
                        ),
                        Obx(
                          () => controller.cartPrice.value != 0
                              ? secondaryButton(
                                  label: 'Buy now',
                                  dark: true,
                                  icon: Icons.local_mall_rounded,
                                  onPress: () => {
                                    controller.purchaseCart(controller.cartPrice.value).then((value) => Navigator.pop(context)),
                                  })
                              : sizeBox(0, 0),
                        ),
                      ],
                    );
                  }
                  return const Loader();
                }),
          ],
        ),
      )),
    );
  }
}
