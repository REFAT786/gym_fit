import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Helpers/prefs_helper.dart';
import '../../Role/Trainee/color/controller/color_controller.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_icons.dart';
import '../../Utils/styles.dart';
import 'custom_common_image.dart';

class CustomWorkoutListTile extends StatelessWidget {
  final String? leadingImage;
  final String? station;
  final String? gymCategory;
  final String? gymSet;
  final bool isEditButton;
  final bool isArrowButton;
  final bool showCheckbox;
  final ValueChanged<bool?>? onCheckboxChanged;
  final bool checkboxValue;

  CustomWorkoutListTile({
    super.key,
    this.leadingImage,
    this.station = '',
    this.gymCategory = '',
    this.gymSet = '',
    required this.isEditButton,
    required this.isArrowButton,
    this.showCheckbox = false,
    this.onCheckboxChanged,
    this.checkboxValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: PrefsHelper.myRole == "trainee" ? AppColors.traineeNavBArColor : AppColors.primary,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image part
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomCommonImage(
              imageSrc: "$leadingImage",
              imageType: ImageType.network,
              size: 80,
            ),
          ),

          SizedBox(width: 10),
          // Text part
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$station",
                  style: styleForText.copyWith(fontSize: 14, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                ),
                SizedBox(height: 5),
                Text(
                  "$gymCategory",
                  style: styleForText.copyWith(fontSize: 20, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                ),
                SizedBox(height: 8),
                Text(
                  "$gymSet",
                  style: styleForText.copyWith(fontSize: 16, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
                ),
              ],
            ),
          ),

          // Checkbox (only visible when showCheckbox is true)
          if (showCheckbox)
            Checkbox(
              value: checkboxValue,
              onChanged: onCheckboxChanged,
              activeColor: AppColors.traineePrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3), // Adjusted to match your image
              ),
              side: BorderSide(color: ColorController.instance.getButtonColor()),
            ),

          // Edit button
          if (isEditButton)
            SvgPicture.asset(
              AppIcons.editIcon,
            ),
          if(isArrowButton)
            Icon(Icons.arrow_forward_ios_outlined, color: ColorController.instance.getButtonColor(),)

        ],
      ),
    );
  }
}
