import 'dart:convert';
import 'dart:developer';
import 'package:gym_fit/Model/faq_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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
    final url = AppUrl.profile;
    log("Profile URL: $url");
    log("Token: ${PrefsHelper.token}");

    final response = await ApiService.to.getApi(url);
    log("Response >>>>>>>>>>>>>>>>>>>> ${response.toString()}");

    if (response.statusCode == 200) {
      try {
        final userDetailsJson = response.data['attributes'];
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

    // Define fields as direct key-value pairs
    final fields = {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };

    log("fields >>>>>>>>>>>>>>>>>>>>>>>>>>: $fields");

    // // Validate image format if provided
    // if (imagePath != null && imagePath.isNotEmpty) {
    //   final extension = path.extension(imagePath).toLowerCase();
    //   log("Image file extension: $extension");
    //   const allowedExtensions = ['.jpg', '.jpeg', '.png', '.heic', '.heif'];
    //   if (!allowedExtensions.contains(extension)) {
    //     log("Invalid image format: $extension. Allowed formats: $allowedExtensions");
    //     return null; // Or handle the error as needed
    //   }
    // }

    final response = await ApiService.to.multipartPutApi(
      url,
      fields: fields,
      fileFieldName: 'image',
      filePath: imagePath,
      extraHeaders: {"Content-Type" : "multipart/form-data"}
    );

    log("response >>>>>>>>>>>>>>>>>>>>>>>>>>: ${response.toString()}");
    log("Edit Profile Response: ${response.toString()}");
    log("Edit Profile Status Code: ${response.statusCode}");
    log("Edit Profile Success: ${response.success}");
    log("Edit Profile Message: ${response.message}");
    log("Edit Profile Data: ${response.data}");

    if (response.statusCode == 200 && response.success) {
      try {
        final userDetailsJson = response.data;
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Success >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        return ProfileModel.fromJson(userDetailsJson);
      } catch (e, s) {
        log("Error parsing UserDetails e: $e");
        log("Error parsing UserDetails s: $s");
        return null;
      }
    } else {
      log("Failed to edit profile: ${response.message}");
      return null;
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Change Password >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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

    if (response.statusCode == 200) {
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