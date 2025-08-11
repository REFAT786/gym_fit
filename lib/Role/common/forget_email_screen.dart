import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Helpers/other_helper.dart';
import 'package:gym_fit/Utils/styles.dart';

import '../../Common/widgets/custom_button.dart';
import '../../Common/widgets/custom_text_field.dart';
import '../../Common/widgets/custom_title_bar.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_string.dart';
import 'controller/forget_controller.dart';

class ForgetEmailScreen extends StatelessWidget {
  ForgetEmailScreen({super.key});
  ForgetController controller = Get.find<ForgetController>();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var status = Get.arguments['status'];
    controller.status.value = status;
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
              child: Column(
                children: [
                  Text(
                    "Verify your identity",
                    style: styleForText.copyWith(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "In order to verify your identity, we'll send you a\n code to your preferred method below.",
                      textAlign: TextAlign.center,
                      style: styleForText.copyWith(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: formKey,
                    child: CustomTextField(
                      validator: (value) => OtherHelper.emailValidator(value),
                      backgroundColor: AppColors.primary,
                      hintText: AppString.enterEmailText, //AppString.enterEmailText,
                      controller: controller.emailTextEditingController,
                      isSuffix: false,
                    ),
                  ),

                  SizedBox(height: 40),
                  Obx(() => CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.forgetPassword();
                      }
                    },
                    isLoading: controller.isLoading.value,
                    buttonText: status == "password"?AppString.forgetPassword: AppString.forgetPin,
                    textColor: AppColors.primary,
                    backgroundColor: AppColors.secondary,
                  ),),
                ],
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
