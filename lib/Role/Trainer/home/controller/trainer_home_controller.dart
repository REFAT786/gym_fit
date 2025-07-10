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

  var trainees = [].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTrainees();
  }

  Future<void> showListDetails({required String id}) async {
    // Pass the correct user ID in arguments map with key 'id'
    Get.to(() => TrainerProfileDetailsScreen(), arguments: {'id': id});
  }

  Future<void> fetchTrainees() async {
    isLoading(true);
    var response = await userRepository.getAssignTrainee(showMessage: true);

    if (response?.statusCode == 200) {
      try {
        var data = response?.data;
        if (data != null && data['attributes'] != null) {
          var traineesData = data['attributes']['trainees'];
          if (traineesData.isNotEmpty) {
            trainees.assignAll(traineesData);
          } else {
            errorMessage.value = "No trainees found.";
          }
        } else {
          errorMessage.value = "Invalid data structure.";
        }
      } catch (e, s) {
        errorMessage.value = "Error parsing trainees.";
        log("Error Line: $s");
      }
    } else {
      errorMessage.value = response?.message ?? "Error fetching trainees.";
    }
    isLoading(false);
  }
}
