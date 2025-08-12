import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Common/widgets/custom_text_field.dart';

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
  const RestScreen({super.key});

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
    // Defer startTimer to after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startTimer();
    });
  }

  @override
  void dispose() {
    controller.stopTimer(); // Stop timer when leaving the screen
    super.dispose();
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
                            "${AppString.set} ${controller.index.value} ${AppString.of} ${controller.totalSets.value}",
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
                              AppString.skipRest,
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
                            AppString.restTimeRemaining,
                            style: styleForText.copyWith(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppString.completeSets,
                      style: styleForText.copyWith(fontSize: 24),
                    ),

                    ...List.generate(controller.sets.length, (index) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
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
                              "${AppString.set} ${index + 1}",
                              style: styleForText.copyWith(fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ...List.generate(
                                  controller.sets[index]["measurements"].length, (valueIndex) {
                                    var data = controller.sets[index]["measurements"][valueIndex];
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: [
                                          Text(data["name"], style: styleForText.copyWith(fontSize: 18, fontWeight: FontWeight.w400,),),
                                          Text(data["value"].toString(), style: styleForText.copyWith(fontSize: 18,),),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),

                    SizedBox(height: 10),
                    Text(
                      AppString.currentSet,
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
                                controller.restKeywords.contains(
                                      measurements['name']
                                          .toString()
                                          .toLowerCase(),
                                    )
                                    ? AppString.restTime
                                    : measurements['name'],
                                style: styleForText.copyWith(fontSize: 18),
                              ),

                              CustomTextField(
                                hintText: '',
                                isSuffix: false,
                                controller: controller.measurementControllers[index],
                                backgroundColor: PrefsHelper.myRole == 'trainee' ? AppColors.traineeNavBArColor : const Color(0xff033a5b),
                                  onChanged: (value) {
                                    final parsedValue = double.tryParse(value);

                                    final name = (measurements['name'] ?? '').toString().toLowerCase();

                                    log("Field Changed => name: $name, value: $parsedValue");

                                    if (controller.setKeywords.contains(name)) {
                                      log("Matched Set Keyword: $name");
                                      controller.totalSets.value = parsedValue?.toDouble() ?? controller.totalSets.value;
                                    }

                                    if (controller.restKeywords.contains(name)) {
                                      final newVal = parsedValue ?? controller.timer.value;
                                      if (newVal != controller.timer.value) {
                                        controller.timer.value = newVal;

                                        log("Timer updated: $newVal minutes, remainingSeconds set to ${controller.remainingSeconds.value}");
                                      }
                                    }

                                    // Update measurement value
                                    controller.workoutDetail.value.measurements[index]['value'] = parsedValue ??
                                        controller.workoutDetail.value.measurements[index]['value'];

                                    controller.workoutDetail.refresh();
                                  },

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
                                "${AppString.completeSet} ${controller.index.value}",
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
                                  RxList workList = [].obs;
                                  bool showWarning = false;

                                  for (var measurement in controller.workoutDetail.value.measurements) {
                                    final name = (measurement['name'] ?? '').toString().toLowerCase();

                                    if (controller.setKeywords.contains(name)) {
                                      final value = measurement['value'];
                                      final numericValue = double.tryParse(value.toString());

                                      if (numericValue != null &&
                                          numericValue < controller.index.value.toDouble()) {
                                        Get.snackbar(
                                          "Warning",
                                          "Set value must be greater than step value ${controller.index.value}",
                                          backgroundColor: Colors.deepOrange,
                                          colorText: Colors.white,
                                        );
                                        showWarning = true;
                                        break; // Exit the loop, don’t proceed
                                      }

                                      controller.totalSets.value = numericValue ?? 1.0;
                                    }

                                    workList.add({
                                      "name": name,
                                      "value": measurement["value"],
                                      "unit": measurement["unit"],
                                    });
                                  }

                                  if (showWarning) return; // Stop further execution if warning shown

                                  controller.sets.add({
                                    "name": "Set ${controller.sets.length + 1}",
                                    "measurements": workList,
                                  });

                                  controller.index.value++;

                                  log("sets data==== index====${controller.sets.length}===========${controller.sets}");

                                  if (controller.index.value > controller.totalSets.value) {
                                    Get.toNamed(RoutesName.completeSuccessful);
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
