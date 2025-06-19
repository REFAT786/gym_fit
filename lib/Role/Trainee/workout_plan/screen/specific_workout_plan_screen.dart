import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Role/Trainee/workout_plan/screen/workout_plan_detail_screen.dart';
import 'package:gym_fit/Utils/app_string.dart';
import 'package:gym_fit/Utils/app_url.dart';


import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Common/widgets/custom_workout_list_tile.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/styles.dart';
import '../../color/controller/color_controller.dart';
import '../controller/specific_workout_plan_controller.dart';

class SpecificWorkoutPlanScreen extends StatelessWidget {
   SpecificWorkoutPlanScreen({super.key});
  SpecificWorkoutPlanController controller = Get.find<SpecificWorkoutPlanController>();

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: (){Get.back();}, icon: CustomBackButton()),
          title: Text(controller.name.value, style: styleForText.copyWith(fontSize: 24, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),),
          centerTitle: true,
        ),
        body: Obx(
              () {
                if (controller.isLoading.value) {
                  // Show loading spinner while data is loading
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            // Check if the workout list is empty or null
            if (controller.specificWorkoutList.isEmpty) {
              return  Center(
                child: Text(
                  'No workouts available',
                  style: styleForText.copyWith(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the total number of workouts
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    '${controller.specificWorkoutList.length} ${AppString.exercises}',
                    style: styleForText.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                  ),
                ),
                // List of workouts
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemCount: controller.specificWorkoutList.length,
                    itemBuilder: (context, index) {
                      final workout = controller.specificWorkoutList[index];
                      return InkWell(
                        onTap: () => Get.toNamed(RoutesName.workoutPlanDetail, arguments: {'id':workout.id}),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CustomWorkoutListTile(
                            isEditButton: false,
                            isArrowButton: true,
                            leadingImage: "${AppUrl.baseUrl}${workout.exerciseImage}",
                            gymCategory: workout.name
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),

      ),
    );
  }
}
