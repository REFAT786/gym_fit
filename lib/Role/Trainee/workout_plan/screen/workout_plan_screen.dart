import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Role/Trainee/workout_plan/screen/specific_workout_plan_screen.dart';


import '../../../../Common/widgets/custom_list_tile.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(AppString.workoutPlan, style: styleForText.copyWith(fontSize: 30),),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 5),
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: InkWell(
              onTap: (){Get.to(SpecificWorkoutPlanScreen());},
              child: CustomListTile(
                leadingImage: AppImages.serviceShortPhoto,
                title: "Chest",
                trailingIcon: Icons.arrow_forward_ios_outlined,
              ),
            ),
          );
        },)
      ),
    );
  }
}
