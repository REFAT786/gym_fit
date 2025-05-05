import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/app_images.dart';
import '../../profile/profile/screen/trainer_profile_details_screen.dart';

class TrainerHomeController extends GetxController{
  static TrainerHomeController get instance => Get.put(TrainerHomeController());

  String profileImage = AppImages.serviceShortPhoto;
  String profileName = "Profile Name";
  String leadingImage = AppImages.serviceShortPhoto;
  String listTileTitle = "Mr Gym";
  String subTitle = "SubTitle";
  String subTitleNext = "SubTitleNext";
  IconData trailingIcon = Icons.arrow_forward_ios_outlined;

  Future<void> showListDetails() async{
    Get.to(TrainerProfileDetailsScreen());
  }

}