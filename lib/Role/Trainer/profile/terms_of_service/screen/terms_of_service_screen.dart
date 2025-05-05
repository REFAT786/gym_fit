import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Common/widgets/custom_back_button.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../../../../Trainee/color/controller/color_controller.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: (){Get.back();},
                icon: CustomBackButton()
            ),
            title: Text(
              AppString.termsOfService,
              style: styleForText.copyWith(
                  fontSize: 24
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Text("1. Types of Data We Collect", style: styleForText.copyWith(color: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.white, fontSize: 16),),
                  const SizedBox(height: 10,),
                  Text("Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect", style: styleForText.copyWith(fontWeight: FontWeight.w400,fontSize: 14)),
                  SizedBox(height: 10,),
                  Text("1. Types of Data We Collect",style: styleForText.copyWith(color: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.white, fontSize: 16)),
                  const SizedBox(height: 10,),
                  Text("Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect", style: styleForText.copyWith(fontWeight: FontWeight.w400,fontSize: 14)),
                  SizedBox(height: 10,),
                  Text("1. Types of Data We Collect", style: styleForText.copyWith(color: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.white, fontSize: 16)),
                  const SizedBox(height: 10,),
                  Text("Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect", style: styleForText.copyWith(fontWeight: FontWeight.w400,fontSize: 14)),
                  SizedBox(height: 10,),
                  Text("1. Types of Data We Collect", style: styleForText.copyWith(color: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.white, fontSize: 16)),
                  const SizedBox(height: 10,),
                  Text("Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect Types of Data We Collect", style: styleForText.copyWith(fontWeight: FontWeight.w400,fontSize: 14)),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          )),
    );
  }
}
