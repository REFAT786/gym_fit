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
  final UserRepository userRepository = UserRepository();
  final TextEditingController searchController = TextEditingController();
  RxList<ExerciseModel> searchResults = <ExerciseModel>[].obs;

  // List to store TextEditingControllers for measurements
  RxList<TextEditingController> measurementControllers =
      <TextEditingController>[].obs;

  late String workoutId;
  RxInt index = 1.obs;

  RxString exerciseId = "".obs;
  RxString traineeId = "".obs;
  late RxDouble totalSets = 1.0.obs;
  late RxDouble timer = 1.0.obs;

  var isLoading = false.obs;
  Rx<WorkOutModel> workoutDetail = WorkOutModel().obs;
  var errorMessage = ''.obs;

  RxInt remainingSeconds = 0.obs;
  Timer? _timer;

  void startTimer() {
    stopTimer();
    remainingSeconds.value = (timer.value * 60).toInt();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    // Dispose all measurement controllers
    for (var controller in measurementControllers) {
      controller.dispose();
    }
    measurementControllers.clear();
    searchController.dispose();
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
        log("workoutData=====>${response?.data}");
        List data = response!.data["attributes"];
        if (data.isNotEmpty) {
          workoutDetail.value = WorkOutModel.fromJson(data[0]);
          // Initialize TextEditingControllers for measurements
          measurementControllers.clear();
          for (var measurement in workoutDetail.value.measurements) {
            measurementControllers.add(
              TextEditingController(text: "${measurement['value'] ?? ''}"),
            );
          }
        }
        errorMessage.value = '';
        log("Workout data loaded successfully");
        log("myData=====>${workoutDetail.value.id}");
        log("myData=====>${workoutDetail.value.exerciseName}");
        log("measurementControllers length: ${measurementControllers.length}");

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

  void startWorkout() {
    for (var measurement in workoutDetail.value.measurements) {
      final name = (measurement['name'] ?? '').toString().toLowerCase();
      if (name == 'sets' || name == 'set') {
        final value = measurement['value'];
        if (value != null) {
          log(">>>>>>>>>>>>>>>>>>>> print : $value");
          log(">>>>>>>>>>>>>>>>>>>> print : ${value.runtimeType}");
          if (value is int) {
            totalSets.value = value.toDouble();
          } else {
            totalSets.value = value ?? 1.0;
          }
        }
      }
    }
    Get.toNamed(RoutesName.trainingPageOne);
  }

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
      isLoading.value = false;
      update();
    }
  }
//========================================================================================
  RxList setList = [].obs;
  Future<void> completeWorkout() async {
    try {
      isLoading.value = true;

      // if (workoutDetail.value.measurements.isNotEmpty) {
      //   for (var i = 0; i < workoutDetail.value.measurements.length; i++) {
      //     var data = workoutDetail.value.measurements[i];
      //     setList.add({
      //       "name": "Set ${i + 1}",
      //       "measurements": [
      //         {"name": data["name"], "value": data["value"], "unit": "unit"},
      //       ],
      //     });
      //   }
      // }

      log("setlist=====$setList");
      log("measurementlist=====${workoutDetail.value.measurements}");

      Map<String, dynamic> body = {"sets": setList};

      final response = await userRepository.completeWorkout(
        body: body,
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
      log("workout done (Controller) s: $s");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
