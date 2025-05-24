import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_fit/Model/specific_workout_model.dart';
import 'package:gym_fit/Repository/user_repository.dart';

class SpecificWorkoutPlanController extends GetxController {
  final UserRepository userRepository = UserRepository();

  final RxString name = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<SpecificWorkoutModel> specificWorkoutList = <SpecificWorkoutModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeName();
    fetchAllSpecificWorkoutPlan();
  }

  void _initializeName() {
    if (Get.arguments != null && Get.arguments is Map && Get.arguments['name'] != null) {
      name.value = Get.arguments['name'];
    }
    log('Initialized with Name: ${name.value}');
  }

  Future<void> fetchAllSpecificWorkoutPlan() async {
    try {
      isLoading.value = true;
      final response = await userRepository.getAllSpecificWorkoutPlan(
        name.value,
        showMessage: true,
      );

      if (response?.statusCode == 200 && response?.data != null) {
        final exercises = response!.data['exercises'] as List<dynamic>?;
        if (exercises != null) {
          specificWorkoutList.value = exercises
              .map((json) => SpecificWorkoutModel.fromJson(json as Map<String, dynamic>))
              .toList();
          log('Loaded ${specificWorkoutList.length} specific workouts');
        } else {
          errorMessage.value = 'Invalid data structure: No exercises found';
        }
      } else {
        errorMessage.value = response?.message ?? 'Error fetching specific workout plan';
      }
    } catch (e) {
      errorMessage.value = 'Error parsing workouts: $e';
      log('Parse error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}