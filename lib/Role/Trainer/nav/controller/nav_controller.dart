import 'package:get/get.dart';

class NavController extends GetxController {
  var isHomeActive = true.obs;
  var isGymActive = false.obs;
  var isProfileActive = false.obs;

  void updateActiveTab(String tab) {
    isHomeActive.value = (tab == 'home');
    isGymActive.value = (tab == 'gym');
    isProfileActive.value = (tab == 'profile');
  }
}
