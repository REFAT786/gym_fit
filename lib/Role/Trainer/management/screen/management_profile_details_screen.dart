import 'package:flutter/material.dart';


import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_title_bar.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';

class ManagementProfileDetailsScreen extends StatelessWidget {
  ManagementProfileDetailsScreen({super.key});

  final String profileImage = AppImages.serviceShortPhoto;

  // Define the data for the list dynamically
  final List<Map<String, dynamic>> profileDetails = [
    {'label': AppString.age, 'value': '24'},
    {'label': AppString.gender, 'value': 'Female'},
    {'label': AppString.weight, 'value': '75kg'},
    {'label': AppString.height, 'value': "5'11''"},
    {'label': AppString.bmi, 'value': '24.2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTrainerGradientBackgroundColor(
        child: Column(
          children: [
            // SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
              child: Column(
                children: [
                  CustomTitleBar(title: AppString.trainerProfile),
                  // SizedBox(height: 10,),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.secondary, width: 2),
                    ),
                    child: ClipOval(child: CustomCommonImage(imageSrc: profileImage, imageType: ImageType.network,)),
                  ),

                  SizedBox(height: 5,),

                  Text(
                    "Mr Gym",
                    style: styleForText.copyWith(fontSize: 25),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              child: SizedBox(
                height: 90,
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: profileDetails.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var detail = profileDetails[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            detail['label'],
                            style: styleForText.copyWith(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            detail['value'],
                            style: styleForText.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            // SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }
}
