import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../Common/widgets/custom_add_workout_popup.dart';
import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../color/controller/color_controller.dart';

class WorkoutPlanDetailScreen extends StatelessWidget {
  const WorkoutPlanDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: (){Get.back();}, icon: CustomBackButton()),
          title:Text( AppString.letsPush, style: styleForText.copyWith(fontSize: 24),),
          centerTitle: true,
        ),
        body: CustomTrainerGradientBackgroundColor(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
            child: Column(
              children: [
                // SizedBox(height: 40),
                Column(
                  children: [
      
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // border: Border.all(color: AppColors.secondary, width: 2),
                        borderRadius: BorderRadius.circular(16),
                        // color: AppColors.primary
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(
                            image: NetworkImage(AppImages.serviceCoverImage),
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.targetMuscles,
                            style: styleForText.copyWith(fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CustomCommonImage(
                                imageSrc: AppImages.muscle1,
                                imageType: ImageType.network,
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomCommonImage(
                                imageSrc: AppImages.muscle1,
                                imageType: ImageType.network,
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomCommonImage(
                                imageSrc: AppImages.muscle1,
                                imageType: ImageType.network,
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${AppString.whatIs} lat pull down",
                            style: styleForText.copyWith(fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: PrefsHelper.myRole == 'trainee'
                                    ? AppColors.traineeNavBArColor
                                    : AppColors.primary,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                                "data data data data data data data data data data data data data data data data data data data data data data data",
                                style: styleForText.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.normal)),
                          ),
                          Text(
                            AppString.equipment,
                            style: styleForText.copyWith(fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CustomCommonImage(
                                imageSrc: AppImages.equipment,
                                imageType: ImageType.network,
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomCommonImage(
                                imageSrc: AppImages.equipment,
                                imageType: ImageType.network,
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomCommonImage(
                                imageSrc: AppImages.equipment,
                                imageType: ImageType.network,
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          
                          InkWell(
                              onTap: () {
                                // PrefsHelper.myRole=="trainee"?null:
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomAddWorkoutPopup(),
                                );
                              },
                              child: CustomButton(backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary, textColor: ColorController.instance.getTextColor(), buttonText: AppString.addWorkout))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
