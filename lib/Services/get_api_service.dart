import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import '../Helpers/prefs_helper.dart';
import 'error_response.dart';

import 'package:http_parser/http_parser.dart';

class ApiClient extends GetxService {
  static const String noInternetMessage = "Can't connect to the internet!";
  static const int timeoutInSeconds = 30;

  // static String bearerToken = "";

//==========================================> Get Data <======================================
  static Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    // bearerToken = await PrefsHelper.getString(OtherHelper.bearerToken);

    var mainHeaders = {'Authorization': 'Bearer ${PrefsHelper.token}'};
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');

      http.Response response = await http
          .get(
        Uri.parse(uri),
        headers: headers ?? mainHeaders,
      )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e, s) {
      debugPrint('------------${e.toString()}');
      debugPrint('---------s---${s.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

//==========================================> Post Data <======================================
  static Future<Response> postData(String uri, body,
      {Map<String, String>? headers}) async {
    // var bearerToken = await PrefsHelper.getString(OtherHelper.bearerToken);

    var mainHeaders = {'Authorization': 'Bearer ${PrefsHelper.token}'};
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await http
          .post(Uri.parse(uri), body: body, headers: headers)
          .timeout(const Duration(seconds: timeoutInSeconds));
      debugPrint(
          "==========> Response Post Method :------ : ${response.statusCode}");
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint("===> $e");
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //===========================================================post multipart data
  static Future<Response> postMultipartData(String uri,
      Map<String, String> body,
      {required List<MultipartBody> multipartBody,
        Map<String, String>? headers}) async {
    try {
      // String bearerToken = await PrefsHelper.getString(OtherHelper.bearerToken);

      var mainHeaders = {'Authorization': 'Bearer ${PrefsHelper.token}'};

      var request = http.MultipartRequest('PUT', Uri.parse(uri));
      request.headers.addAll(headers ?? mainHeaders);

      for (MultipartBody element in multipartBody) {
        if (await element.file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              element.key,
              element.file.path,
            ),
          );
        } else {
          throw Exception("File not found: ${element.file.path}");
        }
      }

      request.fields.addAll(body);

      var streamedResponse = await request.send();

      http.Response response = await http.Response.fromStream(streamedResponse);

      return handleResponse(response, uri);
    } catch (e, s) {
      debugPrint("Error occurred: $e");
      debugPrint("Stack trace: $s");
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Patch Data <======================================

  static Future<Response> patchData(String uri, body,
      {Map<String, String>? headers}) async {
    // bearerToken = await PrefsHelper.getString(OtherHelper.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${PrefsHelper.token}'
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await http
          .patch(
        Uri.parse(uri),
        body: body,
        headers: headers ?? mainHeaders,
      )
          .timeout(const Duration(seconds: timeoutInSeconds));
      debugPrint(
          "==========> Response Patch Method :------ : ${response.statusCode}");
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint("===> $e");
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

//=====================================================================send multi part data
  // static Future<Response> putMultipartData(String uri, Map<String, dynamic> body,
  //     {required List<MultipartBody> multipartBody,
  //     Map<String, String>? headers,
  //     String method = "POST"}) async {
  //   try {
  //     // String? bearerToken = await PrefsHelper.getString(OtherHelper.bearerToken);

  //     var mainHeaders = {'Authorization': 'Bearer ${PrefsHelper.token}'};

  //     debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
  //     debugPrint('====> API Body: $body with ${multipartBody.length} files');

  //     var request = http.MultipartRequest(method, Uri.parse(uri));
  //     request.headers.addAll(headers ?? mainHeaders);

  //     // Add files to request
  //     for (MultipartBody element in multipartBody) {
  //       if (element.file.existsSync()) {
  //         request.files.add(await http.MultipartFile.fromPath(
  //           element.key,
  //           element.file.path,
  //         ));
  //       }
  //     }

  //     // Add fields to request
  //     request.fields.addAll(body);

  //     http.Response response =
  //         await http.Response.fromStream(await request.send());

  //     return handleResponse(response, uri);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return const Response(statusCode: 1, statusText: noInternetMessage);
  //   }
  // }

  static Future<Response> MultipartData(String uri,
      Map<String, String> body, {
        required List<MultipartBody> multipartBody,
        Map<String, String>? headers,
        String method = "PUT",
      }) async {
    try {
      var mainHeaders = {'Authorization': 'Bearer ${PrefsHelper.token}'};

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} files');

      var request = http.MultipartRequest(method, Uri.parse(uri));
      request.headers.addAll(headers ?? mainHeaders);

      // Add files to request
      for (MultipartBody element in multipartBody) {
        var mimeType = lookupMimeType(element.file.path);
        if (element.file.existsSync()) {
          request.files.add(await http.MultipartFile.fromPath(
            element.key,
            element.file.path,
            contentType:MediaType.parse(mimeType!)
          ));
        }
      }

      // ✅ Convert body values to Strings before adding
      request.fields.addAll(
        body.map((key, value) => MapEntry(key, value.toString())),
      );


      http.Response response =
      await http.Response.fromStream(await request.send());

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint(e.toString());
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Delete Data <======================================

  static Future<Response> deleteData(String uri,
      {Map<String, String>? headers, dynamic body}) async {
    // bearerToken = await PrefsHelper.getString(OtherHelper.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${PrefsHelper.token}'
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Call: $uri\n Body: $body');

      http.Response response = await http
          .delete(Uri.parse(uri), headers: headers ?? mainHeaders, body: body)
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Handle Response <======================================
  static Response handleResponse(http.Response response, String uri) {
    debugPrint(
        "============================================${response.statusCode}");
    debugPrint("============================================${response.body}");
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
      response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: errorResponse.message);
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }

    debugPrint(
        '====> API Response: [${response0.statusCode}] $uri\n${response0
            .body}');
    return response0;
  }


  static multipartRequest({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? header,
    method = "PUT",
    String? imagePath,
    imageName = 'image',
  }) async {
    try {
      Map<String, String> mainHeader = {
        'Authorization': "Bearer ${PrefsHelper.token}",
      };

      if (kDebugMode) {
        print("=================================================>url $url");
        print("===============================================>body $body");
        print("===========================>header ${header ?? mainHeader}");
        print("===========================>method $method");
        print("===========================>imagePath $imagePath");
        print("===========================>imageName $imageName");
      }

      var request = http.MultipartRequest(method, Uri.parse(url));
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      if (imagePath != null) {
        var mimeType = lookupMimeType(imagePath);
        var shopImage = await http.MultipartFile.fromPath(imageName, imagePath,
            contentType: MediaType.parse(mimeType!));
        request.files.add(shopImage);
      }

      Map<String, String> headers = header ?? mainHeader;

      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      var response = await request.send();

      if (kDebugMode) {
        print("========================>statusCode ${response.statusCode}");
      }

      String data = await response.stream.bytesToString();
      var mapData = jsonDecode(data);

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    } on SocketException {
      return null;
    } on FormatException {
      return null;
    }
  }
}

// static void showToast(String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 2,
//     backgroundColor: Colors.black,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }


class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}
