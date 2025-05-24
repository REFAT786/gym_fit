import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_fit/Repository/user_repository.dart';

import '../../../../Model/history_model.dart';
import '../../../../Model/muscle_model.dart';

class WorkoutPlanController extends GetxController{

  UserRepository userRepository = UserRepository();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<MuscleModel> muscleList = <MuscleModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchAllWorkoutPlan();
  }

  Future<void> fetchAllWorkoutPlan() async {
    isLoading.value = true;
    final response = await userRepository.getAllWorkoutPlan(showMessage: true);

    if (response?.statusCode == 200) {
      try {
        final data = response?.data;
        if (data != null && data['attributes'] != null) {
          final musculeJsonList = data['attributes'] as List<dynamic>;
          muscleList.value = musculeJsonList
              .map((json) => MuscleModel.fromJson(json as Map<String, dynamic>))
              .toList();
          log("Loaded workouts: ${muscleList.length}");
        } else {
          errorMessage.value = "Invalid data structure.";
        }
      } catch (e) {
        errorMessage.value = "Error parsing workouts: $e";
        log("Parse error: $e");
      }
    } else {
      errorMessage.value = response?.message ?? "Error fetching Workout plan.";
    }
    isLoading.value = false;
  }

}