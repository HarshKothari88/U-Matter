import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:u_matter/Components/appbar.dart';
import 'package:u_matter/Home/home_controller.dart';
import 'package:u_matter/Themes/themes.dart';
import 'package:u_matter/Utilities/bottom_sheet.dart';
import 'package:u_matter/Utilities/custom_sizebox.dart';
import 'package:u_matter/Utilities/loading.dart';
import 'package:u_matter/Utilities/primary_button.dart';
import 'package:u_matter/Utilities/secondary_button.dart';
import 'package:u_matter/Utilities/text_field.dart';

import '../Coins/coins_screen.dart';

class TasksScreen extends GetView<HomeController> {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: umatterAppBar(transparent: true, actions: [
        GestureDetector(
          onTap: () => Get.to(() => const CoinsScreen()),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                  "Your tasks",
                  style: Get.theme.kTitleTextStyle,
                ),
              ),
              Obx(
                () => controller.showTasks.value
                    ? FutureBuilder(
                        future: controller.getTasks(),
                        builder: (c, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                if (snapshot.data!.isEmpty)
                                  Center(
                                    child: Text(
                                      "Please add some tasks",
                                      style: Get.theme.kSmallTextStyle,
                                    ),
                                  ),
                                ...snapshot.data!.map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: ListTile(
                                        tileColor:
                                            Get.theme.curveBG.withOpacity(0.6),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        leading: Checkbox(
                                            activeColor:
                                                Get.theme.colorPrimaryDark,
                                            value: e.completed,
                                            onChanged: (v) {
                                              if (v!) {
                                                controller.taskCompleted(e.id!);
                                              }
                                            }),
                                        title: Text(
                                          e.title!,
                                          style: Get.theme.kSubTitleTextStyle
                                              .copyWith(
                                                  decoration: e.completed!
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : null),
                                        ),
                                        trailing: IconButton(
                                            onPressed: () =>
                                                controller.deleteTask(e.id!),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 238, 20, 5),
                                            )),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.desc!,
                                              style: Get.theme.kSmallTextStyle,
                                            ),
                                          ],
                                        )),
                                  ),
                                )
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "Something went wrong",
                                style: Get.theme.kSmallTextStyle,
                              ),
                            );
                          } else if (!snapshot.hasData) {
                            Center(
                              child: Text(
                                "Please add some tasks",
                                style: Get.theme.kSmallTextStyle,
                              ),
                            );
                          }
                          return const Loader();
                        })
                    : sizeBox(0, 0),
              ),
              sizeBox(50, 0),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () => {
            bottomSheetWidget(
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Add your tasks",
                        style: Get.theme.kTitleTextStyle,
                      ),
                    ),
                    Form(
                        key: controller.taskFormKey,
                        child: Column(
                          children: [
                            textField(
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "Please enter the title";
                                  }
                                  return null;
                                },
                                controller: controller.title,
                                icon: Icons.title,
                                label: "Title"),
                            textField(
                                keyboard: TextInputType.multiline,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "Please enter the title";
                                  }
                                  return null;
                                },
                                controller: controller.desc,
                                icon: Icons.description_outlined,
                                label: "Description"),
                            primaryButton(
                                label: "Create Task",
                                icon: Icons.add_task_rounded,
                                onPress: () => controller
                                    .addTasks()
                                    .then((value) => Get.back())),
                          ],
                        ))
                  ],
                ),
                initialChild: 0.5),
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
