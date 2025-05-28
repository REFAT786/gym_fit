import 'dart:developer';

import 'package:get/get.dart';

import '../../../../Model/workout_progress.dart';
import '../../../../Repository/user_repository.dart';

class WorkoutProgressController extends GetxController {
  final UserRepository userRepository = UserRepository();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<WorkoutProgress?> workoutProgress = Rx<WorkoutProgress?>(null);

  Future<void> fetchProgress() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await userRepository.getWorkoutProgress(showMessage: true);

      if (response != null && response.statusCode == 200 && response.data != null) {
        // Wrap partial response.data into full JSON structure expected by model
        final fullJson = {
          "status": response.success ? "Success" : "Failed",
          "statusCode": response.statusCode,
          "message": response.message ?? '',
          "data": response.data,
          "errors": [],
        };
        workoutProgress.value = WorkoutProgress.fromJson(fullJson);
      } else {
        errorMessage.value = response?.message ?? 'Error fetching workout progress';
      }
    } catch (e, s) {
      log("Error fetching workout progress: $e");
      log("Stacktrace: $s");
      errorMessage.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }
}
