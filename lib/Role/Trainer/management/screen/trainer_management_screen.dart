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
  TrainerManagementScreen({super.key});

  final TrainerManagementController controller = Get.put(TrainerManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppString.traineeManagement,
              style: styleForText.copyWith(fontSize: 25),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              backgroundColor: PrefsHelper.myRole == 'trainee'
                  ? AppColors.traineeNavBArColor
                  : const Color(0xff033a5b),
              prefixIcon: Icons.search,
              hintText: AppString.searchForTrainee,
              isSuffix: false,
              controller: controller.searchController,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.filteredList.isEmpty) {
                  return Center(child: Text('No users found', style: styleForText));
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    final user = controller.filteredList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () => Get.to(() => ManagementProfileDetailsScreen(), arguments: {'id': user.id}),
                        child: CustomListTile(
                          leadingImage: user.image,
                          leadingImageHeight: double.infinity,
                          leadingImageWeight: 55,
                          title: user.fullName,
                          titleFontSize: 21,
                          leadingImageBorderRadius: 10,
                          trailingIcon: Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
