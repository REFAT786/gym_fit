import 'package:flutter/material.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../Common/widgets/custom_button.dart';
import '../../../../../Common/widgets/custom_text_field.dart';
import '../../../../../Common/widgets/custom_title_bar.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_images.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../../../../Trainee/color/controller/color_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTrainerGradientBackgroundColor(
        child: Column(
          children: [
            /// **Title Bar**
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 40),
              child: CustomTitleBar(title: AppString.editProfile),
            ),

            /// **Profile Content with Scrolling**
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// **Profile Picture with Edit Icon**
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(AppImages.serviceShortPhoto),
                        ),
                        Positioned(
                          bottom: 3,
                          right: 3,
                          child: GestureDetector(
                            onTap: () {
                              // Handle Profile Image Change
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// **Profile Fields**
                    CustomTextField(
                      backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                      hintText: AppString.enterName,
                      isSuffix: false,
                      controller: nameController,
                    ),

                    const SizedBox(height: 10),

                    /// **Phone Number Input**
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: IntlPhoneField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: AppString.phoneNumber,
                          hintStyle: styleForText.copyWith(
                            color: PrefsHelper.myRole=='trainee'?ColorController.instance.getTextColor():AppColors.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          fillColor: PrefsHelper.myRole=="trainee"?AppColors.traineeNavBArColor:AppColors.primary,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        dropdownTextStyle:  TextStyle(color: PrefsHelper.myRole=='trainee'?ColorController.instance.getTextColor():AppColors.textColor), // Country code in white
                        dropdownIcon:  Icon(Icons.arrow_drop_down, color: Colors.white), // Dropdown icon white
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// **Bottom Button**
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButton(
                buttonText: AppString.done,
                backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                textColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}