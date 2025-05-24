import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Role/Trainee/workout_plan/screen/specific_workout_plan_screen.dart';
import 'package:gym_fit/Utils/app_url.dart';
import 'package:gym_fit/Common/widgets/custom_list_tile.dart';
import 'package:gym_fit/Common/widgets/custom_trainer_gradient_background_color.dart';
import 'package:gym_fit/Utils/app_string.dart';
import 'package:gym_fit/Utils/styles.dart';
import '../controller/workout_plan_controller.dart';

class WorkoutPlanScreen extends StatelessWidget {
  WorkoutPlanScreen({super.key});

  final WorkoutPlanController controller = Get.find<WorkoutPlanController>();

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppString.workoutPlan,
            style: styleForText.copyWith(fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: controller.muscleList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final muscle = controller.muscleList[index];
            log('Muscle Data: id=${muscle.id}, name=${muscle.name}, image=${AppUrl.baseUrl}${muscle.image}');
            return Padding(
              padding: const EdgeInsets.all(5),
              child: InkWell(
                onTap: () => Get.to(
                      () => SpecificWorkoutPlanScreen(),
                  arguments: {'name': muscle.name},
                ),
                child: CustomListTile(
                  leadingImage: '${AppUrl.baseUrl}${muscle.image}',
                  title: muscle.name,
                  trailingIcon: Icons.arrow_forward_ios_outlined,
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}