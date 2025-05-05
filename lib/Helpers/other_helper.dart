import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class OtherHelper {
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');

  static String? validator(value) {
    if (value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? emailValidator(
    value,
  ) {
    if (value!.isEmpty) {
      return "This field is required".tr;
    } else if (!emailRegexp.hasMatch(value)) {
      return "Enter valid email".tr;
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required".tr;
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters long".tr;
    }

    final RegExp passRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (!passRegExp.hasMatch(value)) {
      return "Password must contain at least:\n- 1 uppercase letter\n- 1 lowercase letter\n- 1 number\n- 1 special character (@\$!%*?&)"
          .tr;
    }

    return null;
  }

  static String? confirmPasswordValidator(value, passwordController) {
    if (value.isEmpty) {
      return "This field is required".tr;
    } else if (value != passwordController.text) {
      return "The password does not match".tr;
    } else {
      return null;
    }
  }

  //Pick Image
  static Future<String> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);
      return pickedFile?.path ?? "";
    } catch (e) {
      log("Error selecting image: $e");
    }
    return "";
  }

  // Pick Single File
  static Future<String> pickSingleFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      return result?.files.single.path ?? "";
    } catch (e) {
      log("Error selecting file: $e");
    }
    return "";
  }



}
