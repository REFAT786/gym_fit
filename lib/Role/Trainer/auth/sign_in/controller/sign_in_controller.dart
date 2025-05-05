import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../../../../Core/routes/routes_name.dart';
import '../../../../../Helpers/prefs_helper.dart';
class SignInController extends GetxController {
  // static SignInController get instance => Get.put(SignInController());

  //trainee, trainer

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isLoading = false;
  String role = "";

  Future<void> logIn() async {
    try {
      isLoading = true;
      update();

      // Check if email and password are correct for trainee or trainer
      if (emailTextEditingController.text == "trainee" && passwordTextEditingController.text == "123456") {
        role = "trainee";  // Corrected assignment
        PrefsHelper.myRole = role;  // Assign role to PrefsHelper
        PrefsHelper.setString("myRole", PrefsHelper.myRole);  // Save it to shared preferences
        // Get.offAll(() => OnBoardingScreen());
        Get.offAllNamed(RoutesName.onBoarding);
      } else if (emailTextEditingController.text == "trainer" && passwordTextEditingController.text == "123456") {
        role = "trainer";  // Corrected assignment
        PrefsHelper.myRole = role;  // Assign role to PrefsHelper
        PrefsHelper.setString("myRole", PrefsHelper.myRole);  // Save it to shared preferences
        // Get.offAll(() => NavBarScreen());
        Get.offAllNamed(RoutesName.navBar);
      } else {
        Get.snackbar("Required", "Please fill the form correctly");
        isLoading = false;
        update();
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    } finally {
      isLoading = false;
      update();
    }
  }


}
