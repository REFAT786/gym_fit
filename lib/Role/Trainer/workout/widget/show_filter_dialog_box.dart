import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainee/color/controller/color_controller.dart';

void showFilterDialogBox(BuildContext context) {
  List<Map<String, String>> categories = [
    {"title": "Chest", "image": AppImages.serviceShortPhoto},
    {"title": "Arms", "image": AppImages.serviceShortPhoto},
    {"title": "Legs", "image": AppImages.serviceShortPhoto},
    {"title": "Shoulders", "image": AppImages.serviceShortPhoto},
    {"title": "Back", "image": AppImages.serviceShortPhoto},
    {"title": "Abdomen", "image": AppImages.serviceShortPhoto},
    {"title": "Tri-cep", "image": AppImages.serviceShortPhoto},
  ];

  List<bool> selectedCategories = List.generate(categories.length, (_) => false);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.primary,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 500,
                child: Container(
                  decoration: BoxDecoration(
                    color: PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.black:AppColors.black:AppColors.dialogBoxBg,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.selectMuscleGroups,
                          style: styleForText.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 20),

                        // List of muscle groups wrapped inside Flexible
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.traineeNavBArColor:AppColors.traineeNavBArColor:AppColors.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Image.network(
                                          categories[index]['image']!,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        categories[index]['title']!,
                                        style: styleForText.copyWith(fontSize: 16),
                                      ),
                                      const Spacer(),
                                      Checkbox(
                                        side: BorderSide(color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.dialogBoxBg,),
                                        value: selectedCategories[index],
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCategories[index] = value ?? false;
                                          });
                                        },
                                          activeColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.dialogBoxBg
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Action buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                AppString.cancel,
                                style: styleForText.copyWith(color: Colors.red),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                List<String> selected = [];
                                for (int i = 0; i < categories.length; i++) {
                                  if (selectedCategories[i]) {
                                    selected.add(categories[i]['title']!);
                                  }
                                }
                                print('Selected categories: $selected');
                                Get.back(result: selected);
                              },
                              child: Text(
                                AppString.apply,
                                style: styleForText.copyWith(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
