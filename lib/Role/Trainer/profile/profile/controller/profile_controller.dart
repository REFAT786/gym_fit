import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Model/faq_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Helpers/other_helper.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Helpers/snackbar_helper.dart';
import '../../../../../Model/profile_model.dart';
import '../../../../../Repository/auth_repository.dart';
import '../../../../../Utils/app_string.dart';
import '../../../auth/sign_in/screen/sign_in_screen.dart';

class ProfileController extends GetxController {
  RxString profileImage = "".obs;
  RxString myName = "".obs;
  RxBool isLoading = false.obs;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final RxString imagePath = ''.obs;

  ProfileModel? profileModel;
  FAQModel? faqModel;

  final RxList<Map<String, dynamic>> profileDetails = [
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
    if (profileModel != null) {
      nameController.text = profileModel!.fullName;
      // phoneController.text = profileModel!.phoneNumber ?? '';
      imagePath.value = profileModel!.image;
    }
  }

  Future<void> pickImage() async {
    final pickedImage = await OtherHelper.pickImage(ImageSource.gallery);
    if (pickedImage.isNotEmpty) {
      imagePath.value = pickedImage;
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Profile   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<void> profile() async {
    try {
      isLoading.value = true;
      profileModel = await AuthRepository().getProfile();
      log("Success userName >>>>>>>>>>>>>>>>> : ${profileModel?.userName}");
      if (profileModel != null) {
        profileImage.value = profileModel!.image;
        myName.value = profileModel!.fullName;
        log("Profile Image: ${profileModel!.image}");
        log("Profile Name: ${profileModel!.userName}");
        log("Profile Name: ${profileModel!.fullName}");
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
        message: "Login failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log("Profile fetch failed (Controller) e: $e");
      log("Profile fetch failed (Controller) s: $s");
    } finally {
      isLoading.value = false;
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Change Password   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<void> updateProfile() async {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      SnackbarHelper.showError('All fields are required');
      return;
    }

    isLoading.value = true;
    try {
      var response = await AuthRepository().editProfile(fullName: nameController.text.trim(), phoneNumber: phoneController.text.trim(), imagePath: imagePath.value.isNotEmpty ? imagePath.value : null);



    } catch (e) {
      SnackbarHelper.showError('Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }


  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Change Password   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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
      log("Success : ${response.success}");
      Get.back();
      SnackbarHelper.showSuccess(response.message);
    } else {
      SnackbarHelper.showError(response.message);
    }
  }



  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Log Out   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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