import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';

class ColorController extends GetxController {
  static ColorController get instance => Get.put(ColorController());

  var selectedBgColor = "default".obs;
  var selectedButtonColor = "default".obs;
  var selectedTextColor = "default".obs;

  var customBgColor = AppColors.black.obs;
  var customButtonColor = AppColors.traineePrimaryColor.obs;
  var customTextColor = AppColors.white.obs;

  final Map<String, Color> bgColorMap = {
    "black": Colors.black,
    "grey": Colors.grey,
    "blue": Colors.blue,
    "red": Colors.red,
    "custom": Colors.transparent, // Placeholder, overridden by customBgColor
    "default": AppColors.black, // Fixed default background color
  };

  final Map<String, Color> buttonColorMap = {
    "black": Colors.black,
    "grey": Colors.grey,
    "blue": Colors.blue,
    "red": Colors.red,
    "custom": Colors.transparent, // Placeholder, overridden by customButtonColor
    "default": AppColors.traineePrimaryColor, // Fixed default button color
  };

  final Map<String, Color> textColorMap = {
    "black": Colors.black,
    "white": Colors.white,
    "custom": Colors.transparent, // Placeholder, overridden by customTextColor
    "default": AppColors.white, // Fixed default text color
  };

  @override
  void onInit() {
    super.onInit();
    _loadSavedColor();
  }

  Future<void> _loadSavedColor() async {
    await PrefsHelper.getAllPrefData();
    selectedBgColor.value = PrefsHelper.selectedBgColor;
    selectedButtonColor.value = PrefsHelper.selectedButtonColor;
    selectedTextColor.value = PrefsHelper.selectedTextColor;

    customBgColor.value = Color(PrefsHelper.customBgColor);
    customButtonColor.value = Color(PrefsHelper.customButtonColor);
    customTextColor.value = Color(PrefsHelper.customTextColor);
    update(); // Ensure UI updates after loading
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Change Color >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  void changeBgColor(String colorName) async {
    selectedBgColor.value = colorName;
    PrefsHelper.selectedBgColor = colorName;
    await PrefsHelper.setString("selectedBgColor", colorName);
    log("Background Color Changed: $colorName");
    update();
  }

  void changeButtonColor(String colorName) async {
    selectedButtonColor.value = colorName;
    PrefsHelper.selectedButtonColor = colorName;
    await PrefsHelper.setString("selectedButtonColor", colorName);
    log("Button Color Changed: $colorName");
    update();
  }

  void changeTextColor(String colorName) async {
    selectedTextColor.value = colorName;
    PrefsHelper.selectedTextColor = colorName;
    await PrefsHelper.setString("selectedTextColor", colorName);
    log("Text Color Changed: $colorName");
    update();
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Set Color >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  void setCustomBgColor(Color color) async {
    customBgColor.value = color;
    await PrefsHelper.setInt("customBgColor", color.value);
    log("Custom Background Color Updated: $color");
    update();
  }

  void setCustomButtonColor(Color color) async {
    customButtonColor.value = color;
    await PrefsHelper.setInt("customButtonColor", color.value);
    log("Custom Button Color Updated: $color");
    update();
  }

  void setCustomTextColor(Color color) async {
    customTextColor.value = color;
    await PrefsHelper.setInt("customTextColor", color.value);
    log("Custom Text Color Updated: $color");
    update();
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get Color >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Color getBgColor() {
    log("Selected Background Color: ${selectedBgColor.value}");
    if (selectedBgColor.value == "custom") {
      return customBgColor.value;
    }
    return bgColorMap[selectedBgColor.value] ?? AppColors.black;
  }

  Color getButtonColor() {
    log("Selected Button Color: ${selectedButtonColor.value}");
    if (selectedButtonColor.value == "custom") {
      return customButtonColor.value;
    }
    return buttonColorMap[selectedButtonColor.value] ??
        AppColors.traineePrimaryColor;
  }

  Color getTextColor() {
    log("Selected Text Color: ${selectedTextColor.value}");
    if (selectedTextColor.value == "custom") {
      return customTextColor.value;
    }
    return textColorMap[selectedTextColor.value] ?? AppColors.white;
  }

  Color getHintTextColor() {
    log("Selected Text Color: ${selectedTextColor.value}");
    if (selectedTextColor.value == "custom") {
      return customTextColor.value;
    }
    return textColorMap[selectedTextColor.value] ?? AppColors.hintGrey;
  }

}
