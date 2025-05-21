import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Repository/user_repository.dart';

import '../../../Helpers/snackbar_helper.dart';

class OnBoardingController extends GetxController {
  var selectedGender = 'male'.obs;
  var selectedAge = 18.obs;
  var isCmSelected = true.obs;
  var selectedHeightCm = 170.obs;
  var selectedHeightInches = 67.obs;
  var isKgSelected = true.obs;
  var selectedWeightKg = 70.obs;
  var selectedWeightLbs = 154.obs;

  RxBool isLoading = false.obs;
  UserRepository userRepository = UserRepository();

  double get calculateBMI {
    double heightM = isCmSelected.value
        ? selectedHeightCm.value / 100.0
        : selectedHeightInches.value * 0.0254;
    double weightKg = isKgSelected.value
        ? selectedWeightKg.value.toDouble()
        : selectedWeightLbs.value * 0.453592;
    return weightKg / (heightM * heightM);
  }

  Future<void> bmiResult() async {

    try {
      isLoading.value = true;

      final response = await userRepository.bmiResult(
        gender: selectedGender.value,
        age: selectedAge.value,
        height: isCmSelected.value
            ? selectedHeightCm.value.toString()
            : selectedHeightInches.value.toString(),
        weight: isKgSelected.value
            ? selectedWeightKg.value.toString()
            : selectedWeightLbs.value.toString(),
      );

      if (response.statusCode == 200) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>> Response >>> ${response.data}");
        Get.offAllNamed(RoutesName.traineeNavBar);
        SnackbarHelper.show(
          title: "Success",
          message: response.message,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
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
