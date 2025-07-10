import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Model/faq_model.dart';
import 'package:gym_fit/Services/get_api_service.dart';
import 'package:gym_fit/Utils/app_url.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../../../../../Helpers/other_helper.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Helpers/snackbar_helper.dart';
import '../../../../../Model/profile_model.dart';
import '../../../../../Repository/auth_repository.dart';
import '../../../auth/sign_in/screen/sign_in_screen.dart';

class ProfileController extends GetxController {
  RxString profileImage = "".obs;
  RxString myName = "".obs;
  RxBool isLoading = false.obs;
  RxBool isPhoneNumberLoading = false.obs;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  RxString countryCode = "".obs;

  final RxString imagePath = ''.obs;
  final RxString gender = ''.obs;
  final RxString height = ''.obs;
  final RxString weight = ''.obs;
  final Rx<num> age = 1.obs;
  final Rx<num> bmi = 1.obs;

  ProfileModel? profileModel;
  FAQModel? faqModel;

  @override
  void onInit() {
    super.onInit();
    profile();
  }

  Future<void> pickImage() async {
    final pickedImage = await OtherHelper.pickImage(ImageSource.gallery);
    if (pickedImage.isNotEmpty) {
      imagePath.value = pickedImage;
      log("Image picker: ${imagePath.value}");
    }
  }

  Future<void> profile() async {
    try {
      isLoading.value = true;
      profileModel = await AuthRepository().getProfile();
      if (profileModel != null) {
        profileImage.value = profileModel!.image;
        myName.value = profileModel!.fullName;

        nameController.text = profileModel!.fullName;
        phoneController.value.text = profileModel!.phoneNumber; // Set full phone number
        countryCode.value = profileModel!.countryCode;

        gender.value = profileModel!.gender;
        height.value = profileModel!.height;
        weight.value = profileModel!.weight;
        age.value = profileModel!.age;
        // bmi.value = profileModel!.bmi;

        log("Profile loaded: ${profileModel!.fullName}");
        log("Profile Gender: ${gender.value}");
        log("Profile Age: ${age.value}");
        log("Profile BMI: ${profileModel!.bmi}");
        log(">>>>>>>>>>>>>>>>>>>>Profile BMI: ${bmi.value}");
      } else {
        SnackbarHelper.show(
          title: "Error",
          message: "Failed to load profile data",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e, s) {
      SnackbarHelper.show(
        title: "Error",
        message: "Profile fetch failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log("Profile fetch failed: $e");
      log("Stacktrace: $s");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    if (nameController.text.trim().isEmpty) {
      SnackbarHelper.showError('Name is required');
      return;
    }

    if (imagePath.value.isNotEmpty) {
      final fileExtension = p.extension(imagePath.value).toLowerCase();
      if (!['.jpg', '.jpeg', '.png', '.heic', '.heif'].contains(fileExtension)) {
        SnackbarHelper.showError('Only jpg, png, jpeg, heic and heif formats are allowed');
        return;
      }
    }

    isLoading.value = true;

    final body = {
      "data": jsonEncode({
        "fullName": nameController.text.trim(),
        "phoneNumber": phoneController.value.text.trim(),
        "countryCode":countryCode.value,// Use the full phone number
        "gender": gender.value,
        "height": height.value,
        "weight": weight.value,
        "age": age.value,
      }),
    };

    final headers = {
      "Authorization": "Bearer ${PrefsHelper.token}",
    };

    final multipartBody = <MultipartBody>[];
    if (imagePath.value.isNotEmpty) {
      multipartBody.add(MultipartBody("image", File(imagePath.value)));
    }

    try {
      final response = await ApiClient.MultipartData(
        AppUrl.editProfile,
        body,
        multipartBody: multipartBody,
        headers: headers,
      );

      if (response.statusCode == 200) {
        PrefsHelper.myImage = "${AppUrl.baseUrl}${response.body['data']['image']}";
        PrefsHelper.setString("myImage", PrefsHelper.myImage);
        Get.back();
        await profile();
        SnackbarHelper.showSuccess('Update Successful');
      } else {
        SnackbarHelper.showError('Failed to update profile');
      }
    } catch (e) {
      SnackbarHelper.showError('Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword() async {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      SnackbarHelper.showError('All fields are required');
      return;
    }

    if (newPass != confirmPass) {
      SnackbarHelper.showError('New password and confirm password do not match');
      return;
    }

    isLoading.value = true;

    final response = await AuthRepository().changePassword(
      oldPassword: oldPass,
      newPassword: newPass,
    );

    isLoading.value = false;

    if (response.success) {
      Get.back();
      SnackbarHelper.showSuccess(response.message);
    } else {
      SnackbarHelper.showError(response.message);
    }
  }

  Future<void> logout() async {
    PrefsHelper.clear();
    Get.offAll(() => SignInScreen());
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.value.dispose();
    super.onClose();
  }
}