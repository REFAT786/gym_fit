import 'dart:developer';
import 'package:intl/intl.dart';

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
    final url = AppUrl.traineeManagement;
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

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get all Workout  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> searchAllWorkOut(
      {
        bool showMessage = false,
      }) async {
    final url = AppUrl.searchAllWorkout;
    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log("Fetch all Workout by ID Response: $response");

    if (response.statusCode == 200) {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Success search all Workout");
      return response;
    } else {
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Error search all Workout");
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
    String traineeId = "",
    String exerciseId = "",
  }) async {
    final Map<String, String> body = {
      'user': traineeId,
      'exercise': exerciseId,
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
  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get Workout plan >>>>>>>>>>>>>>

  Future<ApiResponse?> getWorkoutPlan({bool showMessage = false}) async {
    final url = AppUrl.workOutPlan;
    log("Fetch Workout plan URL: $url");

    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log(" Workout plan Response: $response");

    if (response.statusCode == 200) {
      log("Success  Workout plan");
      return response;
    } else {
      log("Error  Workout plan: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Complete Workout >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<ApiResponse?> completeWorkout(
      String id, {
        bool showMessage = false,
      }) async {
    final url = "${AppUrl.completeWorkout}$id";
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

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> View History  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> getHistory(
      DateTime date, {
        bool showMessage = false,
      }) async {
    final dateFormatted = DateFormat('yyyy-MM-dd').format(date);
    final url = "${AppUrl.historyView}$dateFormatted";

    log("Fetching workout history for date: $dateFormatted");
    log("URL: $url");

    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log("Response from getHistory: $response");

    if (response.statusCode == 200) {
      log("Success fetching history");
      return response;
    } else {
      log("Failed fetching history: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get All Workout plan  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> getAllWorkoutPlan({bool showMessage = false}) async {
    final url = AppUrl.allWorkoutPlan;
    log("Fetch All Workout plan URL: $url");

    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log(" Workout All plan Response: $response");

    if (response.statusCode == 200) {
      log("Success All Workout plan");
      return response;
    } else {
      log("Error All Workout plan: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get All Specific Workout plan  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> getAllSpecificWorkoutPlan(String name,{bool showMessage = false}) async {
    final url = "${AppUrl.allSpecificWorkoutPlan}$name";
    log("Fetch All Specific Workout plan URL: $url");

    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log(" Workout All Specific workout plan Response: $response");

    if (response.statusCode == 200) {
      log("Success All Specific Workout plan");
      return response;
    } else {
      log("Error AllSpecific  Workout plan: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get  Specific Workout plan  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> getSpecificWorkoutPlan(String id,{bool showMessage = false}) async {
    final url = "${AppUrl.specificWorkoutPlan}$id";
    log("Fetch  Specific Workout plan URL: $url");

    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log(" Workout  Specific workout plan Response: $response");

    if (response.statusCode == 200) {
      log("Success  Specific Workout plan");
      return response;
    } else {
      log("Error Specific  Workout plan: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get Workout progress  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse?> getWorkoutProgress({bool showMessage = false}) async {
    final url = AppUrl.workoutProgress;
    log("Fetch Workout Progress URL: $url");

    final response = await ApiService.to.getApi(url, showMessage: showMessage);
    log("Workout Progress Response: $response");

    if (response.statusCode == 200) {
      log("Success Workout Progress");
      return response;
    } else {
      log("Error Workout Progress: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message,
        data: null,
        statusCode: response.statusCode,
      );
    }
  }




}
