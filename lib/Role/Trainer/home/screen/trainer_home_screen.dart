import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_list_tile.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../notification/screen/notification_screen.dart';
import '../controller/trainer_home_controller.dart';

class TrainerHomeScreen extends StatelessWidget {
  const TrainerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerHomeController>(
      builder: (controller) {
        return Scaffold(

          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    CustomCommonImage(
                      imageSrc: controller.profileImage,
                      imageType: ImageType.network,
                      borderRadius: 55,
                      height: 55,
                      width: 55,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.profileName,
                            style: styleForText.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            AppString.letsPush,
                            style: styleForText.copyWith(
                              fontSize: 25,
                            ),overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        onPressed: () {Get.to(NotificationScreen());},
                        icon: const Icon(
                          Icons.notifications,
                          size: 35,
                        ),
                        color: AppColors.secondary,
                      ),
                    )
                  ],
                ),
            
                const SizedBox(height: 20),
            
                /// Assign Trainees Title
                Text(
                  AppString.assignTrainees.tr,
                  style: styleForText.copyWith(fontSize: 24),
                ),
            
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () => controller.showListDetails(),
                        child: CustomListTile(
                          leadingImage: controller.leadingImage,
                          leadingImageHeight: double.infinity,
                          leadingImageWeight: 55,
                          title: controller.listTileTitle,
                          titleFontSize: 18,
                          leadingImageBorderRadius: 10,
                          trailingIcon: controller.trailingIcon,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}
