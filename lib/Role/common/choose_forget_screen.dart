import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';

import '../../Common/widgets/custom_button.dart';
import '../../Common/widgets/custom_title_bar.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_string.dart';

class ChooseForgetScreen extends StatelessWidget {
  const ChooseForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff056aa6), Color(0xff035c86), Color(0xff02304b)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1.0], // Smooth blending
            )
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: (){Get.toNamed(RoutesName.forgetEmailScreen, arguments: {'status': "password"});},
                  buttonText: AppString.forgetPassword,
                  textColor: AppColors.primary,
                  backgroundColor: AppColors.secondary,
                ),
                SizedBox(height: 20,),
                CustomButton(
                  onTap: (){Get.toNamed(RoutesName.forgetEmailScreen, arguments: {'status': "pin"});},
                  buttonText: AppString.forgetPin,
                  textColor: AppColors.primary,
                  backgroundColor: AppColors.secondary,
                ),
              ],
            ),
            Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 16),
                  child: CustomTitleBar(title: ""),
                )
            )
          ],
        ),
      ),

    );
  }
}
