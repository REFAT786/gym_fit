import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainer/nav/screen/nav_bar_screen.dart';
import '../../color/controller/color_controller.dart';
import '../../nav/screen/trainee_nav_bar_screen.dart';

class TraineeCompleteSuccessfullyScreen extends StatelessWidget {
  const TraineeCompleteSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        body: Center(  // Center everything in the screen
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Vertically center content
              crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center content
              children: [
                Image.asset(AppImages.fireImage, height: 100, width: 100),
                SizedBox(height: 10),
                Text(
                  AppString.completedSuccessfully,
                  style: styleForText.copyWith(fontSize: 28),
                ),
                SizedBox(height: 20), // Space between the text and the button
                InkWell(
                  onTap: () {
                    if(PrefsHelper.myRole=="trainee"){
                      Get.off(TraineeNavBarScreen());
                    }else{
                      Get.off(NavBarScreen());
                    }

                  },
                  child: CustomButton(
                    backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                    textColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.primary,
                    buttonText: AppString.returnToHome,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
