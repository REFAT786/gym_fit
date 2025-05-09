import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static SnackbarController show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: position,
      duration: duration,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  static SnackbarController showError(String message) {
    return show(
      title: 'Error',
      message: message,
      backgroundColor: Colors.red,
    );
  }

  static SnackbarController showSuccess(String message) {
    return show(
      title: 'Success',
      message: message,
      backgroundColor: Colors.green,
    );
  }
}
