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
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Success >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
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



}
