import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper extends GetxController {
  static String token = "";
  //static String tempToken = "";
  static bool isLogIn = false;
  static bool adminVerified = false;
  static bool subscription = false;
  //static bool isNotifications = true;
  static String refreshToken = "";
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String myRole = "";
  static String accountStatus = "";
  static String about = "";
  static String phone = "";
  static String phoneCountryCode = "";
  static String gender = "";
  static String address = "";
  static String paypalEmail = "";
  static String latitude = "";
  static String longitude = "";
  static double rating = 0;
  static double points = 0;
  static List<String> interests = [];
  static List<String> photos = [];

  //static String purchesPackageId = "";
  //static bool isPurchesPackage = false;

  //static String mySubscription = "shopping";
  static String localizationLanguageCode = 'en';
  static String localizationCountryCode = 'US';

  static bool isDarkTheme = false; // Added for theme support

  static String selectedBgColor = "default";
  static String selectedButtonColor = "default";
  static String selectedTextColor = "default";

  static int customBgColor = 0xff121212;
  static int customButtonColor = 0xFF6200EE; // Example color
  static int customTextColor = 0xFFFFFFFF; // White color




  //static bool isMerchant = false;
  //static bool isAutoPayRent = false;

  ///<<<======================== Get All Data Form Shared Preference ==============>

  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token") ?? "";
    refreshToken = preferences.getString("refreshToken") ?? "";
    userId = preferences.getString("userId") ?? "";
    myImage = preferences.getString("myImage") ?? "";
    myName = preferences.getString("myName") ?? "";
    myEmail = preferences.getString("myEmail") ?? "";
    myRole = preferences.getString("myRole") ?? "";
    isLogIn = preferences.getBool("isLogIn") ?? false;
    adminVerified = preferences.getBool("adminVerified") ?? false;
    subscription = preferences.getBool("subscription") ?? false;
    about = preferences.getString("about") ?? "";
    phone = preferences.getString("phone") ?? "";
    phoneCountryCode = preferences.getString("phoneCountryCode") ?? "";
    address = preferences.getString("address") ?? "";
    paypalEmail = preferences.getString("paypalEmail") ?? "";
    latitude = preferences.getString("latitude") ?? "";
    longitude = preferences.getString("longitude") ?? "";
    gender = preferences.getString("gender") ?? "";

    rating = preferences.getDouble("rating") ?? 0;
    points = preferences.getDouble("points") ?? 0;

    // interests = preferences.getStringList("interests") ?? [];
    // photos = preferences.getStringList("photos") ?? [];

    //isAutoPayRent = preferences.getBool("isAutoPayRent") ?? false;

    //isNotifications = preferences.getBool("isNotifications") ?? true;
    //mySubscription = preferences.getString("mySubscription") ?? "shopping";
    //localizationCountryCode = preferences.getString("localizationCountryCode") ?? "US";
    //localizationLanguageCode = preferences.getString("localizationLanguageCode") ?? "en";
    isLogIn = preferences.getBool("isLogIn") ?? false;
    //isNotifications = preferences.getBool("isNotifications") ?? true;
    //mySubscription = preferences.getString("mySubscription") ?? "shopping";
    localizationCountryCode = preferences.getString("localizationCountryCode") ?? "US";
    localizationLanguageCode = preferences.getString("localizationLanguageCode") ?? "en";
    isDarkTheme = preferences.getBool("isDarkTheme") ?? false;

    selectedBgColor = preferences.getString("selectedBgColor") ?? "";
    selectedButtonColor = preferences.getString("selectedButtonColor") ?? "";
    selectedTextColor = preferences.getString("selectedTextColor") ?? "";



    // log("localizationCountryCode: $localizationCountryCode");
    // log("localizationLanguageCode: $localizationLanguageCode");

    if (kDebugMode) {
      print(userId);
    }
  }


  ///<<<======================== Remove All and Get All again Data Form Shared Preference ============>

  static Future<void> removeAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    preferences.setString("token", "");
    preferences.setString("refreshToken", "");
    preferences.setString("userId", "");
    preferences.setString("myImage", "");
    preferences.setString("myName", "");
    preferences.setString("myEmail", "");
    preferences.setBool("isLogIn", false);
    preferences.setBool("adminVerified", false);
    preferences.setBool("subscription", false);
    //preferences.setBool("isNotifications", true);
    //preferences.setString("mySubscription", "shopping");
    preferences.setStringList("interests", []);
    preferences.setStringList("photos", []);
    preferences.setStringList("phoneCountryCode", []);
    preferences.setString("address", "");
    preferences.setString("paypalEmail", "");
    preferences.setString("latitude", "");
    preferences.setString("longitude", "");

    preferences.setBool("isDarkTheme", false);

    preferences.setDouble("rating", 0);
    preferences.setDouble("points", 0);

    preferences.setString("selectedBgColor", "");
    preferences.setString("selectedButtonColor", "");
    preferences.setString("selectedTextColor", "");


    // Get.offAllNamed(AppRoutes.signInScreen);
    getAllPrefData();
  }


  ///<<<======================== Get Data Form Shared Preference ==============>

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key) ?? (-1);
  }

  static Future<List<String>> getStringList(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key) ?? [];
  }

  ///<<<=====================Save Data To Shared Preference=====================>

  static Future<void> setStringList(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(key, value);
  }

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  static Future setDouble(String key, double value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setDouble(key, value);
  }

  ///<<<==========================Remove Value==================================>

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  // Clear all data from SharedPreferences
  static Future<void> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Language >>>>>>>>>>>>>>>>>>>>>>>>>>>





}
