import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Helpers/prefs_helper.dart';
import 'package:gym_fit/Model/wrok_out_model.dart';
import '../../../../Helpers/snackbar_helper.dart';
import '../../../../Model/search_workout_response.dart';
import '../../../../Repository/user_repository.dart';
import '../../../../Utils/app_url.dart';

class WorkoutDetailsController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final TextEditingController searchController = TextEditingController();
  RxList<ExerciseModel> searchResults = <ExerciseModel>[].obs;

  RxList<TextEditingController> measurementControllers = <TextEditingController>[].obs;
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
    workoutId = (Get.arguments != null && Get.arguments is Map && Get.arguments['id'] != null)
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
      final response = await userRepository.searchWorkOut(query, showMessage: true);
      if (response?.statusCode == 200) {
        List data = response!.data["exercises"];
        searchResults.value = data.map((value) => ExerciseModel.fromJson(value)).toList();
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
      final response = await userRepository.getIndividualWorkoutById(workoutId, showMessage: true);
      log("responseData -====>${response?.statusCode}");
      if (response?.statusCode == 200) {
        log("workoutData=====>${response?.data}");
        List data = response!.data["attributes"];
        if (data.isNotEmpty) {
          workoutDetail.value = WorkOutModel.fromJson(data[0]);
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
              timer.value = (value is num) ? value.toDouble() : double.tryParse(value.toString()) ?? 1.0;
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
          }else if(value is String){

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
      String user;
      if(PrefsHelper.myRole == "trainee"){
        user = PrefsHelper.userId;
      }else{
        user = traineeId.value;
      }
      final response = await userRepository.addWorkOut(
        traineeId: user,
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

  Future<void> completeWorkout() async {
    try {
      isLoading.value = true;

      // Prepare sets list with measurements from controllers
      List<Map<String, dynamic>> sets = [];
      for (var i = 0; i < totalSets.value.toInt(); i++) {
        List<Map<String, dynamic>> measurements = [];
        for (var j = 0; j < workoutDetail.value.measurements.length; j++) {
          if (j >= measurementControllers.length) continue; // Safeguard
          final measurement = workoutDetail.value.measurements[j];
          final controller = measurementControllers[j];
          dynamic value;
          if (controller.text.isNotEmpty) {
            if (measurement['unit'] == 'unit' && measurement['name'].toString().toLowerCase() == 'reps') {
              value = int.tryParse(controller.text) ?? measurement['value'] ?? 0;
            } else if (measurement['unit'] == 'unit' && measurement['name'].toString().toLowerCase() == 'weight') {
              value = double.tryParse(controller.text) ?? measurement['value'] ?? 0.0;
            } else {
              value = controller.text;
            }
          } else {
            value = measurement['value'] ?? 0;
          }
          measurements.add({
            "name": measurement['name'] ?? '',
            "value": value,
            "unit": measurement['unit'] ?? '',
          });
        }
        sets.add({
          "name": "Set ${i + 1}",
          "measurements": measurements,
        });
      }

      // Prepare stations as an array of strings
      List<String> stationsData = workoutDetail.value.stations.map((station) {
        return station is Map && station.containsKey('name') ? station['name'].toString() : station.toString();
      }).toList();

      // Prepare muscle groups
      List<Map<String, dynamic>> muscleGroups = workoutDetail.value.muscleGroups.map((e) => {
        "name": e.name,
        "image": "${AppUrl.baseUrl}${e.image}",
      }).toList();

      // Prepare workout types
      List<Map<String, dynamic>> workoutTypes = workoutDetail.value.workoutTypes.map((e) => {
        "name": e.name,
        "image": "${AppUrl.baseUrl}${e.image}",
      }).toList();

      // Prepare request body
      Map<String, dynamic> body = {
        "user": traineeId.value.isNotEmpty ? traineeId.value : workoutDetail.value.userName,
        "exerciseName": workoutDetail.value.exerciseName,
        "exerciseImage": "${AppUrl.baseUrl}${workoutDetail.value.exerciseImage}",
        "stations": stationsData,
        "muscleGroups": muscleGroups,
        "workoutTypes": workoutTypes,
        "sets": sets,
      };

      log("Complete Workout Request Body: $body");

      final response = await userRepository.completeWorkout(
        body: body,
        showMessage: true,
      );

      if (response?.statusCode == 200) {
        Get.offNamed(RoutesName.traineeNavBar);
        totalSets.value = 1.0;
        index.value = 1;
        sets.clear();
        measurementControllers.clear();
        for (var measurement in workoutDetail.value.measurements) {
          measurementControllers.add(
            TextEditingController(text: "${measurement['value'] ?? ''}"),
          );
        }
        SnackbarHelper.show(
          title: "Success",
          message: response!.message ?? "Workout completed successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        SnackbarHelper.show(
          title: "Error",
          message: response?.message ?? "Failed to complete workout",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e, s) {
      SnackbarHelper.show(
        title: "Error",
        message: "Workout completion failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log("Workout completion failed (Controller) e: $e");
      log("Workout completion failed (Controller) s: $s");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}