import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Role/Trainee/workout_plan/screen/workout_plan_detail_screen.dart';


import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Common/widgets/custom_workout_list_tile.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/styles.dart';

class SpecificWorkoutPlanScreen extends StatelessWidget {
  const SpecificWorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: (){Get.back();}, icon: CustomBackButton()),
          title: Text("Chest Workout", style: styleForText.copyWith(fontSize: 24),),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
          return InkWell(
            onTap: (){Get.to(WorkoutPlanDetailScreen());},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomWorkoutListTile(isEditButton: false,isArrowButton: true,leadingImage: AppImages.serviceShortPhoto, gymCategory: "Lat Pull Down",),
              ));
        },)
      ),
    );
  }
}
