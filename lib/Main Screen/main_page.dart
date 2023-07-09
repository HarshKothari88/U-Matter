import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:u_matter/Blog/blog_screen.dart';
import 'package:u_matter/Coins/coins_screen.dart';
import 'package:u_matter/Components/appbar.dart';
import 'package:u_matter/Home/home_controller.dart';
import 'package:u_matter/Model/banner_model.dart';
import 'package:u_matter/Settings/settings_screen.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/correct_ellipis.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';
import 'package:u_matter/Utilities/dropdown_selector.dart';
import 'package:u_matter/Utilities/loading.dart';
import 'package:u_matter/Utilities/tertiary_button.dart';

class MainScreen extends GetView<HomeController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: umatterAppBar(transparent: true, actions: [
        GestureDetector(
          onTap: () => Get.to(() => const CoinsScreen()),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
              onPressed: () => Get.to(() => const SettingsScreen()),
              color: Get.theme.btnTextCol,
              icon: const Icon(Icons.settings)),
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
                'Health updates',
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                  future: controller.getBanners(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<BannerModel>> snapshot) {
                    if (snapshot.hasData) {
                      return Obx(
                        () => controller.bannerModelList.isNotEmpty
                            ? CarouselSlider(
                                options: CarouselOptions(
                                  height: 180.0,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  initialPage: 1,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 1000),
                                  viewportFraction: 0.8,
                                ),
                                items: [
                                  ...snapshot.data!
                                      .map(
                                        (e) => Wrap(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(5.0),
                                              child: GestureDetector(
                                                onTap: () => {
                                                  Get.to(() => BlogScreen(
                                                      img: e.img!,
                                                      title: e.title!,
                                                      desc: e.desc!))
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        'assets/images/logo.png',
                                                    image: e.img.toString(),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        child: Image.asset(
                                                          'assets/images/logo.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                e.title!.useCorrectEllipsis(),
                                                style:
                                                    Get.theme.kSmallTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                      .toList()
                                ],
                              )
                            : Center(
                                child: Text(
                                  'WELCOME 😎✌',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Get.theme.btnTextCol),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      );
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied_rounded,
                              color: Theme.of(context).btnTextCol,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Couldn't Load banners",
                                style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).btnTextCol),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return const Loader();
                  }),
            ),
            sizeBox(20, 0),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: InkWell(
                  onTap: () => Get.to(() => const SettingsScreen()),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'profileImg',
                        child: Material(
                          type: MaterialType.transparency,
                          child: CircleAvatar(
                            backgroundColor: Get.theme.curveBG,
                            radius: 28,
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(
                                  controller.authController.profileUrl.value),
                              radius: 25,
                            ),
                          ),
                        ),
                      ),
                      sizeBox(0, 15),
                      Expanded(
                        child: Hero(
                          tag: 'userName',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              controller
                                  .authController.userName.value.capitalize!
                                  .useCorrectEllipsis(),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Get.theme.kSubTitleTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            sizeBox(15, 0),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Today's Stats",
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "One week goal : 100k+",
                style: Get.theme.kSmallTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                contentPadding: const EdgeInsets.all(20),
                tileColor: Get.theme.curveBG.withOpacity(0.7),
                title: Text(
                  "Steps taken: ",
                  style: Get.theme.kSubTitleTextStyle,
                ),
                trailing: Obx(() => Icon(
                      controller.status.value == 'stopped'
                          ? Icons.accessibility_rounded
                          : Icons.directions_run_rounded,
                      size: 60,
                    )),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.steps.value.toString(),
                        style: Get.theme.kBigTextStyle,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Status : ${controller.status.value}",
                        style: Get.theme.kSubTitleTextStyle,
                      ),
                    ),
                    sizeBox(10, 0),
                    Obx(
                      () => Text(
                        "You can claim ${controller.coinController.available} Coins today",
                        style: Get.theme.kSmallTextStyle,
                      ),
                    ),
                    tertiaryButton(
                        label: "Claim your coins",
                        icon: const Icon(Icons.radio_button_checked_rounded),
                        onPress: () {
                          controller.coinController.updateCoins(controller
                              .coinController.available.value
                              .toInt());
                          controller.coinController.available.value = 0;
                        })
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Your BMI Index",
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("${controller.bmi.value}",
                    style: Get.theme.kTitleTextStyle),
              ),
            ),
            Center(
              child: Obx(() => SfRadialGauge(
                    enableLoadingAnimation: true,
                    animationDuration: 3000,
                    axes: <RadialAxis>[
                      RadialAxis(
                          showLabels: false,
                          showAxisLine: true,
                          showTicks: true,
                          canScaleToFit: true,
                          canRotateLabels: true,
                          minimum: 0,
                          maximum: 50,
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 0,
                                endValue: 18.5,
                                color: const Color.fromARGB(255, 37, 146, 254),
                                label: 'Under Weight',
                                sizeUnit: GaugeSizeUnit.factor,
                                labelStyle: const GaugeTextStyle(
                                    fontFamily: 'Times', fontSize: 10),
                                startWidth: 0.65,
                                endWidth: 0.65),
                            GaugeRange(
                              startValue: 18.6,
                              endValue: 24.9,
                              color: const Color.fromARGB(255, 0, 228, 27),
                              label: 'Normal',
                              labelStyle: const GaugeTextStyle(
                                  fontFamily: 'Times', fontSize: 10),
                              startWidth: 0.65,
                              endWidth: 0.65,
                              sizeUnit: GaugeSizeUnit.factor,
                            ),
                            GaugeRange(
                              startValue: 25,
                              endValue: 29.9,
                              color: const Color.fromARGB(255, 222, 229, 8),
                              label: 'Over\nWeight',
                              labelStyle: const GaugeTextStyle(
                                  fontFamily: 'Times', fontSize: 10),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: 0.65,
                              endWidth: 0.65,
                            ),
                            GaugeRange(
                              startValue: 30,
                              endValue: 34.9,
                              color: const Color.fromARGB(255, 229, 177, 8),
                              label: 'Obese',
                              labelStyle: const GaugeTextStyle(
                                  fontFamily: 'Times', fontSize: 10),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: 0.65,
                              endWidth: 0.65,
                            ),
                            GaugeRange(
                              startValue: 35,
                              endValue: 50,
                              color: const Color.fromARGB(255, 229, 41, 8),
                              label: 'Extremely Obese',
                              labelStyle: const GaugeTextStyle(
                                  fontFamily: 'Times', fontSize: 10),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: 0.65,
                              endWidth: 0.65,
                            ),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(value: controller.bmi.value)
                          ])
                    ],
                  )),
            ),
            sizeBox(20, 0),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Your BMR Calorie",
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            Obx(() => Column(
                  children: [
                    dropDownSelector(
                        hint: 'Your daily activity level',
                        onChanged: (v) {
                          if (v == 'Low Physical Activity') {
                            controller.activityFactor.value = 1;
                          } else if (v == 'Average Physical Activity') {
                            controller.activityFactor.value = 2;
                          } else if (v == 'Heavy Physical Activity') {
                            controller.activityFactor.value = 3;
                          }
                          controller.calcCalorie(
                              controller.weight,
                              controller.height,
                              controller.age,
                              controller.activityFactor.value,
                              controller.gender.value);
                        },
                        value: controller.activity.value,
                        list: controller.activityList),
                    sizeBox(30, 0),
                    Obx(
                      () => Text(
                        "You need these much of calories to\n\n👍 Maintain Weight : ${controller.bmr.value}\n\n😊 Mild Weight Loss : ${controller.bmr.value - 250}\n\n😣 Weight Loss : ${controller.bmr.value - 500}\n\n🤧 Extreme Weight Loss: ${controller.bmr.value - 1000}\n",
                        style: Get.theme.kSubTitleTextStyle,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Your Ideal Body weight",
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'As per your height and age',
                style: Get.theme.kSubTitleTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(
                () => Text(
                  'Try to maintain ${controller.ibw.value} Kgs 👌\n ',
                  style: Get.theme.kSubTitleTextStyle,
                ),
              ),
            ),
            sizeBox(100, 0),
          ],
        ),
      )),
    );
  }
}
