import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_icons.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../color/controller/color_controller.dart';

class CustomWorkoutPlanContainer extends StatelessWidget {
  CustomWorkoutPlanContainer({super.key, this.startWorkoutTap});

  final String stationText = "Station 1";
  final String mainTitle = "Lat Pull Down";
  Function()? startWorkoutTap;

  final List<Map<String, dynamic>> training = [
    {'name': "Back", "image": AppImages.serviceShortPhoto},
    {'name': "Bicep", "image": AppImages.serviceShortPhoto},
    {'name': "R.Delt", "image": AppImages.serviceShortPhoto},
    {'name': "Traps", "image": AppImages.serviceShortPhoto},
    {'name': "Core", "image": AppImages.serviceShortPhoto},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
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
              Text(mainTitle, style: styleForText.copyWith(fontSize: 20)),
              Text(stationText, style: styleForText.copyWith(fontSize: 20)),
            ],
          ),

          Divider(color: AppColors.white),

          // Main Row (Image + Training Goals)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              CustomCommonImage(
                imageSrc: AppImages.serviceShortPhoto,
                imageType: ImageType.network,
                height: 190,
                width: 130,
              ),
              SizedBox(width: 10),

              // Training Goals & Types
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.trainingGoals, style: styleForText.copyWith(fontSize: 20)),

                    // Horizontally Scrollable List
                    SizedBox(
                      height: 83, // Fixed height to prevent layout errors
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(0),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(training.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Text(
                                    training[index]['name'],
                                    style: styleForText.copyWith(fontSize: 12),
                                  ),
                                  SizedBox(height: 3),
                                  CustomCommonImage(
                                    imageSrc: training[index]['image'],
                                    imageType: ImageType.network,
                                    height: 50,
                                    width: 50,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    // Training Type Title
                    Text(AppString.trainingType, style: styleForText.copyWith(fontSize: 20)),

                    // Horizontally Scrollable Training Type Icons
                    SizedBox(
                      height: 40,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTrainingTypeItem(AppIcons.strengthIcon, "Strength"),
                            _buildTrainingTypeItem(AppIcons.stretchingIcon, "Stretching"),
                            _buildTrainingTypeItem(AppIcons.cardioIcon, "Cardio"),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),

          InkWell(
            onTap: startWorkoutTap,
            child: Obx(() {
              return CustomButton(
                buttonText: AppString.startWorkout,
                textColor: ColorController.instance.getTextColor(),
                backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
              );
            },),
          ),
        ],
      ),
    );
  }

  /// Helper function to create training type items
  Widget _buildTrainingTypeItem(String iconPath, String title) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Row(
        children: [
          SvgPicture.asset(iconPath, height: 24, width: 24),
          SizedBox(width: 5),
          Text(
            title,
            style: styleForText.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
