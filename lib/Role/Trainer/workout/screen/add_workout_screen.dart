import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Role/Trainer/workout/controller/workout_details_controller.dart';
import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_text_field.dart';
import '../../../../Common/widgets/custom_title_bar.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Helpers/snackbar_helper.dart';
import '../../../../Model/history_model.dart';
import '../../../../Model/search_workout_response.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/app_url.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainee/color/controller/color_controller.dart';
import '../../profile/profile/controller/trainer_profile_details_controller.dart';

class AddWorkoutScreen extends StatefulWidget {
  AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}


class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final WorkoutDetailsController controller = Get.find<WorkoutDetailsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.searchWorkout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                backgroundColor: AppColors.secondary,
                textColor: AppColors.primary,
                buttonText: AppString.addWorkout,
                onTap: () {
                  controller.searchController.text.isNotEmpty
                      ? controller.addWorkout()
                      : SnackbarHelper.show(
                    title: "Warning",
                    message: "Please search",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                backgroundColor: Colors.transparent,
                textColor: AppColors.white,
                buttonText: AppString.cancel,
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),

      body: CustomTrainerGradientBackgroundColor(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleBar(title: AppString.addWorkout),

              const SizedBox(height: 10),
              Text(AppString.selectExercise, style: styleForText.copyWith(fontSize: 24)),
              const SizedBox(height: 5),

              // Search field: NO Obx needed because TextField doesn't reactively change UI
              CustomTextField(
                backgroundColor: PrefsHelper.myRole == 'trainee' ? AppColors.traineeNavBArColor : Color(0xff033a5b),
                prefixIcon: Icons.search,
                hintText: AppString.searchWorkout,
                isSuffix: false,
                controller: controller.searchController,
                onChanged: (value){
                  controller.onSearchChanged(value: value);
                },
              ),


              // Expanded widget to constrain list height and make it scrollable
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  }
                  if (controller.searchResults.isEmpty) {
                    return Center(child: Text("No results found", style: styleForText.copyWith(color: AppColors.white),));
                  }
                  return ListView.builder(
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      ExerciseModel exercise = controller.searchResults[index];
                      return ListTile(
                        leading: exercise.exerciseImage.isNotEmpty
                            ? Image.network(
                          "${exercise.exerciseImage.startsWith('http') ? '' : AppUrl.baseUrl}${exercise.exerciseImage}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                            : SizedBox(width: 50, height: 50),
                        title: Text(exercise.name, style: styleForText.copyWith(fontSize: 16, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),),
                        subtitle: Text(exercise.description, style: styleForText.copyWith(fontSize: 14, fontWeight: FontWeight.w500,color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),),
                        onTap: () {

                          controller.searchController.text = exercise.name;
                          controller.searchResults.clear();
                          controller.exerciseId.value = exercise.id;
                          log(">>>>>>>>>>>>>>>> Excercise Id : ${exercise.id}");
                          log(">>>>>>>>>>>>>>>> Trainee Id : ${TrainerProfileDetailsController.instance.traineeId}");
                          controller.traineeId.value = TrainerProfileDetailsController.instance.traineeId;
                        },
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 10),


            ],
          ),
        ),
      ),
    );
  }
}
