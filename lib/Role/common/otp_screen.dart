import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Role/common/controller/forget_controller.dart';

import '../../Common/widgets/custom_button.dart';
import '../../Common/widgets/custom_text_field.dart';
import '../../Common/widgets/custom_title_bar.dart';
import '../../Helpers/other_helper.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_string.dart';
import '../../Utils/styles.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  ForgetController controller = Get.find<ForgetController>();

  @override
  Widget build(BuildContext context) {
    var emailArg = Get.arguments;

    // Start the timer when the OTP screen is loaded
    controller.startResendTimer();

    log(">>>>>>>>>>>>> Email : ${controller.emailTextEditingController.text}");
    log(">>>>>>>>>>>>> purpose : ${controller.status.value}");

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff056aa6), Color(0xff035c86), Color(0xff02304b)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  Text(
                    "Check your email",
                    style: styleForText.copyWith(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "We sent an OTP to\n $emailArg",
                      textAlign: TextAlign.center,
                      style: styleForText.copyWith(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 50),
                  OtpTextField(
                    numberOfFields: 4,
                    fieldWidth: 53.w,
                    fieldHeight: 55.h,
                    filled: true,
                    fillColor: AppColors.primary,
                    contentPadding: EdgeInsets.all(2),
                    textStyle: styleForText.copyWith(
                      fontSize: 24.sp,
                      color: AppColors.textColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    borderColor: AppColors.primary,
                    disabledBorderColor: AppColors.primary,
                    focusedBorderColor: AppColors.primary,
                    enabledBorderColor: AppColors.primary,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      controller.otpCode = code; // Assign OTP code to controller
                    },
                    onSubmit: (String otp) {
                      controller.otpCode = otp; // Assign OTP code to controller
                    },
                  ),
                  SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Didn’t receive the code? ",
                              style: styleForText.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return controller.showResendButton.value
                            ? TextButton(
                          onPressed: controller.resendOtp,
                          child: Text(
                            AppString.resendOtp,
                            style: styleForText.copyWith(
                              fontSize: 18.sp,
                              color: AppColors.secondary,
                            ),
                          ),
                        )
                            : Text(
                          " ${controller.remainingTime.value} s",
                          style: styleForText.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.secondary,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 30),
                  Obx(() => CustomButton(
                    onTap: () {
                      controller.verifyOtp();
                    },
                    isLoading: controller.isLoading.value,
                    buttonText: AppString.verifyOtp,
                    textColor: AppColors.primary,
                    backgroundColor: AppColors.secondary,
                  )),
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
