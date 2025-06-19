import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_add_workout_popup.dart';
import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/app_url.dart';
import '../../../../Utils/styles.dart';
import '../../color/controller/color_controller.dart';
import '../controller/workout_plan_detail_controller.dart';

class WorkoutPlanDetailScreen extends StatelessWidget {
  WorkoutPlanDetailScreen({super.key});

  final WorkoutPlanDetailController controller = Get.find<WorkoutPlanDetailController>();

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: CustomBackButton(),
          ),
          title: Obx(() => Text(
            controller.specificList.isNotEmpty
                ? controller.specificList[0].name
                : 'Workout Plan',
            style: styleForText.copyWith(fontSize: 24, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
          )),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: styleForText.copyWith(color: Colors.red),
              ),
            );
          }
          if (controller.specificList.isEmpty) {
            return const Center(child: Text('No workout data available'));
          }

          final workout = controller.specificList[0];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Workout Image
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CustomCommonImage(
                    imageSrc: "${AppUrl.baseUrl}${workout.exerciseImage}",
                    imageType: ImageType.network,
                  ),
                ),
                const SizedBox(height: 20),

                // Target Muscles
                Text(
                  AppString.targetMuscles,
                  style: styleForText.copyWith(fontSize: 25, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                ),
                const SizedBox(height: 10),



                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: workout.muscleGroup.map((muscle) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      muscle.mgName,
                      style: styleForText.copyWith(fontSize: 16, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 20),

                // Description
                Text(
                  "${AppString.whatIs} ${workout.name}",
                  style: styleForText.copyWith(fontSize: 25, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: PrefsHelper.myRole == 'trainee'
                        ? AppColors.traineeNavBArColor
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    workout.description,
                    style: styleForText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Equipment
                Text(
                  AppString.equipment,
                  style: styleForText.copyWith(fontSize: 25, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  workout.equipment.equipmentName,
                  style: styleForText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white
                  ),
                ),
                const SizedBox(height: 20),

                // Instructions
                Text(
                  AppString.instructions,
                  style: styleForText.copyWith(fontSize: 25, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  workout.instructions,
                  style: styleForText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white
                  ),
                ),
                const SizedBox(height: 20),

                // Add Workout Button (for non-trainees)
                if (PrefsHelper.myRole != 'trainee')
                  CustomButton(
                    backgroundColor: AppColors.secondary,
                    textColor: ColorController.instance.getTextColor(),
                    buttonText: AppString.addWorkout,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomAddWorkoutPopup(),
                      );
                    },
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}