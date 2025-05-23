import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Model/wrok_out_model.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../color/controller/color_controller.dart';
import '../../../../Utils/app_url.dart';

class CustomWorkoutPlanContainer extends StatelessWidget {
  final WorkOutModel workout;
  final bool isButton;
  final VoidCallback? startWorkoutTap;

  const CustomWorkoutPlanContainer({
    super.key,
    required this.workout,
    this.startWorkoutTap,
    this.isButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.traineeNavBArColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(workout.exerciseName, style: styleForText.copyWith(fontSize: 20.sp)),
              Text(
                workout.stations.isNotEmpty
                    ? "Station ${workout.stations[0]['number']}"
                    : 'No Station',
                style: styleForText.copyWith(fontSize: 20.sp),
              ),
            ],
          ),
          Divider(color: AppColors.white),

          // Main Row (Image + Training Goals)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exercise Image
              CustomCommonImage(
                imageSrc: "${AppUrl.baseUrl}${workout.exerciseImage}",
                imageType: ImageType.network,
                height: 170,
                width: 125,
              ),
              const SizedBox(width: 10),

              // Training Goals & Types
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.trainingGoals,
                      style: styleForText.copyWith(fontSize: 20.sp),
                    ),

                    // Muscle Groups List (Horizontally scrollable)
                    SizedBox(
                      height: 75,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: workout.muscleGroups.length,
                        itemBuilder: (context, index) {
                          final mg = workout.muscleGroups[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Column(
                              children: [
                                Text(
                                  mg.name,
                                  style: styleForText.copyWith(fontSize: 12),
                                ),
                                const SizedBox(height: 3),
                                CustomCommonImage(
                                  imageSrc: "${AppUrl.baseUrl}${mg.image}",
                                  imageType: ImageType.network,
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Training Type Title
                    Text(
                      AppString.trainingType,
                      style: styleForText.copyWith(fontSize: 20.sp),
                    ),

                    // Workout Types Icons horizontally scrollable
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: workout.workoutTypes.length,
                        itemBuilder: (context, index) {
                          final wt = workout.workoutTypes[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                CustomCommonImage(imageSrc: "${AppUrl.baseUrl}${wt.image}", imageType: ImageType.network,height: 44.h, width: 44.w, ),
                                const SizedBox(width: 5),
                                Text(
                                  wt.name,
                                  style: styleForText.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          );

                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),

          if(isButton == true)
            InkWell(
              onTap: startWorkoutTap,
              child: Obx(() {
                return CustomButton(
                  borderRadius: 12,
                  buttonText: AppString.startWorkout,
                  textColor: ColorController.instance.getTextColor(),
                  backgroundColor: PrefsHelper.myRole == "trainee"
                      ? ColorController.instance.getButtonColor()
                      : AppColors.secondary,
                );
              }),
            ),
        ],
      ),
    );

  }
}
