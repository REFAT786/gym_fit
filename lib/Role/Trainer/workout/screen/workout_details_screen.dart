import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_history_container.dart';
import '../../../../Common/widgets/custom_text_field.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainee/color/controller/color_controller.dart';
import '../../../Trainee/trainee_complete_successfully/screen/trainee_complete_successfully_screen.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  WorkoutDetailsScreen({super.key});

  TextEditingController setController = TextEditingController();
  TextEditingController resController = TextEditingController();
  TextEditingController wightController = TextEditingController();
  TextEditingController repController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    log(">>>>>>>>>>>>>>>>>>>>>>>>> my role ${PrefsHelper.myRole}");
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: (){Get.back();}, icon: CustomBackButton()),
          title:Text( AppString.letsPush, style: styleForText.copyWith(fontSize: 24),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
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
                              imageSrc: "https://readmyfist.wordpress.com/wp-content/uploads/2012/12/core-muscles.jpg",
                              imageType: ImageType.network,
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomCommonImage(
                              imageSrc: "https://readmyfist.wordpress.com/wp-content/uploads/2012/12/core-muscles.jpg",
                              imageType: ImageType.network,
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomCommonImage(
                              imageSrc: "https://readmyfist.wordpress.com/wp-content/uploads/2012/12/core-muscles.jpg",
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
                        Text(
                          AppString.sets,
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        CustomTextField(
                            backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                            hintText: AppString.enterSets,
                            isSuffix: false,
                            controller: setController),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppString.reps,
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        CustomTextField(
                            backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                            hintText: AppString.enterReps,
                            isSuffix: false,
                            controller: repController),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppString.weight,
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        CustomTextField(
                            backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                            hintText: AppString.enterWeight,
                            isSuffix: false,
                            controller: wightController),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppString.rests,
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        CustomTextField(
                            backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                            hintText: AppString.enterReps,
                            isSuffix: false,
                            controller: resController),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppString.notes,
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: PrefsHelper.myRole == "trainee"
                                ? AppColors.traineeNavBArColor
                                : AppColors.primary,
                          ),
                          child: TextField(
                            maxLines: 3,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: AppString.notes,
                              hintStyle: styleForText.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppString.history,
                          style: styleForText.copyWith(fontSize: 25),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CustomHistoryContainer(),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(TraineeCompleteSuccessfullyScreen());
                            },
                            child: CustomButton(
                              buttonText: AppString.finishWorkout,
                              backgroundColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                              textColor: PrefsHelper.myRole == 'trainee'
                                  ? ColorController.instance.getTextColor()
                                  : AppColors.primary,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
