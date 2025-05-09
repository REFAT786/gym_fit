import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Role/Trainer/profile/profile/controller/profile_controller.dart';

import '../../../../../Common/widgets/custom_back_button.dart';
import '../../../../../Common/widgets/custom_button.dart';
import '../../../../../Common/widgets/custom_text_field.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../../../../Trainee/color/controller/color_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: (){Get.back();},
                icon: CustomBackButton()
            ),
            title: Text(
              AppString.changePassword,
              style: styleForText.copyWith(
                  fontSize: 24
              ),
            ),

            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              CustomTextField(
                  backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                  prefixIcon: Icons.lock,
                  hintText: AppString.enterOldPassword,
                  isSuffix: true,
                  controller: controller.oldPasswordController),
              const SizedBox(height: 10),
              CustomTextField(
                  backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                  prefixIcon: Icons.lock,
                  hintText: AppString.enterNewPassword,
                  isSuffix: true,
                  controller: controller.newPasswordController),
              const SizedBox(height: 10),
              CustomTextField(
                  backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                  prefixIcon: Icons.lock,
                  hintText: AppString.confirmNewPassword,
                  isSuffix: true,
                  controller: controller.confirmPasswordController),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () => controller.changePassword(),
                  child: CustomButton(
                    buttonText: AppString.changePassword,
                    backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                    textColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.primary,
                  ))
            ],
          )
        ),
      ),
    );
  }
}
