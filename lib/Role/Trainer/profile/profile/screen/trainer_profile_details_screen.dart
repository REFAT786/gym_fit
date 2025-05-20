import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Common/widgets/custom_common_image.dart';
import '../../../../../Common/widgets/custom_title_bar.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Common/widgets/custom_workout_list_tile.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/app_url.dart';
import '../../../../../Utils/styles.dart';
import '../../../workout/screen/add_workout_screen.dart';
import '../../../workout/screen/workout_details_screen.dart';
import '../controller/trainer_profile_details_controller.dart';

class TrainerProfileDetailsScreen extends StatelessWidget {
  TrainerProfileDetailsScreen({super.key});

  final TrainerProfileDetailsController controller = Get.put(
    TrainerProfileDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTrainerGradientBackgroundColor(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
          final detail = controller.traineeDetail.value;
          if (detail == null) {
            return const Center(child: Text('No trainee details available.'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 40,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    CustomTitleBar(title: AppString.trainerProfile),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondary,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: CustomCommonImage(
                          imageSrc:
                              '${AppUrl.baseUrl}${detail.userDetails.image}',
                          imageType: ImageType.network,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      detail.userDetails.fullName,
                      style: styleForText.copyWith(fontSize: 24),
                    ),
                  ],
                ),
              ),

              Container(
                color: AppColors.primary,
                height: 90,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildProfileDetailItem(
                      'Age',
                      detail.traineeDetails.age.toString(),
                    ),
                    _buildProfileDetailItem(
                      'Gender',
                      detail.traineeDetails.gender,
                    ),
                    _buildProfileDetailItem(
                      'Weight',
                      detail.traineeDetails.weight,
                    ),
                    _buildProfileDetailItem(
                      'Height',
                      detail.traineeDetails.height,
                    ),
                    _buildProfileDetailItem(
                      'BMI',
                      detail.traineeDetails.bmi.toString(),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  itemCount:
                      detail
                          .workout
                          .length, // You can implement workout list if available
                  itemBuilder: (context, index) {
                    var workDetails = detail.workout[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>workDetails.id ${workDetails.id}");
                          Get.to(() => WorkoutDetailsScreen(), arguments: {'id' : workDetails.id});
                        },
                        child: CustomWorkoutListTile(
                          isEditButton: true,
                          isArrowButton: false,
                          leadingImage:
                              '${AppUrl.baseUrl}${workDetails.exerciseImage}',
                          station: 'Station ${workDetails.stationNumber}',
                          gymCategory: workDetails.exerciseName,
                          gymSet:
                              workDetails.measurement.isNotEmpty
                                  ? '${workDetails.measurement[0].unit} ${workDetails.measurement[0].name} × ${workDetails.measurement[1].unit} ${workDetails.measurement[1].name}'
                                  : "",
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => AddWorkoutScreen());
                    },
                    icon: const Icon(Icons.add),
                    label: Text(
                      AppString.addWorkout,
                      style: styleForText.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildProfileDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(color: AppColors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
