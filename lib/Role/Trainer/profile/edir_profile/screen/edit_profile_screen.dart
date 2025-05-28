import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Helpers/other_helper.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../Common/widgets/custom_button.dart';
import '../../../../../Common/widgets/custom_text_field.dart';
import '../../../../../Common/widgets/custom_title_bar.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../../../../Trainee/color/controller/color_controller.dart';
import '../../profile/controller/profile_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();
  final ColorController colorController = Get.find<ColorController>();

  // Helper method to extract country code and phone number
  PhoneNumber? _parsePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) return null;
    try {
      // Assuming phone is in format "+8801949494949"
      // Use the intl_phone_field package's PhoneNumber class to parse
      return PhoneNumber.fromCompleteNumber(completeNumber: phone);
    } catch (e) {
      log("Error parsing phone number: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        body: Obx(() {
          return Column(
            children: [
              /// Title Bar
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 40),
                child: CustomTitleBar(title: AppString.editProfile),
              ),

              /// Profile Content with Scrolling
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// Profile Picture with Edit Icon
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: controller.imagePath.value.isEmpty
                                ? NetworkImage(controller.profileImage.value)
                                : FileImage(File(controller.imagePath.value)),
                          ),
                          Positioned(
                            bottom: 3,
                            right: 3,
                            child: GestureDetector(
                              onTap: controller.pickImage,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: PrefsHelper.myRole == "trainee"
                                      ? colorController.getButtonColor()
                                      : AppColors.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(Icons.edit, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      /// Name Field
                      CustomTextField(
                        backgroundColor: PrefsHelper.myRole == 'trainee'
                            ? AppColors.traineeNavBArColor
                            : const Color(0xff033a5b),
                        hintText: AppString.enterName,
                        isSuffix: false,
                        controller: controller.nameController,
                        validator: OtherHelper.validator,
                      ),

                      const SizedBox(height: 10),

                      /// Phone Number Input
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: controller.countryCode.value.isNotEmpty &&
                            controller.isPhoneNumberLoading.value?Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  20),
                            ),
                          ),
                        ):IntlPhoneField(
                          controller: controller.phoneController.value,
                          validator: (value) => OtherHelper.validator(value?.number),
                          decoration: InputDecoration(
                            labelStyle: styleForText.copyWith(color: Colors.white, fontSize: 16),
                            counterText: "",
                            hintText: AppString.phoneNumber,
                            hintStyle: styleForText.copyWith(
                              fontWeight: FontWeight.w500,
                              color: PrefsHelper.myRole == "trainee"
                                  ? ColorController.instance.getHintTextColor()
                                  : AppColors.hintGrey,
                              fontSize: 16,
                            ),
                            fillColor: PrefsHelper.myRole == "trainee"
                                ? AppColors.traineeNavBArColor
                                : AppColors.primary,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          initialCountryCode: controller.countryCode.value.isNotEmpty
                              ? controller.countryCode.value
                              : 'US',
                          initialValue: controller.phoneController.value.text.isNotEmpty
                              ? controller.phoneController.value.text
                              : null,
                          onChanged: (phone) {
                            controller.countryCode.value = phone.countryISOCode;
                            controller.phoneController.value.text = phone.number;
                            controller.update();
                          },
                          style: styleForText.copyWith(
                            color: PrefsHelper.myRole == 'trainee'
                                ? ColorController.instance.getTextColor()
                                : AppColors.textColor,
                            fontSize: 16,
                          ),
                          dropdownTextStyle: TextStyle(
                            color: PrefsHelper.myRole == 'trainee'
                                ? colorController.getTextColor()
                                : AppColors.textColor,
                          ),
                          dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                        ),

                      ),
                    ],
                  ),
                ),
              ),

              /// Bottom Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomButton(
                  isLoading: controller.isLoading.value,
                  buttonText: AppString.done,
                  backgroundColor: PrefsHelper.myRole == "trainee"
                      ? colorController.getButtonColor()
                      : AppColors.secondary,
                  textColor: PrefsHelper.myRole == "trainee"
                      ? colorController.getTextColor()
                      : AppColors.primary,
                  onTap: (){controller.updateProfile();},
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}