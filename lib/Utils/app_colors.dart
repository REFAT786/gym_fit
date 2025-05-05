import 'dart:ui';


import '../Helpers/prefs_helper.dart';

class AppColors{
  AppColors._();

  static const Color primary = Color(0xff033a5b);
  static const Color dialogBoxBg = Color(0xff035c86);

  static const Color secondary = Color(0xff00edf9);

  static Color white = Color(0xffffffff);
  static Color textColor = Color(0xffffffff);

  static const Color black = Color(0xff121212);
  static const Color grey = Color(0xff6e7376);
  static const Color buttonTextColor = Color(0xff022940);

  static const Color bottomNavColor = Color(0xff000d14);

  static Color iconColor = PrefsHelper.myRole=="trainee"? AppColors.traineePrimaryColor:Color(0xffffffff);

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  static const Color traineeNavBArColor = Color(0xff262621);
  static const Color traineePrimaryColor = Color(0xffe63946);



}