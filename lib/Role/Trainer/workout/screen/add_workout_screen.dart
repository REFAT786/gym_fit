
import 'package:flutter/material.dart';
import '../../../../Common/widgets/custom_add_workout_popup.dart';
import '../../../../Common/widgets/custom_button.dart';
import '../../../../Common/widgets/custom_text_field.dart';
import '../../../../Common/widgets/custom_title_bar.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Common/widgets/custom_workout_list_tile.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainee/color/controller/color_controller.dart';
import '../widget/show_filter_dialog_box.dart';

class AddWorkoutScreen extends StatelessWidget {
  AddWorkoutScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTrainerGradientBackgroundColor(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10, left: 10, right: 10),
              child: CustomTitleBar(title: AppString.addWorkout),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                backgroundColor: PrefsHelper.myRole=='trainee'?AppColors.traineeNavBArColor:Color(0xff033a5b),
                prefixIcon: Icons.search,
                hintText: AppString.searchWorkout,
                isSuffix: false,
                controller: searchController,
              ),
            ),
            const SizedBox(height: 10),
            // Wrap the filters and ListView in an Expanded widget
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            showFilterDialogBox(context);  // Open the filter dialog box
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.filter_list, color: PrefsHelper.myRole=="trainee"?AppColors.white:Colors.black,),
                                SizedBox(width: 4),
                                Text(AppString.allTypes, style: styleForText.copyWith(fontSize: 16, color:PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():Colors.black),),
                              ],
                            ),
                          )
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Wrap ListView.builder in Expanded to give it bounded height
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: 9,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        bool isChecked = false; // Default checkbox state

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              PrefsHelper.myRole=="trainee"?null:showDialog(
                                context: context,
                                builder: (context) => CustomAddWorkoutPopup(),
                              );
                            },
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return CustomWorkoutListTile(
                                  isEditButton: false,
                                  isArrowButton: false,
                                  leadingImage: AppImages.serviceShortPhoto,
                                  gymCategory: "Title",
                                  showCheckbox: PrefsHelper.myRole=="trainee"?true:false, // Enable checkbox
                                  checkboxValue: isChecked,
                                  onCheckboxChanged: (value) {
                                    setState(() {
                                      isChecked = value ?? false; // Toggle checkbox value
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if(PrefsHelper.myRole=="trainee")
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (context) => CustomAddWorkoutPopup(),
                          );
                        },
                        child: CustomButton(backgroundColor: ColorController.instance.getButtonColor(),
                            textColor: ColorController.instance.getTextColor(),
                            buttonText: AppString.addExercise
                        ),
                      ),
                    )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}