import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Repository/auth_repository.dart';

class PolicyController extends GetxController {
  RxString privacyPolicy = "".obs;
  RxBool isLoading = false.obs;
  final AuthRepository authRepository = AuthRepository();

  /// Fetches the privacy policy and updates the state accordingly.
  Future<void> getPolicy() async {
    isLoading.value = true;
    try {
      final response = await authRepository.getHtmlData(type: 'privacy-policy');
      if (response.statusCode == 200) {
        final content = response.data['attributes']['content'];
        if (content != null && content.isNotEmpty) {
          privacyPolicy.value = content;
        } else {
          Get.snackbar(
            "Error",
            "Privacy policy content is empty",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch privacy policy: ${response.message}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error fetching policy: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPolicy();
  }
}