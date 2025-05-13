import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_fit/Helpers/prefs_helper.dart';
import 'package:gym_fit/Repository/user_repository.dart';
import 'package:gym_fit/Utils/app_url.dart';

import '../../profile/profile/screen/trainer_profile_details_screen.dart';

class TrainerHomeController extends GetxController {
  static TrainerHomeController get instance => Get.put(TrainerHomeController());

  UserRepository userRepository = UserRepository();

  RxString profileImage = "${AppUrl.baseUrl}${PrefsHelper.myImage}".obs;
  RxString profileName = PrefsHelper.myName.obs;

  var trainees = [].obs;  // Observable list to store fetched trainees
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTrainees();
  }

  Future<void> showListDetails() async {
    Get.to(TrainerProfileDetailsScreen());
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Fetch trainees from repository
  Future<void> fetchTrainees() async {
    isLoading(true);
    var response = await userRepository.getAssignTrainee(showMessage: true);

    // Check if the response was successful
    if (response?.statusCode == 200) {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>response.statusCode  : ${response?.statusCode }");
      try {
        // Ensure the 'data' field exists and the structure is correct
        var data = response?.data;
        if (data != null && data['attributes'] != null) {
          var traineesData = data['attributes']['trainees'];

          // Check if there are any trainees data
          if (traineesData.isNotEmpty) {
            trainees.assignAll(traineesData);
            log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>response.length  : ${trainees.length }");
            log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>response >>>>>>>>> trainees  : $trainees ");
          } else {
            errorMessage.value = "No trainees found.";
            log("No trainees found.");
          }
        } else {
          errorMessage.value = "Invalid data structure.";
          log("Invalid data structure.");
        }
      } catch (e) {
        log("Error parsing trainees: $e");
        errorMessage.value = "Error parsing trainees.";
      }
    } else {
      errorMessage.value = response?.message ?? "Error fetching trainees.";
      log("Failed to fetch trainees: ${response?.message}");
    }

    isLoading(false);
  }



}
