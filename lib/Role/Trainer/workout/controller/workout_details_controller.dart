import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Model/wrok_out_model.dart';
import '../../../../Helpers/snackbar_helper.dart';
import '../../../../Model/search_workout_response.dart';
import '../../../../Repository/user_repository.dart';

class WorkoutDetailsController extends GetxController {
  //===========================================================
  RxList magermentList = [].obs;
  final UserRepository userRepository = UserRepository();
  final TextEditingController searchController = TextEditingController();
  RxList<ExerciseModel> searchResults = <ExerciseModel>[].obs;

  late String workoutId;
  RxInt index = 1.obs;

  RxString exerciseId = "".obs;
  RxString traineeId = "".obs;
  late RxDouble totalSets = 1.0.obs;
  late RxDouble timer = 1.0.obs;

  // Reactive variables for loading state, workout data, and error message
  var isLoading = false.obs;
  Rx<WorkOutModel> workoutDetail = WorkOutModel().obs;
  var errorMessage = ''.obs;

  RxInt remainingSeconds = 0.obs;
  Timer? _timer;

  // Call this method to start timer countdown
  void startTimer() {
    stopTimer(); // Stop any previous timer
    remainingSeconds.value = (timer.value * 60).toInt();

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
    workoutId =
        (Get.arguments != null &&
                Get.arguments is Map &&
                Get.arguments['id'] != null)
            ? Get.arguments['id']
            : '';
    log("WorkoutDetailsController initialized with workoutId: $workoutId");
    fetchWorkoutDetail();
  }



  Timer? _debounce;
  void onSearchChanged({String value = ""}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () {
      searchWorkout(query: value);
    });
  }



  void searchWorkout({String query = ''}) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await userRepository.searchWorkOut(
        query,
        showMessage: true,
      );
      if (response?.statusCode == 200) {
        List data = response!.data["exercises"];
        // log("excersice=====${data["exercises"]}");
        searchResults.value =
            data.map((value) => ExerciseModel.fromJson(value)).toList();

        log("searchResults=====$searchResults");
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
      final response = await userRepository.getIndividualWorkoutById(
        workoutId,
        showMessage: true,
      );

      log("responseData -====>${response?.statusCode}");

      if (response?.statusCode == 200) {
        // Parse the full JSON response into WorkOutModel
        log("workoutData=====>${response?.data}");
        List data = response!.data["attributes"];
        if (data.isNotEmpty) {
          workoutDetail.value = WorkOutModel.fromJson(data[0]);
        }
        errorMessage.value = '';
        log("Workout data loaded successfully");
        log("myData=====>${workoutDetail.value.id}");
        log("myData=====>${workoutDetail.value.exerciseName}");

        for (var measurement in workoutDetail.value.measurements) {
          final name = (measurement['name'] ?? '').toString().toLowerCase();
          if (name == 'sets' || name == 'set') {
            final value = measurement['value'];
            if (value != null) {
              // The value is like "5 unit", so extract the number
              final numberStr = value.toString().split(' ').first;
              totalSets.value = double.tryParse(numberStr) ?? 1.0;
            }
          }
        }

        for (var measurement in workoutDetail.value.measurements) {
          final name = (measurement['name'] ?? '').toString().toLowerCase();
          if (name == 'rest' || name == 'rests') {
            final value = measurement['value'];
            if (value != null) {
              timer.value =
                  (value is num)
                      ? value.toDouble()
                      : double.tryParse(value.toString()) ?? 1.0;
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

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Add workout >>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> addWorkout() async {
    try {
      isLoading.value = true;

      final response = await userRepository.addWorkOut(
        traineeId: traineeId.value,
        exerciseId: exerciseId.value,
      );

      if (response.statusCode == 201) {
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
    } catch (e, s) {
      SnackbarHelper.show(
        title: "Error",
        message: "Add failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log("Add failed (Controller) e: $e");
      log("Add failed (Controller) s: $s");
    } finally {
      isLoading(false);
      update();
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Complete workout >>>>>>>>>>>>>>>>>>>>
  Future<void> completeWorkout() async {
    try {
      isLoading.value = true;

      final response = await userRepository.completeWorkout(
        workoutId,
        showMessage: true,
      );

      if (response?.statusCode == 200) {
        Get.offNamed(RoutesName.traineeNavBar);
        SnackbarHelper.show(
          title: "Success",
          message: response!.message,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        SnackbarHelper.show(
          title: "Error",
          message: response!.message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e, s) {
      SnackbarHelper.show(
        title: "Error",
        message: "Login failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log("workout done failed (Controller) e: $e");
      log("workout done  (Controller) s: $s");
    } finally {
      isLoading(false);
      update();
    }
  }
}
