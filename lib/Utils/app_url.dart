class AppUrl {

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Live >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  // static const String baseUrl = "http://172.252.13.74:8032";

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Local >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  static const String baseUrl = "http://10.0.70.37:8032";

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  static const String login = "$baseUrl/api/v1/auth/login";
  static const String profile = "$baseUrl/api/v1/users/own-profile";
  static const String profileWithId = "$baseUrl/api/v1/users/";
  static const String changePassword = "$baseUrl/api/v1/auth/change-password";
  static const String faq = "$baseUrl/api/v1/fandq/";
  static const String policyTerms = "$baseUrl/api/v1/static-contents?type=";
  static const String editProfile = "$baseUrl/api/v1/users/update";
  static const String assignTrainee = "$baseUrl/api/v1/trainer/your-trainees";
  static const String traineeManagement = "$baseUrl/api/v1/users/?role=trainee";
  static const String individualWorkout = "$baseUrl/api/v1/workout/";
  static const String workoutSearch = "$baseUrl/api/v1/exercise/?search=";
  static const String addWorkout = "$baseUrl/api/v1/workout/assign";
  static const String bmiResult = "$baseUrl/api/v1/trainee/";
  static const String workOutPlan = "$baseUrl/api/v1/workout";
  static const String completeWorkout = "$baseUrl/api/v1/workout/completed";
  static const String historyView = "$baseUrl/api/v1/workout/progress-history/";
  static const String allWorkoutPlan = "$baseUrl/api/v1/exercise/exercise-group";
  static const String allSpecificWorkoutPlan = "$baseUrl/api/v1/exercise/?search=";
  static const String specificWorkoutPlan = "$baseUrl/api/v1/exercise/";
  static const String workoutProgress = "$baseUrl/api/v1/workout/progress";
  static const String searchAllWorkout = "$baseUrl/api/v1/exercise/";

}
