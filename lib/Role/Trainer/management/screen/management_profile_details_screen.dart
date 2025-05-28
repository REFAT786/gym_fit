import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Utils/app_url.dart';

import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_title_bar.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../controller/management_profile_details_controller.dart';

class ManagementProfileDetailsScreen extends StatelessWidget {
  ManagementProfileDetailsScreen({super.key});

  final ManagementProfileDetailsController controller = Get.find<ManagementProfileDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTrainerGradientBackgroundColor(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value, style: styleForText));
          }

          final detail = controller.managementDetail.value;
          if (detail == null) {
            return Center(child: Text('No trainee details available.', style: styleForText));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
                child: Column(
                  children: [
                    CustomTitleBar(title: AppString.trainerProfile),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondary, width: 2),
                      ),
                      child: ClipOval(
                        child: CustomCommonImage(
                          imageSrc: "${AppUrl.baseUrl}${detail.userDetails.image}",
                          imageType: ImageType.network,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      detail.userDetails.fullName,
                      style: styleForText.copyWith(fontSize: 25),
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
                    _buildProfileDetailItem('Age', detail.traineeDetails.age.toString()),
                    _buildProfileDetailItem('Gender', detail.traineeDetails.gender),
                    _buildProfileDetailItem('Weight', detail.traineeDetails.weight),
                    _buildProfileDetailItem('Height', detail.traineeDetails.height),
                    _buildProfileDetailItem('BMI', detail.traineeDetails.bmi.toString()),
                  ],
                ),
              ),
              // Add other UI widgets here as needed
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
          Text(
            value,
            style: TextStyle(color: AppColors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
