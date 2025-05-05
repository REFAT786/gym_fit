import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Helpers/prefs_helper.dart';
import '../Role/Trainee/color/controller/color_controller.dart';
import 'app_colors.dart';

TextStyle get styleForText {
  final ColorController colorController = Get.find<ColorController>(); // Access the controller

  return TextStyle(
    color: PrefsHelper.myRole=="trainee"?colorController.getTextColor():AppColors.white, // Dynamically fetch text color
    fontSize: 20,
    fontFamily: 'Outfit',
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    height: 1.5,
    letterSpacing: 0.0,
  );
}