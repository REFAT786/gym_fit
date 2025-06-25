import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Common/widgets/custom_button.dart';
import 'package:gym_fit/Common/widgets/custom_text_field.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Role/Trainer/workout/controller/workout_details_controller.dart';
import 'package:gym_fit/Utils/app_url.dart';

import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainee/color/controller/color_controller.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  WorkoutDetailsScreen({super.key});

  final WorkoutDetailsController controller =
      Get.find<WorkoutDetailsController>();

  @override
  Widget build(BuildContext context) {
    log(">>>>>>>>>>>>>>>>>>>>>>>>> my role ${PrefsHelper.myRole}");
    log(
      ">>>>>>>>>>>>>>>>>>>>>>>>> Exercise name  ${controller.workoutDetail.value.exerciseName}",
    );
    log(
      ">>>>>>>>>>>>>>>>>>>>>>>>> Exercise name  ${controller.workoutDetail.value.id}",
    );
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const CustomBackButton(),
          ),
          title: Obx(
            () =>
                controller.workoutDetail.value.exerciseName.isNotEmpty
                    ? Text(
                      controller.workoutDetail.value.exerciseName,
                      style: styleForText.copyWith(
                        fontSize: 24,
                        color:
                            PrefsHelper.myRole == 'trainee'
                                ? ColorController.instance.getTextColor()
                                : AppColors.white,
                      ),
                    )
                    : const Text(""),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  Obx(() {
                    return Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child:
                          controller
                                  .workoutDetail
                                  .value
                                  .exerciseImage
                                  .isNotEmpty
                              ? CustomCommonImage(
                                imageSrc:
                                    "${AppUrl.baseUrl}${controller.workoutDetail.value.exerciseImage}",
                                imageType: ImageType.network,
                                defaultImage: "assets/images/noImage.png",
                                height: 250,
                                width: double.infinity,
                                borderRadius: 16,
                              )
                              : Center(
                                child: Text(
                                  AppString.noVideoAvailable,
                                  style: styleForText.copyWith(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                    );
                  }),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Text(
                            controller.workoutDetail.value.stations.isNotEmpty
                                ? controller
                                        .workoutDetail
                                        .value
                                        .stations[0]['number']
                                        ?.toString() ??
                                    AppString.noStationNumber
                                : AppString.noStationNumber,
                            style: styleForText.copyWith(
                              fontSize: 25,
                              color:
                                  PrefsHelper.myRole == 'trainee'
                                      ? ColorController.instance.getTextColor()
                                      : AppColors.white,
                            ),
                          );
                        }),
                        Obx(() {
                          return Text(
                            controller.workoutDetail.value.stations.isNotEmpty
                                ? controller
                                        .workoutDetail
                                        .value
                                        .stations[0]['name']
                                        ?.toString() ??
                                    AppString.noStationName
                                : AppString.noStationName,
                            style: styleForText.copyWith(
                              fontSize: 25,
                              color:
                                  PrefsHelper.myRole == 'trainee'
                                      ? ColorController.instance.getTextColor()
                                      : AppColors.white,
                            ),
                          );
                        }),
                        Text(
                          AppString.targetMuscles,
                          style: styleForText.copyWith(
                            fontSize: 25,
                            color:
                                PrefsHelper.myRole == 'trainee'
                                    ? ColorController.instance.getTextColor()
                                    : AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 90,
                          child: Obx(() {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller
                                      .workoutDetail
                                      .value
                                      .muscleGroups
                                      .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: CustomCommonImage(
                                        imageSrc:
                                            controller
                                                    .workoutDetail
                                                    .value
                                                    .muscleGroups[index]
                                                    .image
                                                    .isNotEmpty
                                                ? "${AppUrl.baseUrl}${controller.workoutDetail.value.muscleGroups[index].image}"
                                                : "N/A",
                                        imageType: ImageType.network,
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppString.description,
                          style: styleForText.copyWith(
                            fontSize: 25,
                            color:
                                PrefsHelper.myRole == 'trainee'
                                    ? ColorController.instance.getTextColor()
                                    : AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  PrefsHelper.myRole == 'trainee'
                                      ? AppColors.traineeNavBArColor
                                      : AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              controller
                                      .workoutDetail
                                      .value
                                      .exerciseDescription
                                      .isNotEmpty
                                  ? controller
                                      .workoutDetail
                                      .value
                                      .exerciseDescription
                                  : "N/A",
                              style: styleForText.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color:
                                    PrefsHelper.myRole == 'trainee'
                                        ? ColorController.instance
                                            .getTextColor()
                                        : AppColors.white,
                              ),
                            ),
                          );
                        }),
                        Text(
                          AppString.equipment,
                          style: styleForText.copyWith(
                            fontSize: 25,
                            color:
                                PrefsHelper.myRole == 'trainee'
                                    ? ColorController.instance.getTextColor()
                                    : AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Row(
                            children: [
                              CustomCommonImage(
                                imageSrc:
                                    "${AppUrl.baseUrl}${controller.workoutDetail.value.equipment.image}",
                                imageType: ImageType.network,
                                height: 120,
                                width: 110,
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 10),
                        Text(
                          AppString.equipmentDescription,
                          style: styleForText.copyWith(
                            fontSize: 25,
                            color:
                                PrefsHelper.myRole == 'trainee'
                                    ? ColorController.instance.getTextColor()
                                    : AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  PrefsHelper.myRole == 'trainee'
                                      ? AppColors.traineeNavBArColor
                                      : AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              controller
                                      .workoutDetail
                                      .value
                                      .equipment
                                      .description
                                      .isNotEmpty
                                  ? controller
                                      .workoutDetail
                                      .value
                                      .equipment
                                      .description
                                  : "N/A",
                              style: styleForText.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color:
                                    PrefsHelper.myRole == 'trainee'
                                        ? ColorController.instance
                                            .getTextColor()
                                        : AppColors.white,
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 10),
                        Obx(() {
                          return ListView.builder(
                            itemCount:
                                controller
                                    .workoutDetail
                                    .value
                                    .measurements
                                    .length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              log(
                                ">>>>>>>>>>>>>>>>>???? --  controller.workoutDetail.value.measurements.length : ${controller.workoutDetail.value.measurements.length}",
                              );
                              if (index >=
                                  controller.measurementControllers.length) {
                                return const SizedBox.shrink(); // Safeguard against out-of-bounds
                              }
                              final measurements =
                                  controller
                                      .workoutDetail
                                      .value
                                      .measurements[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${measurements['name'] ?? 'Unknown'}",
                                        style: styleForText.copyWith(
                                          fontSize: 25,
                                          color:
                                              PrefsHelper.myRole == 'trainee'
                                                  ? ColorController.instance
                                                      .getTextColor()
                                                  : AppColors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "(${measurements['unit'] ?? 'Unknown'})",
                                        style: styleForText.copyWith(
                                          fontSize: 25,
                                          color:
                                              PrefsHelper.myRole == 'trainee'
                                                  ? ColorController.instance
                                                      .getTextColor()
                                                  : AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),

                                  CustomTextField(
                                    hintText: "",
                                    isSuffix: false,
                                    controller:
                                        controller
                                            .measurementControllers[index],
                                    backgroundColor:
                                        PrefsHelper.myRole == 'trainee'
                                            ? AppColors.traineeNavBArColor
                                            : const Color(0xff033a5b),

                                    onChanged: (value) {
                                      measurements['value'] =
                                          double.tryParse(value) ??
                                          measurements['value'];
                                      controller.workoutDetail.refresh();
                                      log(
                                        ">>>>>>>>>> measurements['value'] : ${measurements['value']}",
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          );
                        }),
                        const SizedBox(height: 10),
                        if (PrefsHelper.myRole == "trainee")
                          InkWell(
                            onTap: () {
                              controller.startWorkout();
                            },
                            child: CustomButton(
                              buttonText: AppString.startWorkout,
                              backgroundColor:
                                  PrefsHelper.myRole == "trainee"
                                      ? ColorController.instance
                                          .getButtonColor()
                                      : AppColors.secondary,
                              textColor:
                                  PrefsHelper.myRole == 'trainee'
                                      ? ColorController.instance.getTextColor()
                                      : AppColors.primary,
                            ),
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
