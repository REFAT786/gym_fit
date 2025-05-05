import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../../Helpers/prefs_helper.dart';
import '../../Role/Trainee/color/controller/color_controller.dart';

class CustomTrainerGradientBackgroundColor extends StatelessWidget {
  final Widget child;

  const CustomTrainerGradientBackgroundColor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    if(PrefsHelper.myRole == 'trainer'){
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff056aa6),
              Color(0xff035c86),
              Color(0xff02304b)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0], // Smooth blending
          )
        ),
        child: child,
      );

    }else{
      return Obx(() {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorController.instance.getBgColor(),
                ColorController.instance.getBgColor(),
                ColorController.instance.getBgColor(),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.5, 1.0], // Smooth blending
            ),
          ),
          child: child,
        );
      },);


    }

  }
}
