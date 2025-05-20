import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_fit/Model/wrok_out_model.dart';
import '../../../../Repository/user_repository.dart';

class WorkoutDetailsController extends GetxController {
  final UserRepository userRepository = UserRepository();

  late String workoutId;

  // Reactive variables for loading state, workout data, and error message
  var isLoading = false.obs;
  Rx<WorkOutModel> workoutDetail = WorkOutModel().obs ;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    workoutId = Get.arguments['id'] ?? '';
    log("WorkoutDetailsController initialized with workoutId: $workoutId");
    fetchWorkoutDetail();
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
}
