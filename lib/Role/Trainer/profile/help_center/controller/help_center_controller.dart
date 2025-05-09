import 'dart:developer';
import 'package:get/get.dart';
import 'package:gym_fit/Repository/auth_repository.dart';
import '../../../../../Model/faq_model.dart';

class HelpCenterController extends GetxController {
  RxList<FAQModel> faqList = <FAQModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs; // Add error message for UI feedback
  final AuthRepository authRepository = AuthRepository();

  Future<void> fetchFaq() async {
    isLoading.value = true;
    errorMessage.value = ''; // Reset error message

    try {
      final result = await authRepository.getFaq();
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>result $result");
      if (result != null && result.isNotEmpty) {
        faqList.value = result;
        log("Fetched FAQ List: ${faqList.length} items");
      } else {
        log("No FAQ data received");
        faqList.value = [];
        errorMessage.value = "No FAQs available.";
      }
    } catch (e, s) {
      log("Error fetching FAQ: $e");
      log("Stack trace: $s");
      faqList.value = [];
      errorMessage.value = "Failed to load FAQs. Please try again.";
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFaq();
  }
}