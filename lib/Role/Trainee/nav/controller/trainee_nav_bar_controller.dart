import 'package:get/get.dart';

class TraineeNavBarController extends GetxController {
  var isHomeActive = true.obs;
  var isWorkoutPlanActive = false.obs;
  var isProgressActive = false.obs;
  var isProfileActive = false.obs;

  void updateActiveTab(String tab) {
    isHomeActive.value = (tab == 'home');
    isWorkoutPlanActive.value = (tab == 'workout_plan');
    isProgressActive.value = (tab == 'progress');
    isProfileActive.value = (tab == 'profile');
  }
}
