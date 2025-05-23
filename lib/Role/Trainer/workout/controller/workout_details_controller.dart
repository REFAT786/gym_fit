import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Model/wrok_out_model.dart';
import '../../../../Helpers/snackbar_helper.dart';
import '../../../../Model/search_workout_response.dart';
import '../../../../Repository/user_repository.dart';

class WorkoutDetailsController extends GetxController {

  //===========================================================
  RxList magermentList = [].obs;
  final UserRepository userRepository = UserRepository();
  final TextEditingController searchController = TextEditingController();
  RxList<Exercise> searchResults = <Exercise>[].obs;

  late String workoutId;
  RxInt index = 1.obs;

  late RxString  exerciseId;
  late RxString  traineeId;
  late RxDouble totalSets = 1.0.obs;
  late RxDouble timer = 1.0.obs;

  // Reactive variables for loading state, workout data, and error message
  var isLoading = false.obs;
  Rx<WorkOutModel> workoutDetail = WorkOutModel().obs ;
  var errorMessage = ''.obs;

  RxInt remainingSeconds = 0.obs;
  Timer? _timer;

  // Call this method to start timer countdown
  void startTimer() {
    stopTimer(); // Stop any previous timer
    remainingSeconds.value = (timer.value*60).toInt();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        stopTimer();
      }
    });
  }
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    workoutId = (Get.arguments != null && Get.arguments is Map && Get.arguments['id'] != null)
        ? Get.arguments['id']
        : '';
    log("WorkoutDetailsController initialized with workoutId: $workoutId");
    fetchWorkoutDetail();
  }


  void searchWorkout(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await userRepository.searchWorkOut(query, showMessage: true);
      if (response?.statusCode == 200) {
        final data = SearchWorkoutResponse.fromJson(response!.data);
        searchResults.assignAll(data.exercises);
      } else {
        errorMessage.value = response?.message ?? "Failed to search";
        searchResults.clear();
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWorkoutDetail() async {
    if (workoutId.isEmpty) {
      errorMessage.value = 'Workout ID not provided';
      log(errorMessage.value);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await userRepository.getIndividualWorkoutById(workoutId, showMessage: true);

      log("responseData -====>${response?.statusCode}");

      if (response?.statusCode == 200) {
        // Parse the full JSON response into WorkOutModel
        log("workoutData=====>${response?.data}");
        List data = response!.data["attributes"];
        if(data.isNotEmpty){
          workoutDetail.value = WorkOutModel.fromJson(data[0]);}
        errorMessage.value = '';
        log("Workout data loaded successfully");
        log("myData=====>${workoutDetail.value.id}");
        log("myData=====>${workoutDetail.value.exerciseName}");

        for (var measurement in workoutDetail.value.measurements) {
          final name = (measurement['name'] ?? '').toString().toLowerCase();
          if (name == 'sets' || name == 'set') {
            final unitValue = measurement['unit'];
            if (unitValue != null) {
              totalSets.value = (unitValue is num)
                  ? unitValue.toDouble()
                  : double.tryParse(unitValue.toString()) ?? 1.0;
            }
          }
        }
        for (var measurement in workoutDetail.value.measurements) {
          final name = (measurement['name'] ?? '').toString().toLowerCase();
          if (name == 'rest' || name == 'rests') {
            final unitValue = measurement['unit'];
            if (unitValue != null) {
              timer.value = (unitValue is num)
                  ? unitValue.toDouble()
                  : double.tryParse(unitValue.toString()) ?? 1.0;
            }
          }
        }

      } else {
        errorMessage.value = response?.message ?? 'Failed to load workout data';
        log("API returned error: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = 'An error occurred while loading workout data';
      log("Exception during fetchWorkoutDetail: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> addWorkout() async {

    try {
      isLoading.value = true;

      final response = await userRepository.addWorkOut(
        traineeId: traineeId.value,
        exerciseId: exerciseId.value,
      );

      if (response.statusCode == 200) {
        Get.back();
        SnackbarHelper.show(
          title: "Success",
          message: response.message,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        SnackbarHelper.show(
          title: "Error",
          message: response.message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e,s) {
      SnackbarHelper.show(
        title: "Error",
        message: "Login failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log("Login failed (Controller) e: $e");
      log("Login failed (Controller) s: $s");
    } finally {
      isLoading(false);
      update();
    }
  }

}
