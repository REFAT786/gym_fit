import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_icons.dart';
import '../../../Trainer/profile/profile/screen/profile_screen.dart';
import '../../color/controller/color_controller.dart';
import '../../home/screen/trainee_home_screen.dart';
import '../../workout_plan/screen/workout_plan_screen.dart';
import '../../workout_progress/screen/workout_progress_screen.dart';
import '../controller/trainee_nav_bar_controller.dart';

class TraineeNavBarScreen extends StatelessWidget {
  TraineeNavBarScreen({super.key});

  final TraineeNavBarController traineeNavBarController = Get.put(TraineeNavBarController());

  @override
  Widget build(BuildContext context) {
    log(">>>>>>>>>>>>>>>>>>>>>>>>> my role ${PrefsHelper.myRole}");
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                // Switch between screens based on active tab
                if (traineeNavBarController.isHomeActive.value) {
                  return const TraineeHomeScreen();
                } else if (traineeNavBarController.isWorkoutPlanActive.value) {
                  return const WorkoutPlanScreen();
                }else if (traineeNavBarController.isProgressActive.value) {
                  return const WorkoutProgressScreen();
                } else if (traineeNavBarController.isProfileActive.value) {
                  return ProfileScreen();
                }
                return const SizedBox();
              }),
            ),
            KeyboardVisibilityBuilder(builder: (p0, isKeyboardVisible) {
              return isKeyboardVisible? SizedBox():Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Obx(() {
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: ColorController.instance.getButtonColor(),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                traineeNavBarController.updateActiveTab('home');
                              },
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: traineeNavBarController.isHomeActive.value
                                    ? AppColors.traineeNavBArColor
                                    : AppColors.white,
                                child: Icon(
                                  Icons.home,
                                  size: 34,
                                  color: traineeNavBarController.isHomeActive.value
                                      ? AppColors.white
                                      : AppColors.traineeNavBArColor,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                traineeNavBarController.updateActiveTab('workout_plan');
                              },
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: traineeNavBarController.isWorkoutPlanActive.value
                                    ? AppColors.traineeNavBArColor
                                    : AppColors.white,
                                child: SvgPicture.asset(
                                  AppIcons.workoutPlanIcon,
                                  colorFilter: ColorFilter.mode(
                                    traineeNavBarController.isWorkoutPlanActive.value
                                        ? AppColors.white
                                        : AppColors.traineeNavBArColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                traineeNavBarController.updateActiveTab('progress');
                              },
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: traineeNavBarController.isProgressActive.value
                                    ? AppColors.traineeNavBArColor
                                    : AppColors.white,
                                child: SvgPicture.asset(
                                  AppIcons.progress,
                                  colorFilter: ColorFilter.mode(
                                    traineeNavBarController.isProgressActive.value
                                        ? AppColors.white
                                        : AppColors.traineeNavBArColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                traineeNavBarController.updateActiveTab('profile');
                              },
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: traineeNavBarController.isProfileActive.value
                                    ? AppColors.traineeNavBArColor
                                    : AppColors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 34,
                                  color: traineeNavBarController.isProfileActive.value
                                      ? AppColors.white
                                      : AppColors.traineeNavBArColor,
                                ),
                              ),
                            ),
                          ],
                        )
                    );
                  },)
              );
            },),

          ],
        ),
      ),
    );
  }
}
