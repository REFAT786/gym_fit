import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Common/widgets/custom_common_image.dart';
import '../../../../../Common/widgets/custom_show_view_image.dart';
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
  ProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    log("Role: ${PrefsHelper.myRole}");

    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        body: Obx(
              () {
            if (profileController.isLoading.value) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => CustomShowViewImage(
                          imageUrl: profileController.profileImage.value,
                        ),
                      );
                    },
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PrefsHelper.myRole == "trainee"
                              ? ColorController.instance.getButtonColor()
                              : AppColors.secondary,
                          width: 4,
                        ),
                      ),
                      child: ClipOval(
                        child: CustomCommonImage(
                          imageSrc: profileController.profileImage.value.isNotEmpty
                              ? profileController.profileImage.value
                              : '/assets/images/noImage.png',
                          imageType: ImageType.network,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profileController.myName.value.isNotEmpty
                        ? profileController.myName.value
                        : 'User Name',
                    style: styleForText.copyWith(fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  if (PrefsHelper.myRole == 'trainee')
                    Container(
                      padding: EdgeInsets.all(20),
                      color: AppColors.traineeNavBArColor,
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppString.age,
                                style: TextStyle(
                                  color: ColorController.instance.getTextColor(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                profileController.age.value.toString(),
                                style: TextStyle(
                                  color: ColorController.instance.getTextColor(),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppString.gender,
                                style: TextStyle(
                                    color: ColorController.instance.getTextColor(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                profileController.gender.value,
                                style: TextStyle(
                                  color: ColorController.instance.getTextColor(),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppString.weight,
                                style: TextStyle(
                                    color: ColorController.instance.getTextColor(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                profileController.weight.value,
                                style: TextStyle(
                                  color: ColorController.instance.getTextColor(),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppString.height,
                                style: TextStyle(
                                    color: ColorController.instance.getTextColor(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                profileController.height.value,
                                style: TextStyle(
                                  color: ColorController.instance.getTextColor(),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppString.bmi,
                                style: TextStyle(
                                    color: ColorController.instance.getTextColor(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                profileController.profileModel!.bmi.toString(),
                                style: TextStyle(
                                  color: ColorController.instance.getTextColor(),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  const SizedBox(height: 10),
                  _buildMenuItem(AppString.editProfile, Icons.person_outline, EditProfileScreen()),
                  Divider(indent: 10, endIndent: 10),
                  _buildMenuItem(AppString.changePassword, Icons.lock, ChangePasswordScreen()),
                  Divider(indent: 10, endIndent: 10),
                  _buildMenuItem(AppString.language, Icons.language, LanguageScreen()),
                  Divider(indent: 10, endIndent: 10),
                  _buildMenuItem(AppString.helpCenter, Icons.help, HelpCenterScreen()),
                  Divider(indent: 10, endIndent: 10),
                  if (PrefsHelper.myRole == 'trainee')
                    _buildMenuItem(AppString.color, Icons.color_lens, ColorScreen()),
                  if (PrefsHelper.myRole == 'trainee') Divider(indent: 10, endIndent: 10),
                  _buildMenuItem(AppString.termsOfService, Icons.miscellaneous_services_outlined,
                      TermsOfServiceScreen()),
                  Divider(indent: 10, endIndent: 10),
                  _buildMenuItem(AppString.privacyPolicy, Icons.policy, PrivacyPolicyScreen()),
                  Divider(indent: 10, endIndent: 10),
                  InkWell(
                    onTap: profileController.logout,
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: PrefsHelper.myRole == "trainee"
                            ? ColorController.instance.getButtonColor()
                            : AppColors.secondary,
                      ),
                      title: Text(
                        AppString.logOutText,
                        style: styleForText.copyWith(color: Colors.red, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, Widget screen) {
    final iconColor = PrefsHelper.myRole == "trainee"
        ? ColorController.instance.getButtonColor()
        : AppColors.secondary;

    return InkWell(
      onTap: () => Get.to(screen),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: styleForText.copyWith(fontSize: 18)),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: PrefsHelper.myRole == "trainee"
              ? ColorController.instance.getTextColor()
              : AppColors.white,
        ),
      ),
    );
  }
}
