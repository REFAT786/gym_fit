import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helpers/prefs_helper.dart';
import '../../Role/Trainee/color/controller/color_controller.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/styles.dart';
import 'custom_back_button.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () => Get.back(),
            child: CustomBackButton()),
        Expanded(  // This ensures the Text is centered
          child: Text(
            title,
            style: styleForText.copyWith(fontSize: 24, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
