import 'package:flutter/material.dart';

import '../../Utils/app_colors.dart';
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18, // Radius of the circle
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.primary,
        ),
      ),
    );
  }
}


