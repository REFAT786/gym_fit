import 'dart:convert';
import 'dart:developer';
import 'package:gym_fit/Model/faq_model.dart';
import 'package:http/http.dart' as http;

import '../Helpers/prefs_helper.dart';
import '../Model/profile_model.dart';
import '../Services/api_service.dart';
import '../Utils/app_url.dart';

class AuthRepository {

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Login >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<ApiResponse> logIn({
    String? email,
    String? password,
    String? userName,
    String? pin,
  }) async {
    final Map<String, dynamic> body = {};

    if (email != null && email.isNotEmpty) {
      body['email'] = email;
      body['password'] = password ?? '';
    } else if (userName != null && userName.isNotEmpty) {
      body['userName'] = userName;
      body['pin'] = pin ?? '';
    }

    final response = await ApiService.to.postApi(AppUrl.login, body);
    return response;
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get Profile >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ProfileModel?> getProfile() async {
    final profileUrl = AppUrl.profile + PrefsHelper.userId;
    log("Profile URL: $profileUrl");
    log("Token: ${PrefsHelper.token}");

    final response = await ApiService.to.getApi(profileUrl);
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.toString()}");

    if (response.success) {
      try {
        final userDetailsJson = response.data['attributes']['userDetails'];
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Success >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        return ProfileModel.fromJson(userDetailsJson);
      } catch (e) {
        log("Error parsing UserDetails: $e");
        return null;
      }
    } else {
      log("Failed to fetch profile: ${response.message}");
      return null;
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Edit Profile >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ProfileModel?> editProfile({
    required String fullName,
    required String phoneNumber,
    String? imagePath,
  }) async {
    final url = AppUrl.editProfile + PrefsHelper.userId;
    log("Edit Profile URL: $url");
    log("Token: ${PrefsHelper.token}");

    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer ${PrefsHelper.token}';
    request.fields['fullName'] = fullName;
    request.fields['phoneNumber'] = phoneNumber;

    if (imagePath != null && imagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }

    try {
      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      final decoded = json.decode(responseBody.body);

      if (response.statusCode == 200 && decoded['status'] == 'success') {
        try {
          final userDetailsJson = decoded['data']['attributes']['userDetails'];
          log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Success >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
          return ProfileModel.fromJson(userDetailsJson);
        } catch (e) {
          log("Error parsing UserDetails: $e");
          return null;
        }
      } else {
        log("Failed to edit profile: ${decoded['message']}");
        return null;
      }
    } catch (e) {
      log("Error updating profile: $e");
      return null;
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Change  Password >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse> changePassword({
    String? oldPassword,
    String? newPassword,
  }) async {

    final body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };

    final response = await ApiService.to.patchApi(AppUrl.changePassword, body);
    return response;
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get FAQ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<List<FAQModel>?> getFaq() async {
    const url = AppUrl.faq; // Replace with actual FAQ endpoint URL
    log("FAQ URL: $url");

    final response = await ApiService.to.getApi(url);
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.toString()}");
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.statusCode}");
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.success}");

    if (response.statusCode==200) {
      try {
        final List<dynamic> faqData = response.data['attributes'];
        List<FAQModel> faqList = faqData.map((faq) => FAQModel.fromJson(faq)).toList();
        log("Success FAQ Data: $faqList");
        return faqList;
      } catch (e, s) {
        log("Error parsing FAQ Data: $e");
        log("Error parsing FAQ Data: $s");
        return null;
      }
    } else {
      log("Failed to fetch FAQ: ${response.message}");
      return null;
    }
  }


///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Policy && Terms & Condition >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<ApiResponse> getHtmlData({required String type}) async {
    var url = "${AppUrl.policyTerms}$type";
    log("Policy URL: $url");

    final response = await ApiService.to.getApi(url);
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.toString()}");
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.statusCode}");
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.success}");

    return response;
  }

}
