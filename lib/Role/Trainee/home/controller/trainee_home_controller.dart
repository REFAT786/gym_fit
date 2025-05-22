import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Model/wrok_out_model.dart';
import '../../../../Repository/user_repository.dart';
import '../../../../Utils/app_url.dart';

class TraineeHomeController extends GetxController {
  static TraineeHomeController get instance => Get.find();

  final UserRepository userRepository = UserRepository();
  TextEditingController searchController = TextEditingController();

  RxString profileImage = ''.obs;
  RxString profileName = ''.obs;
  RxBool isLoading = false.obs;

  RxList<WorkOutModel> workoutList = <WorkOutModel>[].obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    fetchWorkoutPlan();
  }

  void _loadUserData() {
    profileImage.value = "${AppUrl.baseUrl}${PrefsHelper.myImage}";
    profileName.value = PrefsHelper.myName;
  }

  Future<void> fetchWorkoutPlan() async {
    isLoading.value = true;
    final response = await userRepository.getWorkoutPlan(showMessage: true);

    if (response?.statusCode == 200) {
      try {
        final data = response?.data;
        if (data != null && data['attributes'] != null) {
          final workoutJsonList = data['attributes']['workout'] as List<dynamic>;
          workoutList.value = WorkOutModel.fromJsonList(workoutJsonList);
          log("Loaded workouts: ${workoutList.length}");
        } else {
          errorMessage.value = "Invalid data structure.";
        }
      } catch (e) {
        errorMessage.value = "Error parsing workouts.";
        log("Parse error: $e");
      }
    } else {
      errorMessage.value = response?.message ?? "Error fetching Workout plan.";
    }
    isLoading.value = false;
  }
}
