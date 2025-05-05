import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_list_tile.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';


import '../../../../Utils/app_images.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: (){Get.back();},
                icon: CustomBackButton()
            ),
            title: Text(
              AppString.notification,
              style: styleForText.copyWith(
                  fontSize: 24
              ),
            ),
            centerTitle: true,
          ),

          body: Column(
            children: [
              SizedBox(height: 10,),
              CustomListTile(leadingImage: AppImages.serviceShortPhoto,title: "Request",subTitle: "This is Notification",),
              SizedBox(height: 10,),
              CustomListTile(leadingImage: AppImages.serviceShortPhoto,title: "Request",subTitle: "This is Notification",),
              SizedBox(height: 10,),
              CustomListTile(leadingImage: AppImages.serviceShortPhoto,title: "Request",subTitle: "This is Notification",),
              SizedBox(height: 10,),
              CustomListTile(leadingImage: AppImages.serviceShortPhoto,title: "Request",subTitle: "This is Notification",),

            ],

          ),
        ),
      ),
    );
  }
}
