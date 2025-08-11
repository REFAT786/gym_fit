import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';

import '../../../../../Common/widgets/custom_button.dart';
import '../../../../../Common/widgets/custom_text_field.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../controller/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final controller = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // This will resize the screen when the keyboard opens
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff056aa6), Color(0xff035c86), Color(0xff02304b)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1.0], // Smooth blending
            )
        ),
        child: SingleChildScrollView( // Wrap the body with SingleChildScrollView
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Image(image: AssetImage(AppIcons.fitnessLogo), height: 46, width: 46),
              SizedBox(height: 10),
              Text(AppString.loginTitleText, style: styleForText.copyWith(fontSize: 36, color: AppColors.white)),
              SizedBox(height: 20),
              CustomTextField(
                backgroundColor: AppColors.primary,
                hintText: AppString.emailUsername,//AppString.enterEmailText,
                controller:controller.emailTextEditingController,
                isSuffix: false,
              ),
              SizedBox(height: 20),
              CustomTextField(
                backgroundColor: AppColors.primary,
                hintText: AppString.passwordPin,//AppString.enterPasswordText,
                controller: controller.passwordTextEditingController,
                isSuffix: true,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () { Get.toNamed(RoutesName.chooseForgetScreen); },
                  child: Text(AppString.forgetPasswordPin,style: styleForText.copyWith(fontSize: 14, color: AppColors.white)),),
              ),
              SizedBox(height: 50),
              Obx(() => InkWell(
                onTap: () => controller.logIn(),
                child: CustomButton(
                  buttonText: AppString.logInText,
                  textColor: AppColors.primary,
                  backgroundColor: AppColors.secondary,
                  isLoading: controller.isLoading.value,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
