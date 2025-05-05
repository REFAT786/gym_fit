import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Helpers/prefs_helper.dart';
import '../../Role/Trainee/color/controller/color_controller.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_string.dart';
import '../../Utils/styles.dart';
import 'custom_text_field.dart'; // Ensure this import exists and points to your styles file

class CustomAddWorkoutPopup extends StatelessWidget {
  CustomAddWorkoutPopup({super.key});

  final TextEditingController setController = TextEditingController();
  final TextEditingController repController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController restController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary, width: 2), // Cyan border
      ),
      backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.selectedBgColor.value=="default"?AppColors.black:AppColors.black:AppColors.dialogBoxBg, // Dark blue background
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPopupItem(AppString.sets, setController, AppString.enterSets),
            _buildPopupItem(AppString.reps, repController, AppString.reps),
            _buildPopupItem(AppString.weight, weightController, AppString.weight),
            _buildPopupItem(AppString.rests, restController, AppString.enterRests),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {

            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary, // Cyan button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(double.infinity, 50), // Full width button
          ),
          child:  Text(
            AppString.addWorkout,
            style: styleForText.copyWith(color: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.primary),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              Get.back();
            },
            child:  Text(
             AppString.cancel,
              style: styleForText.copyWith(color: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.secondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPopupItem(String title, TextEditingController controller, String hintText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: styleForText.copyWith(fontSize: 20, color: ColorController.instance.getTextColor(), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
            hintText: hintText,
            isSuffix: false,
            controller: controller,
          ),
        ],
      ),
    );
  }
}