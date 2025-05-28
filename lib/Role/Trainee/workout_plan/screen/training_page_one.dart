import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Common/widgets/custom_button.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';

import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainer/workout/controller/workout_details_controller.dart';
import '../../color/controller/color_controller.dart';

class TrainingPageOne extends StatelessWidget {
  TrainingPageOne({super.key});
  final WorkoutDetailsController controller =
      Get.find<WorkoutDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: CustomBackButton(),
        ),
        title: Text(
          AppString.letsPush,
          style: styleForText.copyWith(fontSize: 24),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Obx(
          () => InkWell(
            onTap: () {
              Get.toNamed(
                RoutesName.restScreen,
                arguments: {'date': DateTime.now()},
              );
            },
            child: CustomButton(
              buttonText: "Complete Set ${controller.index.value}",
              backgroundColor:
                  PrefsHelper.myRole == "trainee"
                      ? ColorController.instance.getButtonColor()
                      : AppColors.secondary,
              textColor:
                  PrefsHelper.myRole == 'trainee'
                      ? ColorController.instance.getTextColor()
                      : AppColors.primary,
            ),
          ),
        ),
      ),
      body: CustomTrainerGradientBackgroundColor(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    image: NetworkImage(AppImages.serviceCoverImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        "Set ${controller.index.value} of ${controller.totalSets.value}",
                        style: styleForText.copyWith(fontSize: 25),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Current Set",
                      style: styleForText.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 15),
                    GridView.builder(
                      itemCount:
                          controller.workoutDetail.value.measurements.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 100,
                          ),
                      itemBuilder: (context, index) {
                        final measurements =
                            controller.workoutDetail.value.measurements[index];
                        return Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                measurements['name'] == "rest" ||
                                        measurements['name'] == "rests"
                                    ? "Rest Time"
                                    : measurements['name'],
                                style: styleForText.copyWith(fontSize: 18),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      PrefsHelper.myRole == 'trainee'
                                          ? AppColors.traineeNavBArColor
                                          : const Color(0xff033a5b),
                                ),
                                child: Text(
                                  measurements['value'].toString(),
                                  style: styleForText.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        PrefsHelper.myRole == "trainee"
                                            ? ColorController.instance
                                                .getHintTextColor()
                                            : AppColors.hintGrey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
