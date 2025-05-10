import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Repository/auth_repository.dart';

class TermsOfServiceController extends GetxController{

  RxString terms = "".obs;
  RxBool isLoading = false.obs;
  final AuthRepository authRepository = AuthRepository();

  Future<void> getTerms() async {
    isLoading.value = true;
    try {
      final response = await authRepository.getHtmlData(type: 'terms-of-condition');
      if (response.statusCode == 200) {
        final content = response.data['attributes']['content'];
        if (content != null && content.isNotEmpty) {
          terms.value = content;
        } else {
          Get.snackbar(
            "Error",
            "Terms content is empty",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch Terms: ${response.message}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error fetching Terms: $e");
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
    getTerms();
  }
}