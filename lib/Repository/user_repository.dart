import 'dart:developer';
import '../Helpers/prefs_helper.dart';
import '../Model/profile_model.dart';
import '../Services/api_service.dart';
import '../Utils/app_url.dart';

class UserRepository {
  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get Assign Trainee

  Future<ApiResponse?> getAssignTrainee({bool showMessage = false}) async {
    final url = AppUrl.assignTrainee;
    log(" URL>>>>>>>>>: $url");
    log("Token>>>>>>>>: ${PrefsHelper.token}");

    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.toString()}");

    if (response.statusCode == 200) {
      try {
        log(
          ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Success >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>",
        );
        return response;
      } catch (e) {
        log("Error parsing UserDetails: $e");
        return null;
      }
    } else {
      log("Failed to fetch profile: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get Trainee single Profile >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> getTraineeProfileById(
    String id, {
    bool showMessage = false,
  }) async {
    final url = "${AppUrl.profileWithId}$id";
    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log("Fetch Trainee by ID Response: $response");

    if (response.statusCode == 200) {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Success Trainee single Profile");
      return response;
    } else {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Error Trainee single Profile");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get Trainee management  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> getTraineeManagement({bool showMessage = false}) async {
    final url = "${AppUrl.traineeManagement}${PrefsHelper.myRole}";
    log("Fetch Trainee Management URL: $url");

    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log("Trainee Management Response: $response");

    if (response.statusCode == 200) {
      log("Success Trainee Management");
      return response;
    } else {
      log("Error Trainee Management: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get individual Workout Profile >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> getIndividualWorkoutById(
    String id, {
    bool showMessage = false,
  }) async {
    final url = "${AppUrl.individualWorkout}$id";
    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log("Fetch individual Workout by ID Response: $response");

    if (response.statusCode == 200) {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Success individual Workout");
      return response;
    } else {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Error individual Workout");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get individual Workout Profile >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> searchWorkOut(
    String name, {
    bool showMessage = false,
  }) async {
    final url = "${AppUrl.workoutSearch}$name";
    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log("Fetch individual Workout by ID Response: $response");

    if (response.statusCode == 200) {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Success search Workout");
      return response;
    } else {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Error search Workout");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Add Workout >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<ApiResponse> addWorkOut({
    String? traineeId,
    String? exerciseId,
  }) async {
    final Map<String, dynamic> body = {
      'traineeId': traineeId,
      'exerciseId': exerciseId,
    };

    final response = await ApiService.to.postApi(AppUrl.addWorkout, body);
    return response;
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Trainee <>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ///
  ///
  ///
  ///

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> BMI Result <>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<ApiResponse> bmiResult({
    String? gender,
    num? age,
    String? height,
    String? weight,
  }) async {
    final Map<String, dynamic> body = {
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
    };
    final response = await ApiService.to.putApi(AppUrl.bmiResult, body);
    return response;
  }
}
