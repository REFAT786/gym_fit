import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Helpers/prefs_helper.dart';
import 'package:gym_fit/Repository/auth_repository.dart';

class ForgetController extends GetxController{

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isResendOtp = false.obs;
  AuthRepository authRepository = AuthRepository();

  late String otpCode;
  RxBool showResendButton = false.obs;
  RxString status = "".obs;
  final RxInt remainingTime = 60.obs;
  Timer? timer;

  // Starts the resend timer
  void startResendTimer() {
    remainingTime.value = 60; // Reset to 60 seconds when starting the timer
    showResendButton.value = false;

    // This will periodically decrease the remainingTime value every second.
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        showResendButton.value = true; // Allow the user to resend OTP
        timer.cancel(); // Stop the timer when it reaches zero.
      }
    });
  }

  // Stops the timer (used during cleanup)
  void stopTimer() {
    timer?.cancel();
  }

  Future<void> forgetPassword () async{
    isLoading.value = true;
    try{
        final response = await authRepository.forgetPassword(
          email: emailTextEditingController.text
        );
        if (response.statusCode == 201|| response.statusCode ==200) {
          log(">> Successful : ======== ${response.message}");
          Get.toNamed(RoutesName.otpScreen, arguments: emailTextEditingController.text);
        }else{
          Get.snackbar("Error", response.message);
        }

    }catch(e,s){
      log(">>>>>>>>>> Error e : $e");
      log(">>>>>>>>>> Error s : $s");
    }finally{
      isLoading.value = false;
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OTP >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<void> verifyOtp() async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> body1 = {
        "email" : emailTextEditingController.text,
        "otp":otpCode,
        "purpose" : "forget-password"
        // "purpose" : "resend-otp"
      };

      final Map<String, dynamic> body2 = {
        "email" : emailTextEditingController.text,
        "otp":otpCode,
        // "purpose" : "forget-password"
        "purpose" : "resend-otp"
      };

      final response = isResendOtp.value == true?await authRepository.otp(body: body2): await authRepository.otp(body: body1);
      if (response.statusCode == 200) {
        log(">>>>>>>>>>>>>>> Success 200");
        PrefsHelper.token = response.data['forgetPasswordToken'];
        log(">>>>>>>>> Token =========== ${PrefsHelper.token}");
        PrefsHelper.setString('token', PrefsHelper.token);
        Get.offAllNamed(RoutesName.newPasswordScreen);

      } else {
        log(">>>>>>>>>>>>>>> Error 200");
        Get.snackbar("Error", response.message);
      }
    } catch (e, s) {
      log("Error E : $e");
      log("Error S : $s");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    // isLoading.value = true;

    final Map<String, dynamic> body = {
      "email" : emailTextEditingController.text,
    };

    try {
      final response = await authRepository.resendOtp(body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("OTP Resend Successfully: $response");
        isResendOtp.value = true;
        log("isResendOtp : ====== ${isResendOtp.value}");
        Get.snackbar("Success", "OTP Resend otp.", backgroundColor: Colors.green, colorText: Colors.white);
        startResendTimer();
      } else {
        Get.snackbar("Error", "Failed to resend OTP.", backgroundColor: Colors.red, colorText: Colors.white);
      }

    } catch (e,s) {
      log("Resend OTP Failed e: $e");
      log("Resend OTP Failed s: $s");
      Get.snackbar("Error", "Failed to resend OTP. Please try again.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      // isLoading.value = false;
    }
  }


  Future<void> resetPassPin () async{
    isLoading.value = true;

    try{

      final Map<String, dynamic> body1 = {
        "email": emailTextEditingController.text,
        "password":newPasswordController.text
      };
      final Map<String, dynamic> body2 = {
        "email": emailTextEditingController.text,
        "pin":newPasswordController.text
      };
      final response = status.value=="password"
          ?await authRepository.resetPassword(body: body1)
          :await authRepository.resetPin(body: body2);
      if (response.statusCode == 201|| response.statusCode ==200) {
        log(">> Successful : ======== ${response.message}");
        Get.offAllNamed(RoutesName.login);
        Get.snackbar("Success", response.message);
      }else{
        Get.snackbar("Error", response.message);
      }

    }catch(e,s){
      log(">>>>>>>>>> Error e : $e");
      log(">>>>>>>>>> Error s : $s");
    }finally{
      isLoading.value = false;
    }
  }

}