import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Helpers/prefs_helper.dart';
import 'package:gym_fit/Utils/app_url.dart';

import '../../../../Utils/app_images.dart';
import '../../profile/profile/screen/trainer_profile_details_screen.dart';

class TrainerHomeController extends GetxController {
  static TrainerHomeController get instance => Get.put(TrainerHomeController());

  RxString profileImage = "${AppUrl.baseUrl}${PrefsHelper.myImage}".obs;
  RxString profileName = PrefsHelper.myName.obs;
  RxString leadingImage = AppImages.serviceShortPhoto.obs;
  RxString listTileTitle = "Mr Gym".obs;
  RxString subTitle = "SubTitle".obs;
  RxString subTitleNext = "SubTitleNext".obs;

  Future<void> showListDetails() async {
    Get.to(TrainerProfileDetailsScreen());
  }
}
