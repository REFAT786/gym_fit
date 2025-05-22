import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Common/widgets/custom_button.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Role/Trainer/workout/controller/workout_details_controller.dart';
import 'package:gym_fit/Utils/app_url.dart';
import 'package:video_player/video_player.dart';

import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainee/color/controller/color_controller.dart';
import '../../../Trainee/trainee_complete_successfully/screen/trainee_complete_successfully_screen.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  WorkoutDetailsScreen({super.key});

  TextEditingController setController = TextEditingController();
  TextEditingController resController = TextEditingController();
  TextEditingController wightController = TextEditingController();
  TextEditingController repController = TextEditingController();

  WorkoutDetailsController controller = Get.find<WorkoutDetailsController>();

  @override
  Widget build(BuildContext context) {
    log(">>>>>>>>>>>>>>>>>>>>>>>>> my role ${PrefsHelper.myRole}");
    log(
      ">>>>>>>>>>>>>>>>>>>>>>>>> Exercise name  ${controller.workoutDetail.value.exerciseName}",
    );
    log(
      ">>>>>>>>>>>>>>>>>>>>>>>>> Exercise name  ${controller.workoutDetail.value.id}",
    );
    // var workOut = controller.workoutDetail.value;
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
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
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
          child: Column(
            children: [
              // SizedBox(height: 40),
              Column(
                children: [
                  // Obx(() => Text("???????????????????${controller.workoutDetail.value.measurements[0]['unit']}"),),
                  SizedBox(height: 10),
                  Obx(() {
                    return Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // border: Border.all(color: AppColors.secondary, width: 2),
                        borderRadius: BorderRadius.circular(16),
                        // color: AppColors.primary
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
                              )
                              : Center(child: Text("No video available")),
                    );
                  }),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                                : "No Station Number",
                            style: styleForText.copyWith(fontSize: 25),
                          );
                        }),
                        Obx(() {
                          return Text(
                            controller.workoutDetail.value.stations.isNotEmpty
                                ? controller
                                    .workoutDetail
                                    .value
                                    .stations[0]['name']
                                    .toString()
                                : "No Station Name",
                            style: styleForText.copyWith(fontSize: 25),
                          );
                        }),
                        Text(
                          AppString.targetMuscles,
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        SizedBox(height: 10),
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

                        SizedBox(height: 10),
                        Text(
                          "Description",
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        SizedBox(height: 10),
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.all(10),
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
                              ),
                            ),
                          );
                        }),
                        Text(
                          AppString.equipment,
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        SizedBox(height: 10),

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
                        SizedBox(height: 10),
                        Text(
                          "Equipment Description",
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        SizedBox(height: 10),
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.all(10),
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
                              ),
                            ),
                          );
                        }),

                        SizedBox(height: 10),

                        Obx(() {
                          return ListView.builder(
                            itemCount: controller.workoutDetail.value.measurements.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var measurements = controller.workoutDetail.value.measurements[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${measurements['name']}",
                                  style: styleForText.copyWith(fontSize: 25),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                    PrefsHelper.myRole == 'trainee'
                                        ? AppColors.traineeNavBArColor
                                        : Color(0xff033a5b),
                                  ),
                                  child: Text(
                                    "${measurements['unit']}",
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
                                )

                              ],
                            );
                          },);
                        },),



                        SizedBox(height: 10),

                        if (PrefsHelper.myRole == "trainee")
                          InkWell(
                            onTap: () {
                              Get.toNamed(RoutesName.trainingPageOne);
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

                        SizedBox(height: 10),

                        // Text(
                        //   AppString.notes,
                        //   style: styleForText.copyWith(fontSize: 25),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(5),
                        //   height: 100,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     color: PrefsHelper.myRole == "trainee"
                        //         ? AppColors.traineeNavBArColor
                        //         : AppColors.primary,
                        //   ),
                        //   child: TextField(
                        //     maxLines: 3,
                        //     style: TextStyle(color: Colors.white),
                        //     decoration: InputDecoration(
                        //       hintText: AppString.notes,
                        //       hintStyle: styleForText.copyWith(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w400,),
                        //       border: OutlineInputBorder(
                        //         borderSide: BorderSide.none,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Text(
                        //   AppString.history,
                        //   style: styleForText.copyWith(fontSize: 25),
                        // ),
                        // ListView.builder(
                        //   padding: EdgeInsets.all(0),
                        //   itemCount: 5,
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemBuilder: (context, index) {
                        //     return Padding(
                        //       padding: const EdgeInsets.only(bottom: 10),
                        //       child: CustomHistoryContainer(),
                        //     );
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // InkWell(
                        //     onTap: () {
                        //       Get.to(TraineeCompleteSuccessfullyScreen());
                        //     },
                        //     child: CustomButton(
                        //       buttonText: AppString.finishWorkout,
                        //       backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                        //       textColor: PrefsHelper.myRole == 'trainee'
                        //           ? ColorController.instance.getTextColor()
                        //           : AppColors.primary,
                        //     ))
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
