import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_fit/Repository/user_repository.dart';

import '../../../../Model/specific_workout_model.dart';

class WorkoutPlanDetailController extends GetxController{

  UserRepository userRepository = UserRepository();
  late String id;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final RxList<SpecificWorkoutModel> specificList = <SpecificWorkoutModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    id = (Get.arguments != null && Get.arguments is Map && Get.arguments['id'] != null)
        ? Get.arguments['id']
        : '';
    log("SpecificWorkoutModel  initialized with id >>>>>>>>>>>: $id");
    fetchSpecificWorkoutPlan();
  }

  Future<void> fetchSpecificWorkoutPlan() async {
    try {
      isLoading.value = true;
      final response = await userRepository.getSpecificWorkoutPlan(id, showMessage: true,);

      if (response?.statusCode == 200) {
        final exercises = response!.data['attributes'] as List<dynamic>?;
        if (exercises != null) {
          specificList.value = exercises
              .map((json) => SpecificWorkoutModel.fromJson(json as Map<String, dynamic>))
              .toList();
          log('Loaded ${specificList.length} specific workouts');
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