import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Core/routes/routes_name.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainer/workout/controller/workout_details_controller.dart';
import '../../color/controller/color_controller.dart';

class RestScreen extends StatefulWidget {
  RestScreen({super.key});

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  final WorkoutDetailsController controller =
      Get.find<WorkoutDetailsController>();

  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = Get.arguments['date'];
    log(">>>>>>>>>>>>>>>>>>>> date : $date");
    controller.startTimer();
  }

  String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

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
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            "Set ${controller.index.value} of ${controller.totalSets.value}",
                            style: styleForText.copyWith(fontSize: 25),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.stopTimer();
                            controller.remainingSeconds.value = 0;
                          },
                          child: Chip(
                            label: Text(
                              "Skip Rest",
                              style: styleForText.copyWith(
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                            backgroundColor: Colors.black,
                            side: BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            size: 40,
                            color: Colors.white,
                          ),
                          Obx(() {
                            if (controller.remainingSeconds.value == 0) {
                              // Timer stopped
                              return Text(
                                "00:00",
                                style: styleForText.copyWith(fontSize: 40),
                              );
                            } else {
                              return Text(
                                formatDuration(
                                  controller.remainingSeconds.value,
                                ),
                                style: styleForText.copyWith(fontSize: 40),
                              );
                            }
                          }),
                          SizedBox(height: 5),
                          Text(
                            "Rest Time Remaining",
                            style: styleForText.copyWith(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Complete Sets",
                      style: styleForText.copyWith(fontSize: 24),
                    ),
                    ...List.generate(controller.index.value , (index) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              PrefsHelper.myRole == 'trainee'
                                  ? AppColors.traineeNavBArColor
                                  : const Color(0xff033a5b),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Set ${index + 1} | $date",
                              style: styleForText.copyWith(fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...List.generate(
                                  controller
                                      .workoutDetail
                                      .value
                                      .measurements
                                      .length,
                                  (valueIndex) {
                                    var data =
                                        controller
                                            .workoutDetail
                                            .value
                                            .measurements[valueIndex];
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: [
                                          Text(
                                            data["name"],
                                            style: styleForText.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            data["unit"].toString(),
                                            style: styleForText.copyWith(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                // Column(
                                //   children: [
                                //     Text("Reps", style: styleForText.copyWith(fontSize: 18, fontWeight:FontWeight.w400),),
                                //     Text("12", style: styleForText.copyWith(fontSize: 18),),
                                //   ],
                                // ),
                                // Column(
                                //   children: [
                                //     Text("Sets", style: styleForText.copyWith(fontSize: 18, fontWeight:FontWeight.w400),),
                                //     Text("5", style: styleForText.copyWith(fontSize: 18),),
                                //   ],
                                // ),
                                // Column(
                                //   children: [
                                //     Text("Weight(Kg)", style: styleForText.copyWith(fontSize: 18, fontWeight:FontWeight.w400),),
                                //     Text("30", style: styleForText.copyWith(fontSize: 18),),
                                //   ],
                                // ),
                                // Column(
                                //   children: [
                                //     Text("Rest", style: styleForText.copyWith(fontSize: 18, fontWeight:FontWeight.w400),),
                                //     Text("00.59", style: styleForText.copyWith(fontSize: 18),),
                                //   ],
                                // ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    Text(
                      "Current Set",
                      style: styleForText.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 5),
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
                                  measurements['name'] == "rest" ||
                                          measurements['name'] == "rests"
                                      ? measurements['defaultValue'].toString()
                                      : measurements['unit'].toString(),
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
                    SizedBox(height: 10),
                    Obx(() {
                      final isButtonEnabled =
                          controller.remainingSeconds.value == 0;
                      return IgnorePointer(
                        ignoring: !isButtonEnabled,
                        child: Opacity(
                          opacity: isButtonEnabled ? 1.0 : 0.5,
                          child: CustomButton(
                            buttonText:
                                "Complete Set ${controller.index.value}",
                            backgroundColor:
                                PrefsHelper.myRole == "trainee"
                                    ? ColorController.instance.getButtonColor()
                                    : AppColors.secondary,
                            textColor:
                                PrefsHelper.myRole == 'trainee'
                                    ? ColorController.instance.getTextColor()
                                    : AppColors.primary,
                            onTap: () {
                              if (isButtonEnabled) {
                                controller.index.value++;
                                if (controller.index.value >
                                    controller.totalSets.value) {
                                  Get.toNamed(RoutesName.completeSuccessful);
                                  controller.index.value = 1;
                                } else {
                                  Get.back();
                                }
                              }
                            },
                          ),
                        ),
                      );
                    }),
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
