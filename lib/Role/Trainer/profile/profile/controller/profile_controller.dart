import 'package:get/get.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_images.dart';
import '../../../auth/sign_in/screen/sign_in_screen.dart';

class ProfileController extends GetxController{

  // role: { type: String, enum: ['trainee', 'trainer', 'user', 'admin', 'elitoppc'], default: 'user' },

  String? role;
   RxString profileImage = AppImages.serviceShortPhoto.obs;

  // Logout Functionality
  Future<void> logout() async {
    PrefsHelper.clear();
    // Navigate to LoginScreen
    Get.offAll(() => SignInScreen());
  }



}