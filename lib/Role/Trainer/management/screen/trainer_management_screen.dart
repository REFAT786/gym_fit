import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Common/widgets/custom_list_tile.dart';
import '../../../../Common/widgets/custom_text_field.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../controller/trainer_management_controller.dart';
import 'management_profile_details_screen.dart';

class TrainerManagementScreen extends StatelessWidget {
  const TrainerManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerManagementController>(
      builder: (controller) {
        return Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40,),
                  Text(
                    AppString.traineeManagement,
                    style: styleForText.copyWith(fontSize: 25),
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                      backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                      prefixIcon: Icons.search, hintText: AppString.searchForTrainee, isSuffix: false, controller: controller.searchController),
                  SizedBox(height: 10,),
              
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {Get.to(ManagementProfileDetailsScreen());},
                          child: CustomListTile(
                            leadingImage: controller.leadingImage,
                            leadingImageHeight: double.infinity,
                            leadingImageWeight: 55,
                            title: controller.listTileTitle,
                            titleFontSize: 21,
                            leadingImageBorderRadius: 10,
                            trailingIcon: controller.trailingIcon,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}
