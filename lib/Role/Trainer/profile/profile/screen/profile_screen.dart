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
  ProfileScreen({super.key});

  // final String profileImage = AppImages.serviceShortPhoto;
  final ProfileController profileController = Get.find(); // Ensure controller is initialized


  final List<Map<String, dynamic>> profileDetails = [
    {'label': AppString.age, 'value': '24'},
    {'label': AppString.gender, 'value': 'Female'},
    {'label': AppString.weight, 'value': '75kg'},
    {'label': AppString.height, 'value': "5'11''"},
    {'label': AppString.bmi, 'value': '24.2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
         // bool isDefault = ColorController.instance.selectedButtonColor.value=="default";
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Role : ${PrefsHelper.myRole}");
        return CustomTrainerGradientBackgroundColor(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  /// **Profile Image with Dynamic Border Color**
                GestureDetector(
                  onTap: () {
                    // Open the full-screen profile picture (e.g., using a dialog or a new screen)
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: CustomCommonImage(imageSrc: profileController.profileImage.value, imageType: ImageType.network,height: double.infinity, width: double.infinity,)//Image.network(profileController.profileImage.value),
                            ),
                          ),
                        );
                      },
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
                        imageSrc: profileController.profileImage.value,
                        imageType: ImageType.network,
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 10),

                  /// **Title**
                  Text(
                    "Mr Gym",
                    style: styleForText.copyWith(fontSize: 25),
                  ),

                  const SizedBox(height: 20),

                  /// **Profile Details**
                  Container(
                    decoration: BoxDecoration(
                      color: PrefsHelper.myRole == "trainee"
                          ? AppColors.traineeNavBArColor
                          : AppColors.primary,
                    ),
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: profileDetails.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var detail = profileDetails[index];
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(detail['label'],
                                    style: TextStyle(
                                        color: ColorController.instance.getTextColor(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                const SizedBox(height: 10),
                                Text(detail['value'],
                                    style: TextStyle(
                                        color: ColorController.instance.getTextColor(), fontSize: 18)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// **Profile Menu with Dynamic Icon Colors**
                  _buildMenuItem(
                    AppString.editProfile,
                    Icons.person_outline,
                    "",
                    EditProfileScreen(),
                    PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                    //ColorController.instance.getButtonColor()
                  ),

                  _buildMenuItem(
                    AppString.changePassword,
                    Icons.lock,
                    "",
                    ChangePasswordScreen(),
                    PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                  ),

                  _buildMenuItem(
                    AppString.language,
                    Icons.language,
                    "",
                    LanguageScreen(),
                    PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                  ),

                  _buildMenuItem(
                      AppString.helpCenter,
                      Icons.help,
                      "",
                      HelpCenterScreen(),
                    PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                  ),
                  if (PrefsHelper.myRole == 'trainee')
                    _buildMenuItem(
                        AppString.color,
                        Icons.color_lens,
                        "",
                        ColorScreen(),
                      PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                    ),
                  _buildMenuItem(
                      AppString.termsOfService,
                      Icons.miscellaneous_services_outlined,
                      "",
                      TermsOfServiceScreen(),
                    PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                  ),
                  _buildMenuItem(
                      AppString.privacyPolicy,
                      Icons.policy,
                      "",
                      PrivacyPolicyScreen(),
                    PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                  ),

                  /// **Logout Button**
                  InkWell(
                    onTap: () {
                      profileController.logout();
                    },
                    child: ListTile(
                      leading: Icon(Icons.logout, color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,),
                      title: Text(AppString.logOutText,
                          style: styleForText.copyWith(
                              color: Colors.red, fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// **Reusable Profile Menu Item**
  Widget _buildMenuItem(
      String title, IconData icon, String rightTitle, Widget screen, Color iconColor) {
    return InkWell(
      onTap: () => Get.to(screen),
      child: ListTile(
        leading: Icon(icon, color: iconColor), // 🔥 Dynamic Icon Color
        title: Text(title, style: styleForText.copyWith(fontSize: 18,)),
        trailing: rightTitle.isNotEmpty ? Text(rightTitle) : null,
      ),
    );
  }
}
