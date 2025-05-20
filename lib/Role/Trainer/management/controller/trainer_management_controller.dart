import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Model/profile_model.dart';
import 'package:gym_fit/Repository/user_repository.dart';


import '../../../../Utils/app_images.dart';

class TrainerManagementController extends GetxController{

  final UserRepository userRepository = UserRepository();
  TextEditingController searchController = TextEditingController();

  var usersList = <ProfileModel>[].obs;
  var filteredList = <ProfileModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    searchController.addListener(_searchListener);
  }
  void _searchListener() {
    String query = searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      filteredList.assignAll(usersList);
    } else {
      filteredList.assignAll(
        usersList.where((user) => user.fullName.toLowerCase().contains(query)),
      );
    }
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      final response = await userRepository.getTraineeManagement(showMessage: true);
      if (response?.statusCode == 200 && response?.data != null) {
        final list = response!.data['attributes']['userList'] as List<dynamic>;
        usersList.assignAll(list.map((e) => ProfileModel.fromJson(e)).toList());
        filteredList.assignAll(usersList);
      } else {
        usersList.clear();
        filteredList.clear();
      }
    } catch (e, s) {
      log("Error fetching trainee management: $e");
      log(s.toString());
      usersList.clear();
      filteredList.clear();
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }


}