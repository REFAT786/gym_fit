import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Helpers/prefs_helper.dart';
import 'package:gym_fit/Repository/auth_repository.dart';
import 'package:gym_fit/Utils/app_url.dart';
import '../../../../../Helpers/snackbar_helper.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find<SignInController>();
  RxBool enabled = false.obs;
  RxBool enabledqq = false.obs;
  TextEditingController emailTextEditingController = TextEditingController(text: kDebugMode ? 'hilizyjip@mailinator.com' : '');
  // TextEditingController emailTextEditingController = TextEditingController(text: kDebugMode ? 'rifatrahman@gmail.com' : '');
  TextEditingController passwordTextEditingController = TextEditingController(text: kDebugMode ? '123456' : "");
  var isLoading = false.obs;
  String role = "";
  RxBool isCompleted = false.obs;

  final AuthRepository signInRepository = AuthRepository();

  Future<void> logIn() async {
    final email = emailTextEditingController.text.trim();
    final password = passwordTextEditingController.text.trim();
    final userName = emailTextEditingController.text.trim(); // reuse email field for fullName if no '@'
    final pin = passwordTextEditingController.text.trim(); // reuse password field for pin

    if (email.isEmpty && userName.isEmpty) {
      SnackbarHelper.show(
        title: "Validation Error",
        message: "Please enter email or username",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    // check if input is email or fullName
    bool isEmail = email.contains('@');

    if (isEmail && password.isEmpty) {
      SnackbarHelper.show(
        title: "Validation Error",
        message: "Please enter password",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    } else if (!isEmail && pin.isEmpty) {
      SnackbarHelper.show(
        title: "Validation Error",
        message: "Please enter pin",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await signInRepository.logIn(
        email: isEmail ? email : "",
        password: isEmail ? password : "",
        userName: !isEmail ? userName : "",
        pin: !isEmail ? pin : "",
      );

      if (response.statusCode == 201|| response.statusCode ==200) {

        // enabled.value = response.data['attributes']['enabled'];
        isCompleted.value = response.data['attributes']['isCompleted'];
        log(">>>>>>>>>>> Enable : ========${enabled.value}");

        PrefsHelper.token = response.data['accessToken'];
        PrefsHelper.enabled =  response.data['attributes']['enabled'];
        PrefsHelper.myRole = response.data['attributes']['role'];
        PrefsHelper.userId = response.data['attributes']['_id'];
        PrefsHelper.myImage = "${AppUrl.baseUrl}${response.data['attributes']['image']}";
        PrefsHelper.myName = response.data['attributes']['fullName'];

        PrefsHelper.setString("token", PrefsHelper.token);
        PrefsHelper.setBool("enabled", PrefsHelper.enabled);
        PrefsHelper.setString("myRole", PrefsHelper.myRole);
        PrefsHelper.setString("userId", PrefsHelper.userId);
        PrefsHelper.setString("myImage", PrefsHelper.myImage);
        PrefsHelper.setString("myName", PrefsHelper.myName);


        if (PrefsHelper.myRole == "trainee") {
          if(isCompleted.value == true){
            Get.offAllNamed(RoutesName.traineeNavBar);
          }else{
            Get.toNamed(RoutesName.onBoarding);
          }

        } else if (PrefsHelper.myRole == "trainer") {
          Get.offAllNamed(RoutesName.navBar);
        } else {
          SnackbarHelper.show(
            title: "Required",
            message: response.message,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          isLoading.value = false;
        }
      } else {
        SnackbarHelper.show(
          title: "Error",
          message: response.message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e,s) {
      SnackbarHelper.show(
        title: "Error",
        message: "Login failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log("Login failed (Controller) e: $e");
      log("Login failed (Controller) s: $s");
    } finally {
      isLoading(false);
      update();
    }
  }

}
