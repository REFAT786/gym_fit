import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Model/faq_model.dart';
import 'package:gym_fit/Services/get_api_service.dart';
import 'package:gym_fit/Utils/app_url.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../Helpers/other_helper.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Helpers/snackbar_helper.dart';
import '../../../../../Model/profile_model.dart';
import '../../../../../Repository/auth_repository.dart';
import '../../../../../Utils/app_string.dart';
import '../../../auth/sign_in/screen/sign_in_screen.dart';
import 'package:path/path.dart' as p;

class ProfileController extends GetxController {
  RxString profileImage = "".obs;
  RxString myName = "".obs;
  RxBool isLoading = false.obs;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final RxString imagePath = ''.obs;

  ProfileModel? profileModel;
  FAQModel? faqModel;

  final RxList<Map<String, dynamic>> profileDetails =
      [
        {'label': AppString.age, 'value': '24'},
        {'label': AppString.gender, 'value': 'Female'},
        {'label': AppString.weight, 'value': '75kg'},
        {'label': AppString.height, 'value': "5'11''"},
        {'label': AppString.bmi, 'value': '24.2'},
      ].obs;

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

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Fetch Profile and Initialize Text Fields
  Future<void> profile() async {
    try {
      isLoading.value = true;
      profileModel = await AuthRepository().getProfile();
      log("Success userName >>>>>>>>>>>>>>>>> : ${profileModel?.userName}");
      if (profileModel != null) {
        profileImage.value = profileModel!.image;
        myName.value = profileModel!.fullName;
        // Initialize text fields with profile data
        nameController.text = profileModel!.fullName;
        phoneController.text = profileModel!.phoneNumber; // Use phoneNumber
        log("Profile Image: ${profileModel!.image}");
        log("Profile Name: ${profileModel!.userName}");
        log("Profile Name: ${profileModel!.fullName}");
        log("Profile Phone: ${profileModel!.phoneNumber}");
        log("All Data: $profileModel");
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
      log("Profile fetch failed (Controller) e: $e");
      log("Profile fetch failed (Controller) s: $s");
    } finally {
      isLoading.value = false;
    }
  }

  ///================================================= Update Profile and Navigate Back
  Future<void> updateProfile() async {
    if (nameController.text.isEmpty) {
      SnackbarHelper.showError('Name is required');
      return;
    }

    // Validate image format
    if (imagePath.value.isNotEmpty) {
      String fileExtension = p.extension(imagePath.value).toLowerCase();
      if (![
        '.jpg',
        '.jpeg',
        '.png',
        '.heic',
        '.heif',
      ].contains(fileExtension)) {
        SnackbarHelper.showError(
          'Only jpg, png, jpeg, heic and heif formats are allowed',
        );
        return;
      }
    }

    isLoading.value = true;

    Map<String, String> body = {
      "data": jsonEncode({
        "fullName": nameController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
      }),
    };

    Map<String, String> header = {
      "Authorization": "Bearer ${PrefsHelper.token}",
      // ❌ No need to add 'Content-Type' manually
    };

    List<MultipartBody> multipartBody = [];

    if (imagePath.value.isNotEmpty) {
      print("mime type====> ${p.extension(imagePath.value)}");
      multipartBody.add(MultipartBody("image", File(imagePath.value)));
    }

    try {
      var response = await ApiClient.MultipartData(
        AppUrl.editProfile + PrefsHelper.userId,
        body,
        multipartBody: multipartBody,

        headers: header,
      );

      if(response.statusCode == 200){
        Get.back();
        profile();
        SnackbarHelper.showSuccess('Update Successfull');

      }

    } catch (e) {
      SnackbarHelper.showError('Failed to update profile: $e');
    }
  }


  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Change Password
  Future<void> changePassword() async {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      SnackbarHelper.showError('All fields are required');
      return;
    }

    if (newPass != confirmPass) {
      SnackbarHelper.showError(
        'New password and confirm password do not match',
      );
      return;
    }

    isLoading.value = true;
    final response = await AuthRepository().changePassword(
      oldPassword: oldPass,
      newPassword: newPass,
    );
    isLoading.value = false;

    if (response.success) {
      log("Success : ${response.success}");
      Get.back();
      SnackbarHelper.showSuccess(response.message);
    } else {
      SnackbarHelper.showError(response.message);
    }
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Log Out
  Future<void> logout() async {
    PrefsHelper.clear();
    Get.offAll(() => SignInScreen());
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
