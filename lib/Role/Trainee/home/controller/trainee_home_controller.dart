import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../Utils/app_images.dart';

class TraineeHomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  var profileImage = "".obs;  // Make it observable
  var profileName = "".obs;   // Make it observable

  @override
  void onInit() {
    super.onInit();
    _loadUserData(); // Load user data when controller initializes
  }

  void _loadUserData() {
    // Fetch data from storage or API (update with actual data source)
    profileImage.value = AppImages.serviceShortPhoto; // Default image
    profileName.value = "Hi Jack"; // Default name
  }
}
