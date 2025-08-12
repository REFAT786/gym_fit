import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gym_fit/Role/common/controller/forget_controller.dart';

import '../../Common/widgets/custom_button.dart';
import '../../Common/widgets/custom_text_field.dart';
import '../../Common/widgets/custom_title_bar.dart';
import '../../Helpers/other_helper.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_string.dart';
import '../../Utils/styles.dart';

class NewPasswordScreen extends StatelessWidget {
   NewPasswordScreen({super.key});

  ForgetController controller = Get.find<ForgetController>();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff056aa6), Color(0xff035c86), Color(0xff02304b)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0], // Smooth blending
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      controller.status.value == "password"?"Create new password":"Create new pin",
                      style: styleForText.copyWith(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    // Center(
                    //   child: Text(
                    //     "Your new password must be different to\n previously used passwords.",
                    //     textAlign: TextAlign.center,
                    //     style: styleForText.copyWith(fontSize: 18),
                    //   ),
                    // ),
                    SizedBox(height: 50),
                   CustomTextField(
                        validator: (value) => OtherHelper.validator(value),
                        backgroundColor: AppColors.primary,
                        hintText: controller.status.value == "password"?AppString.enterNewPassword: "New Pin",
                        controller: controller.newPasswordController,
                        isSuffix: false,
                      ),
                    SizedBox(height: 20,),
                    CustomTextField(
                      validator: (value) => OtherHelper.confirmPasswordValidator(value, controller.newPasswordController),
                      backgroundColor: AppColors.primary,
                      hintText: controller.status.value == "password"?AppString.confirmNewPassword:"Confirm New Pin",
                      controller: controller.confirmPasswordController,
                      isSuffix: false,
                    ),

                    SizedBox(height: 40),
                    Obx(() => CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // controller.status == "password"?controller.
                          controller.resetPassPin();
                        }
                      },
                      isLoading: controller.isLoading.value,
                      buttonText: AppString.continueText,
                      textColor: AppColors.primary,
                      backgroundColor: AppColors.secondary,
                    ),),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 16),
                child: CustomTitleBar(title: ""),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
