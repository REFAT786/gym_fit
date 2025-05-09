import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Common/widgets/custom_common_image.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../../../../Trainee/color/controller/color_controller.dart';
import '../../../../Trainee/color/screen/color_screen.dart';
import '../../change_password/screen/change_password_screen.dart';
import '../../edir_profile/screen/edit_profile_screen.dart';
import '../../help_center/screen/help_center_screen.dart';
import '../../language/screen/language_screen.dart';
import '../../privacy_policy/screen/privacy_policy_screen.dart';
import '../../terms_of_service/screen/terms_of_service_screen.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.find<ProfileController>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log(">>>>>>>>>>>>> Role: ${PrefsHelper.myRole}");

    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator(color: Colors.white,))
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: CustomCommonImage(
                            imageSrc: controller.profileImage.value.isNotEmpty
                                ? controller.profileImage.value
                                : '/uploads/users/user.png', // Fallback image
                            imageType: ImageType.network,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PrefsHelper.myRole == "trainee"
                          ? ColorController.instance.getButtonColor()
                          : AppColors.secondary,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: CustomCommonImage(
                      imageSrc: controller.profileImage.value.isNotEmpty
                          ? controller.profileImage.value
                          : '/uploads/users/user.png', // Fallback image
                      imageType: ImageType.network,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                controller.myName.value.isNotEmpty
                    ? controller.myName.value
                    : 'User Name', // Fallback name
                style: styleForText.copyWith(fontSize: 25),
              ),
              const SizedBox(height: 20),
              Container(
                color: PrefsHelper.myRole == "trainee"
                    ? AppColors.traineeNavBArColor
                    : AppColors.primary,
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.profileDetails.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var detail = controller.profileDetails[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              detail['label'],
                              style: TextStyle(
                                color: ColorController.instance.getTextColor(),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              detail['value'],
                              style: TextStyle(
                                color: ColorController.instance.getTextColor(),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuItem(AppString.editProfile, Icons.person_outline, EditProfileScreen()),
              _buildMenuItem(AppString.changePassword, Icons.lock, ChangePasswordScreen()),
              _buildMenuItem(AppString.language, Icons.language, LanguageScreen()),
              _buildMenuItem(AppString.helpCenter, Icons.help, HelpCenterScreen()),
              if (PrefsHelper.myRole == 'trainee')
                _buildMenuItem(AppString.color, Icons.color_lens, ColorScreen()),
              _buildMenuItem(AppString.termsOfService, Icons.miscellaneous_services_outlined, TermsOfServiceScreen()),
              _buildMenuItem(AppString.privacyPolicy, Icons.policy, PrivacyPolicyScreen()),
              InkWell(
                onTap: controller.logout,
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: PrefsHelper.myRole == "trainee"
                        ? ColorController.instance.getButtonColor()
                        : AppColors.secondary,
                  ),
                  title: Text(
                    AppString.logOutText,
                    style: styleForText.copyWith(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, Widget screen) {
    Color iconColor = PrefsHelper.myRole == "trainee"
        ? ColorController.instance.getButtonColor()
        : AppColors.secondary;
    return InkWell(
      onTap: () => Get.to(screen),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: styleForText.copyWith(fontSize: 18)),
      ),
    );
  }
}
