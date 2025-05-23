import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainer/workout/screen/workout_details_screen.dart';
import '../../home/widget/custom_workout_plan_container.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
          AppString.history,
          style: styleForText.copyWith(fontSize: 24),
        ),
        centerTitle: true,
      ),

      body: CustomTrainerGradientBackgroundColor(
        child: ListView.builder(
          padding: EdgeInsets.all(14),
          // itemCount: controller.workoutList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
          // final workout = controller.workoutList[index];
          return Container(child: Text("data", style: styleForText,),);
          //   CustomWorkoutPlanContainer(
          //   workout: workout,
          //   isButton: false,
          //   startWorkoutTap: () {
          //     Get.to(() => WorkoutDetailsScreen());
          //     // Get.to(() => WorkoutDetailsScreen(), arguments: {'id': workout.id});
          //   },
          // );
        },),
      ),

    );
  }
}
