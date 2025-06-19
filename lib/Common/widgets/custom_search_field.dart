import 'package:flutter/material.dart';

import '../../Helpers/prefs_helper.dart';
import '../../Role/Trainee/color/controller/color_controller.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_string.dart';
import '../../Utils/styles.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, required this.searchController, this.qrPressed, this.color});

  final TextEditingController searchController;
  final Function()? qrPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.traineeNavBArColor,
          borderRadius: BorderRadius.circular(40)
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            prefixIcon: Icon(Icons.search, color: AppColors.white,),
            hintText: AppString.search,
            hintStyle: styleForText.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
            suffixIcon: IconButton(onPressed: qrPressed, icon: Icon(Icons.qr_code), color: color,)
        ),
      ),
    );
  }
}
