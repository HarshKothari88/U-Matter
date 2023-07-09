import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:u_matter/Coins/coins_controller.dart';
import 'package:u_matter/Components/appbar.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';

class CoinsScreen extends GetView<CoinController> {
  const CoinsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: umatterAppBar(transparent: true, enableBackButton: true),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Your coins',
              style: Get.theme.kTitleTextStyle,
            ),
          ),
          SvgPicture.asset('assets/images/money.svg'),
          sizeBox(20, 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/coin.svg',
                height: 50,
              ),
              sizeBox(0, 20),
              Text(
                controller.coins.value.toString(),
                style: Get.theme.kBigTextStyle,
              ),
            ],
          ),
          sizeBox(20, 0),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'U-Matter Coins:\n\nYou can exchange this coin for products you shop in our platform\n\nTo earn this coin you have to complete daily goals and by completing tasks you get 5 Coins',
              style: Get.theme.kSmallTextStyle,
            ),
          ),
        ]),
      )),
    );
  }
}
